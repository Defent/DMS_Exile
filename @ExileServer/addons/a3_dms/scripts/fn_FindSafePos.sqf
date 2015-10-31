/*
	DMS_fnc_FindSafePos
	Created by eraser1
	

	ALL PARAMETERS ARE OPTIONAL (as long as configs are properly defined).
	Excluding parameters will create some RPT spam, but it's not too much of an issue.

	Usage:
	[
		_nearestObjectMinDistance,	// NUMBER (distance): Minimum distance from the nearest object.
		_waterNearLimit,			// NUMBER (distance): Minimum distance from water.
		_minSurfaceNormal,			// NUMBER (between 0-1): Maximum "surfaceNormal"; Basically determines how steep a position is. Check the comment for config value "DMS_MinSurfaceNormal" in config.sqf for more info
		_spawnZoneNearLimit,		// NUMBER (distance): Minimum distance from a spawn point.
		_traderZoneNearLimit,		// NUMBER (distance): Minimum distance from a trader zone.
		_missionNearLimit,			// NUMBER (distance): Minimum distance from another mission.
		_playerNearLimit,			// NUMBER (distance): Minimum distance from a player.
		_throttleParams				// BOOLEAN: Whether or not some of the distance values should be throttled on repeated attempts.
		_waterSpawn					// (OPTIONAL) BOOLEAN: Whether or not the mission is supposed to spawn on water. Default: false
	] call DMS_fnc_findSafePos;
*/


private ["_nearestObjectMinDistance", "_waterNearLimit", "_minSurfaceNormal", "_spawnZoneNearLimit", "_traderZoneNearLimit", "_missionNearLimit", "_playerNearLimit", "_territoryNearLimit", "_throttleParams", "_waterSpawn", "_isValidSpot", "_attempts", "_pos", "_restriction", "_generatePos", "_presetLocs", "_presetLocsLength"];

params
[
	["_nearestObjectMinDistance",	25,							[0] ],
	["_waterNearLimit",				DMS_WaterNearBlacklist,		[0] ],
	["_minSurfaceNormal",			DMS_MinSurfaceNormal,		[0] ],
	["_spawnZoneNearLimit",			DMS_SpawnZoneNearBlacklist, [0]	],
	["_traderZoneNearLimit",		DMS_TraderZoneNearBlacklist,[0] ],
	["_missionNearLimit",			DMS_MissionNearBlacklist,	[0] ],
	["_playerNearLimit",			DMS_PlayerNearBlacklist,	[0] ],
	["_territoryNearLimit",			DMS_TerritoryNearBlacklist,	[0]	],
	["_throttleParams",				DMS_ThrottleBlacklists,		[true]]
];


_waterSpawn = if ((count _this)>9) then {_this select 9} else {false};

_isValidSpot = false;
_attempts = 0;
_restriction = if (_waterSpawn) then {2} else {0};

_presetLocsLength = 0;
if (DMS_UsePredefinedMissionLocations) then
{
	// Shuffle the array so that the positions are selected in random order
	_presetLocs = ([] + DMS_PredefinedMissionLocations) call ExileClient_util_array_shuffle;
	_presetLocsLength = count _presetLocs;
};

_generatePos =
{
	if (DMS_UsePredefinedMissionLocations && {_attempts<=_presetLocsLength}) then
	{
		_presetLocs select (_attempts - 1)
	}
	else
	{
		[DMS_MinMax_X_Coords call DMS_fnc_SelectRandomVal,DMS_MinMax_Y_Coords call DMS_fnc_SelectRandomVal] isFlatEmpty [_nearestObjectMinDistance, 0, 9999, 1, _restriction, _waterSpawn, objNull]
	};
};

while{!_isValidSpot} do
{
	_attempts = _attempts+1;


	_pos = [];

	while {_pos isEqualTo []} do
	{
		_pos = call _generatePos;
	};


	// It will only throttle the missionNear blacklist and playerNear limits because those are the most likely to throw an exception.
	// The throttling works by decreasing the parameters by 10% every 15 attempts, until it reaches 100 meters (by default).
	if (_throttleParams && {(_attempts>=DMS_AttemptsUntilThrottle) && {(_attempts%DMS_AttemptsUntilThrottle)==0}}) then
	{
		_missionNearLimit = (DMS_ThrottleCoefficient * _missionNearLimit) max DMS_MinThrottledDistance;
		_playerNearLimit = (DMS_ThrottleCoefficient * _playerNearLimit) max DMS_MinThrottledDistance;

		// SurfaceNormal is a bit more tricky than distances, so it's throttled differently. To convert from degrees to surfaceNormal, you take the cosine of the degrees from horizontal. Take the arc-cosine to convert surfaceNormal to degrees: arccos(0.8) in degrees ~= 37
		_minSurfaceNormal = (_minSurfaceNormal - 0.005) max 0.8;

		if (DMS_DEBUG) then
		{
			(format ["FindSafePos :: Throttling _missionNearLimit to %1 and _playerNearLimit to %2 and _minSurfaceNormal to %4 after %3 failed attempts to find a safe position!",_missionNearLimit,_playerNearLimit,_attempts,_minSurfaceNormal]) call DMS_fnc_DebugLog;
		};
	};

	_isValidSpot = [_pos, _waterNearLimit, _minSurfaceNormal, _spawnZoneNearLimit, _traderZoneNearLimit, _missionNearLimit, _playerNearLimit, _territoryNearLimit, _waterSpawn] call DMS_fnc_IsValidPosition;
};

_pos set [2,0];


if (DMS_DEBUG) then
{
	(format["FindSafePos :: Found mission position %1 in %2 attempts. _this: %3",_pos,_attempts,_this]) call DMS_fnc_DebugLog;
};


_pos;