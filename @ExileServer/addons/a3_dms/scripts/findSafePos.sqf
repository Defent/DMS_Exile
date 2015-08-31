/*
	DMS_findSafePos
	Created by eraser1

	Usage:
	[
		_nearestObjectMinDistance,	// (OPTIONAL) Number: Minimum distance from nearest object
		_maxTerrainGradient			// (OPTIONAL) Number: Maximum terrain gradient (slope)
	] call DMS_findSafePos;
*/


private ["_nearestObjectMinDistance","_maxTerrainGradient","_safePosParams","_validspot","_i","_pos"];

params
[
	["_nearestObjectMinDistance",25,[0]],
	["_maxTerrainGradient",10,[0]]
];

_safePosParams =
[
	[[],0,-1,_nearestObjectMinDistance,0,_maxTerrainGradient,0,DMS_findSafePosBlacklist],
	[[16000,16000],0,16000,_nearestObjectMinDistance,0,_maxTerrainGradient,0,DMS_findSafePosBlacklist]		//[16000,16000] w/ radius of 16000 works well for Altis
] select (worldName=="Altis");

_validspot 	= false;
_i = 0;
while{!_validspot} do {
	_pos 	= _safePosParams call BIS_fnc_findSafePos;
	_i = _i+1;
	try
	{
		// Check for nearby water
		if ([_pos,DMS_WaterNearBlacklist] call DMS_isNearWater) exitWith 
		{
			throw ("water");
		};
		
		// Check for nearby players
		if ([_pos,DMS_PlayerNearBlacklist] call ExileServer_util_position_isPlayerNearby) exitWith
		{
			throw ("players");
		};
		
		{
			// Check for nearby spawn points
			if (((markertype _x) == "ExileSpawnZone") && {((getMarkerPos _x) distance2D _pos)<=DMS_SpawnZoneNearBlacklist}) exitWith
			{
				throw ("a spawn zone");
			};

			// Check for nearby trader zones
			if (((markertype _x) == "ExileTraderZone") && {((getMarkerPos _x) distance2D _pos)<=DMS_TraderZoneNearBlacklist}) exitWith
			{
				throw ("a trader zone");
			};

			// Check for nearby missions
			if (((_x find "DMS_MissionMarkerDot")>-1) && {((getMarkerPos _x) distance2D _pos)<=DMS_MissionNearBlacklist}) exitWith
			{
				throw ("another mission");
			};
			false;
		} count allMapMarkers;

		// No exceptions found
		_validspot	= true;
	}
	catch
	{
		if (DMS_DEBUG) then {
			diag_log format ["DMS_DEBUG findSafePos :: Exception in attempt %1 | Position %2 is too close to %3!",_i,_pos,_exception];
		};
	};
};
if(DMS_DEBUG) then {
	diag_log format["DMS_DEBUG findSafePos :: Mission position %1 with %2 params found in %3 attempts.",_pos,_safePosParams,_i];
};
_pos set [2, 0];
_pos;