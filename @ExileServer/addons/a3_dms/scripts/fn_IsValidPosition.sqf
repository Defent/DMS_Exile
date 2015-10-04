/*
	DMS_fnc_IsValidPosition
	Created by eraser1

	Usage:
	[
		_pos,						// ARRAY (position): The position to check.
		_waterNearLimit,			// NUMBER (distance): Minimum distance from water.
		_maxSurfaceNormal,			// NUMBER (between 0-1): Maximum "surfaceNormal"; Basically determines how steep a position is. Check the comment for config value "DMS_MaxSurfaceNormal" in config.sqf for more info
		_spawnZoneNearLimit,		// NUMBER (distance): Minimum distance from a spawn point.
		_traderZoneNearLimit,		// NUMBER (distance): Minimum distance from a trader zone.
		_missionNearLimit,			// NUMBER (distance): Minimum distance from another mission.
		_playerNearLimit,			// NUMBER (distance): Minimum distance from a player.
	] call DMS_fnc_IsValidPosition;



*/

private ["_pos", "_waterNearLimit", "_maxSurfaceNormal", "_spawnZoneNearLimit", "_traderZoneNearLimit", "_missionNearLimit", "_playerNearLimit"];

_OK = params
[
	["_pos", 						[0,0,0],		[[]],		[2,3]],
	["_waterNearLimit",				DMS_WaterNearBlacklist,		[0] ],
	["_maxSurfaceNormal",			DMS_MaxSurfaceNormal,		[0] ],
	["_spawnZoneNearLimit",			DMS_SpawnZoneNearBlacklist, [0]	],
	["_traderZoneNearLimit",		DMS_TraderZoneNearBlacklist,[0] ],
	["_missionNearLimit",			DMS_MissionNearBlacklist,	[0] ],
	["_playerNearLimit",			DMS_PlayerNearBlacklist,	[0] ]
];


_isValidPos = false;

if (!_OK) then
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_isValidPosition with invalid parameters: %1",_this];
}
else
{
	try
	{
		// Check for nearby water
		if ((_waterNearLimit>0) && {[_pos,_waterNearLimit] call DMS_fnc_isNearWater}) then 
		{
			throw ("water");
		};

		// Terrain steepness check
		if (((surfaceNormal _pos) select 2)<_maxSurfaceNormal) then
		{
			throw ("a steep location");
		};
		
		{
			// Check for nearby spawn points
			if ((_spawnZoneNearLimit>0) && {((markertype _x) == "ExileSpawnZone") && {((getMarkerPos _x) distance2D _pos)<=_spawnZoneNearLimit}}) then
			{
				throw ("a spawn zone");
			};

			// Check for nearby trader zones
			if ((_traderZoneNearLimit>0) && {((markertype _x) == "ExileTraderZone") && {((getMarkerPos _x) distance2D _pos)<=_traderZoneNearLimit}}) then
			{
				throw ("a trader zone");
			};

			// Check for nearby missions
			if (_missionNearLimit>0) then
			{
				_missionPos = missionNamespace getVariable [format ["%1_pos",_x], []];
				if (!(_missionPos isEqualTo []) && {(_missionPos distance2D _pos)<=_missionNearLimit}) then
				{
					throw ("another mission");
				};
			};
		} forEach allMapMarkers;
		
		// Check for nearby players
		// This is done last because it is likely to be the most resource intensive.
		if ((_playerNearLimit>0) && {[_pos,_playerNearLimit] call DMS_fnc_IsPlayerNearby}) then
		{
			throw ("players");
		};

		// No exceptions found
		_isValidPos	= true;
	}
	catch
	{
		if (DMS_DEBUG) then
		{
			diag_log format ["DMS_DEBUG IsValidPosition :: Exception in attempt %1 | Position %2 is too close to %3!",_attempts,_pos,_exception];
		};
	};
};


_isValidPos;