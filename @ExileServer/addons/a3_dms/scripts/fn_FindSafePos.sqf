/*
	DMS_fnc_FindSafePos
	Created by eraser1
	

	ALL PARAMETERS ARE OPTIONAL (as long as configs are properly defined).
	Excluding parameters will create some RPT spam, but it's not too much of an issue.

	Usage:
	[
		_nearestObjectMinDistance,	// NUMBER (distance): Minimum distance from the nearest object.
		_waterNearLimit,			// NUMBER (distance): Minimum distance from water.
		_maxSurfaceNormal,			// NUMBER (between 0-1): Maximum "surfaceNormal"; Basically determines how steep a position is. Check the comment for config value "DMS_MaxSurfaceNormal" in config.sqf for more info
		_spawnZoneNearLimit,		// NUMBER (distance): Minimum distance from a spawn point.
		_traderZoneNearLimit,		// NUMBER (distance): Minimum distance from a trader zone.
		_missionNearLimit,			// NUMBER (distance): Minimum distance from another mission.
		_playerNearLimit,			// NUMBER (distance): Minimum distance from a player.
		_throttleParams				// BOOLEAN: Whether or not some of the distance values should be throttled on repeated attempts.
	] call DMS_fnc_findSafePos;
*/


private ["_nearestObjectMinDistance", "_waterNearLimit", "_maxSurfaceNormal", "_spawnZoneNearLimit", "_traderZoneNearLimit", "_missionNearLimit", "_playerNearLimit", "_throttleParams", "_safePosParams", "_validspot", "_attempts", "_pos"];

params
[
	["_nearestObjectMinDistance",	25,							[0] ],
	["_waterNearLimit",				DMS_WaterNearBlacklist,		[0] ],
	["_maxSurfaceNormal",			DMS_MaxSurfaceNormal,		[0] ],
	["_spawnZoneNearLimit",			DMS_SpawnZoneNearBlacklist, [0]	],
	["_traderZoneNearLimit",		DMS_TraderZoneNearBlacklist,[0] ],
	["_missionNearLimit",			DMS_MissionNearBlacklist,	[0] ],
	["_playerNearLimit",			DMS_PlayerNearBlacklist,	[0] ],
	["_throttleParams",				DMS_ThrottleBlacklists,		[true]]
];


// Some custom maps don't have the proper safePos config entries.
// If you are using one and you have an issue with mission spawns, please create an issue on GitHub or post a comment in the DMS thread.
switch (toLower worldName) do
{ 
	case "altis":		{ _safePosParams = [[16000,16000],0,16000]; };		// [16000,16000] w/ radius of 16000 works well for Altis
	case "bornholm":	{ _safePosParams = [[11265,11265],0,12000]; };		// Thanks to thirdhero for testing this info
	case "esseker":		{ _safePosParams = [[6275,6350,0],0,5000];  };		// Thanks to Flowrider for this info
	case "tavi":		{ _safePosParams = [[12800,12800],0,12800]; };		// Thanks to JamieKG for this info
	default 			{ _safePosParams = [[],0,-1]; };					// Use default BIS_fnc_findSafePos methods for finding map center (worldSize)
};

_safePosParams append [_nearestObjectMinDistance,0,9999,0,DMS_findSafePosBlacklist];


_validspot 	= false;
_attempts 	= 0;

while{!_validspot} do
{
	_pos = _safePosParams call BIS_fnc_findSafePos;
	_attempts = _attempts+1;

	// It will only throttle the missionNear blacklist and playerNear limits because those are the most likely to throw an exception.
	// The throttling works by decreasing the parameters by 10% every 15 attempts, until it reaches 100 meters (by default).
	if (_throttleParams && {(_attempts>=DMS_AttemptsUntilThrottle) && {(_attempts%DMS_AttemptsUntilThrottle)==0}}) then
	{
		_missionNearLimit = (DMS_ThrottleCoefficient * _missionNearLimit) max DMS_MinThrottledDistance;
		_playerNearLimit = (DMS_ThrottleCoefficient * _playerNearLimit) max DMS_MinThrottledDistance;

		if (DMS_DEBUG) then
		{
			diag_log format ["DMS_DEBUG FindSafePos :: Throttling _missionNearLimit to %1 and _playerNearLimit to %2 after %3 failed attempts to find a safe position! FPS: %4",_missionNearLimit,_playerNearLimit,_attempts,diag_fps];
		};
	};

	_validspot = [_pos, _waterNearLimit, _maxSurfaceNormal, _spawnZoneNearLimit, _traderZoneNearLimit, _missionNearLimit, _playerNearLimit] call DMS_fnc_IsValidPosition;
};


if(DMS_DEBUG) then
{
	diag_log format["DMS_DEBUG FindSafePos :: Found mission position %1 with %2 params in %3 attempts. _this: %4",_pos,_safePosParams,_attempts,_this];
};


_pos set [2, 0];
_pos;