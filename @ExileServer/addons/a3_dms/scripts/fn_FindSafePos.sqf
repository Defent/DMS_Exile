/*
	DMS_fnc_findSafePos
	Created by eraser1

	Usage:
	[
		_nearestObjectMinDistance,	// (OPTIONAL) Number: Minimum distance from nearest object
		_maxTerrainGradient			// (OPTIONAL) Number: Maximum terrain gradient (slope)
	] call DMS_fnc_findSafePos;
*/


private ["_nearestObjectMinDistance","_maxTerrainGradient","_safePosParams","_validspot","_i","_pos"];

params
[
	["_nearestObjectMinDistance",25,[0]],
	["_maxTerrainGradient",10,[0]]
];


// Some custom maps don't have the proper safePos config entries.
// If you are using one and you have an issue with mission spawns, please create an issue on GitHub or post a comment in the DMS thread.
switch (toLower worldName) do
{ 
	case "altis" : { _safePosParams = [[16000,16000],0,16000,_nearestObjectMinDistance,0,_maxTerrainGradient,0,DMS_findSafePosBlacklist]; }; //[16000,16000] w/ radius of 16000 works well for Altis
	case "bornholm" : { _safePosParams = [[11264,11264],0,12000,_nearestObjectMinDistance,0,_maxTerrainGradient,0,DMS_findSafePosBlacklist]; }; // Thanks to thirdhero for testing this info
	case "esseker" : { _safePosParams = [[6144,6144],0,12288,_nearestObjectMinDistance,0,_maxTerrainGradient,0,DMS_findSafePosBlacklist]; }; // Thanks to Flowrider for this info
	default { _safePosParams = [[],0,-1,_nearestObjectMinDistance,0,_maxTerrainGradient,0,DMS_findSafePosBlacklist]; };
};


_validspot 	= false;
_i = 0;
while{!_validspot} do
{
	_pos 	= _safePosParams call BIS_fnc_findSafePos;
	_i = _i+1;
	try
	{
		// Check for nearby water
		if ([_pos,DMS_WaterNearBlacklist] call DMS_fnc_isNearWater) then 
		{
			throw ("water");
		};
		
		// Check for nearby players
		if ([_pos,DMS_PlayerNearBlacklist] call DMS_fnc_IsPlayerNearby) then
		{
			throw ("players");
		};
		
		{
			// Check for nearby spawn points
			if (((markertype _x) == "ExileSpawnZone") && {((getMarkerPos _x) distance2D _pos)<=DMS_SpawnZoneNearBlacklist}) then
			{
				throw ("a spawn zone");
			};

			// Check for nearby trader zones
			if (((markertype _x) == "ExileTraderZone") && {((getMarkerPos _x) distance2D _pos)<=DMS_TraderZoneNearBlacklist}) then
			{
				throw ("a trader zone");
			};

			// Check for nearby missions
			if (((_x find "DMS_MissionMarkerDot")>-1) && {((getMarkerPos _x) distance2D _pos)<=DMS_MissionNearBlacklist}) then
			{
				throw ("another mission");
			};
		} forEach allMapMarkers;

		// No exceptions found
		_validspot	= true;
	}
	catch
	{
		if (DMS_DEBUG) then
		{
			diag_log format ["DMS_DEBUG findSafePos :: Exception in attempt %1 | Position %2 is too close to %3!",_i,_pos,_exception];
		};
	};
};
if(DMS_DEBUG) then {
	diag_log format["DMS_DEBUG findSafePos :: Mission position %1 with %2 params found in %3 attempts.",_pos,_safePosParams,_i];
};
_pos set [2, 0];
_pos;