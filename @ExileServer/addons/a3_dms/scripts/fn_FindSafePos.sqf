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
		_territoryNearLimit,		// NUMBER (distance): Minimum distance from a territory.
		_throttleParams				// BOOLEAN: Whether or not some of the distance values should be throttled on repeated attempts.
	] call DMS_fnc_findSafePos;
*/
#define MAX_ATTEMPTS 5000

params
[
	["_nearestObjectMinDistance",	5,							[0] ],
	["_waterNearLimit",				DMS_WaterNearBlacklist,		[0] ],
	["_minSurfaceNormal",			DMS_MinSurfaceNormal,		[0] ],
	["_spawnZoneNearLimit",			DMS_SpawnZoneNearBlacklist, [0]	],
	["_traderZoneNearLimit",		DMS_TraderZoneNearBlacklist,[0] ],
	["_missionNearLimit",			DMS_MissionNearBlacklist,	[0] ],
	["_playerNearLimit",			DMS_PlayerNearBlacklist,	[0] ],
	["_territoryNearLimit",			DMS_TerritoryNearBlacklist,	[0]	],
	["_throttleParams",				DMS_ThrottleBlacklists,		[true]]
];

/*
if (!isNil "DMS_DebugMarkers") then
{
	{deleteMarker _x} forEach DMS_DebugMarkers;
};
DMS_DebugMarkers = [];
*/

private _isValidSpot = false;

private _presetLocs = [];
private _presetLocsLength = 0;

if (DMS_UsePredefinedMissionLocations) then
{
	// Shuffle the array so that the positions are selected in random order
	_presetLocs = DMS_PredefinedMissionLocations call ExileClient_util_array_shuffle;
	_presetLocsLength = count _presetLocs;
};


private _pos = [];

for "_attempts" from 1 to MAX_ATTEMPTS do
{
	_pos =
		if (DMS_UsePredefinedMissionLocations && {_attempts<=_presetLocsLength}) then
		{
			_presetLocs select (_attempts - 1)
		}
		else
		{
			[DMS_MinMax_X_Coords call DMS_fnc_SelectRandomVal,DMS_MinMax_Y_Coords call DMS_fnc_SelectRandomVal] isFlatEmpty [_nearestObjectMinDistance, -1, -1, 1, -1, false, objNull]
		};

	/*
	_dot = createMarker [format ["DMS_DebugMarker_attempt%1", _attempts], _pos];
	_dot setMarkerColor "ColorWEST";
	_dot setMarkerType "mil_dot";
	_dot setMarkerText format["Attempt #%1",_attempts];
	DMS_DebugMarkers pushBack _dot;
	*/


	// It will only throttle the missionNear blacklist and playerNear limits because those are the most likely to throw an exception.
	// The throttling works by decreasing the parameters by 10% every 15 attempts, until it reaches 100 meters (by default).
	if (_throttleParams && {(_attempts>=DMS_AttemptsUntilThrottle) && {(_attempts%DMS_AttemptsUntilThrottle)==0}}) then
	{
		_missionNearLimit = (DMS_ThrottleCoefficient * _missionNearLimit) max DMS_MinThrottledDistance;
		_playerNearLimit = (DMS_ThrottleCoefficient * _playerNearLimit) max DMS_MinThrottledDistance;

		// SurfaceNormal is a bit more tricky than distances, so it's throttled differently. To convert from degrees to surfaceNormal, you take the cosine of the degrees from horizontal. Take the arc-cosine to convert surfaceNormal to degrees: arccos(0.8) in degrees ~= 37
		_minSurfaceNormal = (_minSurfaceNormal - 0.005) max 0.75;

		if (DMS_DEBUG) then
		{
			(format ["FindSafePos :: Throttling _missionNearLimit to %1 and _playerNearLimit to %2 and _minSurfaceNormal to %4 after %3 failed attempts to find a safe position!",_missionNearLimit,_playerNearLimit,_attempts,_minSurfaceNormal]) call DMS_fnc_DebugLog;
		};
	};

	_isValidSpot = [_pos, _waterNearLimit, _minSurfaceNormal, _spawnZoneNearLimit, _traderZoneNearLimit, _missionNearLimit, _playerNearLimit, _territoryNearLimit, DMS_MixerNearBlacklist, DMS_ContaminatedZoneNearBlacklist] call DMS_fnc_IsValidPosition;

	if (_isValidSpot) exitWith
	{
		if (DMS_DEBUG) then
		{
			(format["FindSafePos :: Found mission position %1 in %2 attempts. _this: %3",_pos,_attempts,_this]) call DMS_fnc_DebugLog;
		};
	};
};

if !(_isValidSpot) exitWith
{
	diag_log format["DMS ERROR :: Number of attempts in DMS_fnc_findSafePos (%1) reached maximum number of attempts!",MAX_ATTEMPTS];
};

_pos set [2,0];


_pos;
