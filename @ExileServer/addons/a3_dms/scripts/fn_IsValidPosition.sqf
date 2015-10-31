/*
	DMS_fnc_IsValidPosition
	Created by eraser1

	Usage:
	[
		_pos,						// ARRAY (position): The position to check.
		_waterNearLimit,			// NUMBER (distance): Minimum distance from water.
		_minSurfaceNormal,			// NUMBER (between 0-1): Maximum "surfaceNormal"; Basically determines how steep a position is. Check the comment for config value "DMS_MinSurfaceNormal" in config.sqf for more info
		_spawnZoneNearLimit,		// NUMBER (distance): Minimum distance from a spawn point.
		_traderZoneNearLimit,		// NUMBER (distance): Minimum distance from a trader zone.
		_missionNearLimit,			// NUMBER (distance): Minimum distance from another mission.
		_playerNearLimit,			// NUMBER (distance): Minimum distance from a player.
		_waterSpawn					// BOOLEAN: Whether or not the mission is supposed to spawn on water.
	] call DMS_fnc_IsValidPosition;

	All parameters except "_pos" are optional.

	Returns whether or not the provided position matches the parameters.
*/

private ["_pos", "_nearestObjectMinDistance", "_waterNearLimit", "_minSurfaceNormal", "_spawnZoneNearLimit", "_traderZoneNearLimit", "_missionNearLimit", "_playerNearLimit", "_territoryNearLimit", "_waterSpawn", "_isValidPos"];

_OK = params
[
	["_pos", 						[],				[[]],		[0,2,3]],
	["_waterNearLimit",				DMS_WaterNearBlacklist,		[0] ],
	["_minSurfaceNormal",			DMS_MinSurfaceNormal,		[0] ],
	["_spawnZoneNearLimit",			DMS_SpawnZoneNearBlacklist, [0]	],
	["_traderZoneNearLimit",		DMS_TraderZoneNearBlacklist,[0] ],
	["_missionNearLimit",			DMS_MissionNearBlacklist,	[0] ],
	["_playerNearLimit",			DMS_PlayerNearBlacklist,	[0] ],
	["_territoryNearLimit",			DMS_TerritoryNearBlacklist,	[0]	],
	["_waterSpawn",					false,						[false]	]
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
		if ((count _pos)<2) then
		{
			throw ("(ERROR UNDEFINED POSITION)");
		};

		if ((count _pos) isEqualTo 2) then
		{
			_pos set [2, 0];
		};


		if (!(DMS_findSafePosBlacklist isEqualTo []) && {([_pos, DMS_findSafePosBlacklist] call BIS_fnc_isPosBlacklisted)}) then
		{
			throw ("a blacklisted position");
		};


		// Only do these checks if the mission is supposed to be on land.
		if (!_waterSpawn) then
		{
			// Check for nearby water
			if ((_waterNearLimit>0) && {[_pos,_waterNearLimit] call DMS_fnc_isNearWater}) then 
			{
				throw ("water");
			};

			// Terrain steepness check
			// 0 surfacenormal means completely vertical, 1 surfaceNormal means completely flat and horizontal.
			// Take the arccos of the surfaceNormal to determine how many degrees it is from the horizontal. In SQF: {acos ((surfaceNormal _pos) select 2)}. Don't forget to define _pos.
			if ((_minSurfaceNormal>0) && {_minSurfaceNormal<=1}) then
			{
				if (((surfaceNormal _pos) select 2)<_minSurfaceNormal) then
				{
					throw ("a steep location");
				};

				// Check the surrounding area (within 5 meters)
				private "_dir";
				for "_dir" from 0 to 359 step 45 do
				{
					if (((surfaceNormal ([_pos,5,_dir] call DMS_fnc_SelectOffsetPos)) select 2)<_minSurfaceNormal) then
					{
						throw ("a nearby steep location");
					};
				};
			};
		}
		else
		{
			// Check to see if the position is actually water.
			if !(surfaceIsWater _pos) then
			{
				throw ("land");
			};

			// Check the depth of the water.
			if ((getTerrainHeightASL _pos)<-DMS_MinWaterDepth) then
			{
				throw ("shallow water");
			};
		};


		{
			if (((getMarkerPos _x) distance2D _pos)<=_missionNearLimit) then
			{
				throw ("an A3XAI mission");
			};
		} forEach (missionNamespace getVariable ["A3XAI_mapMarkerArray",[]]);
		
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
					throw ("a mission");
				};

				if (((_x find "VEMFr_DynaLocInva_ID")>0) && {((getMarkerPos _x) distance2D _pos)<=_missionNearLimit}) then
				{
					throw ("a VEMF mission");
				};
			};
		} forEach allMapMarkers;

		
		// Check for nearby players
		// This is done last because it is likely to be the most resource intensive.
		if ((_playerNearLimit>0) && {[_pos,_playerNearLimit] call DMS_fnc_IsPlayerNearby}) then
		{
			throw ("a player");
		};

		if ((_territoryNearLimit>0) && {[_pos,_territoryNearLimit] call ExileClient_util_world_isTerritoryInRange}) then
		{
			throw ("a territory");
		};

		

		// No exceptions found
		_isValidPos	= true;
	}
	catch
	{
		if (DMS_DEBUG) then
		{
			(format ["IsValidPosition :: Position %1 is too close to %2!",_pos,_exception]) call DMS_fnc_DebugLog;
		};
	};
};


_isValidPos;