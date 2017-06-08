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
		_territoryNearLimit,		// NUMBER (distance): Minimum distance from a territory.
		_mixerNearLimit,			// NUMBER (distance): Minimum distance from a concrete mixer.
		_contaminatedZoneNearLimit	// NUMBER (distance): Minimum distance from a contaminated zone.
	] call DMS_fnc_IsValidPosition;

	All parameters except "_pos" are optional.

	Returns whether or not the provided position matches the parameters.
*/

if !(params
[
	"_pos",
	"_waterNearLimit",
	"_minSurfaceNormal",
	"_spawnZoneNearLimit",
	"_traderZoneNearLimit",
	"_missionNearLimit",
	"_playerNearLimit",
	"_territoryNearLimit",
	"_mixerNearLimit",
	"_contaminatedZoneNearLimit"
])
then
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_isValidPosition with invalid parameters: %1",_this];
	false
}
else
{
	private _isValidPos = false;

	try
	{
		if ((count _pos)<2) then
		{
			throw ("(UNDEFINED POSITION)");
		};

		if ((count _pos) isEqualTo 2) then
		{
			_pos set [2, 0];
		};


		if ([_pos, DMS_findSafePosBlacklist] call DMS_fnc_IsPosBlacklisted) throw "a blacklisted position";


		// Check for nearby water
		if ((_waterNearLimit>0) && {[_pos,_waterNearLimit] call DMS_fnc_isNearWater}) throw "water";

		// Terrain steepness check
		// 0 surfacenormal means completely vertical, 1 surfaceNormal means completely flat and horizontal.
		// Take the arccos of the surfaceNormal to determine how many degrees it is from the horizontal. In SQF: {acos ((surfaceNormal _pos) select 2)}. Don't forget to define _pos.
		if ((_minSurfaceNormal>0) && {_minSurfaceNormal<=1}) then
		{
			if (((surfaceNormal _pos) select 2)<_minSurfaceNormal) throw "a steep location";

			// Check the surrounding area (within 5 meters)
			private "_dir";
			for "_dir" from 0 to 359 step 45 do
			{
				if (((surfaceNormal (_pos getPos [5,_dir])) select 2)<_minSurfaceNormal) throw "a nearby steep location";
			};
		};


		{
			if (((getMarkerPos _x) distance2D _pos)<=_missionNearLimit) throw "an A3XAI mission";
		} forEach (missionNamespace getVariable ["A3XAI_mapMarkerArray",[]]);

		{
			private _markerType = markertype _x;

			// Check for nearby spawn points
			if ((_markerType in DMS_SpawnZoneMarkerTypes) && {((getMarkerPos _x) distance2D _pos)<=_spawnZoneNearLimit}) throw "a spawn zone";

			// Check for nearby trader zones
			if ((_markerType in DMS_TraderZoneMarkerTypes) && {((getMarkerPos _x) distance2D _pos)<=_traderZoneNearLimit}) throw "a trader zone";

			// Check for nearby concrete mixers
			if ((_markerType in DMS_MixerMarkerTypes) && {((getMarkerPos _x) distance2D _pos)<=_mixerNearLimit}) throw "a concrete mixer";

			// Check for nearby contaminated zones
			if ((_markerType in DMS_ContaminatedZoneMarkerTypes) && {((getMarkerPos _x) distance2D _pos)<=_contaminatedZoneNearLimit}) throw "a contaminated zone";

			// Check for nearby missions
			if (_missionNearLimit>0) then
			{
				_missionPos = missionNamespace getVariable [format ["%1_pos",_x], []];
				if (!(_missionPos isEqualTo []) && {(_missionPos distance2D _pos)<=_missionNearLimit}) throw "a DMS mission";

				if
				(
					(
						((_x find "ZCP_CM_dot_") >= 0)							// Look in the marker string for the ZCP marker prefix
						||
						{(_x find "VEMFr_DynaLocInva_ID") >= 0}					// Look in the marker string for the VEMF marker prefix
					)
					&&
					{((getMarkerPos _x) distance2D _pos)<=_missionNearLimit}	// Then check if the marker is close to the position
				) throw "a VEMF or ZCP mission";
			};
		} forEach allMapMarkers;


		// Check for nearby players
		if ((_playerNearLimit>0) && {[_pos,_playerNearLimit] call DMS_fnc_IsPlayerNearby}) throw "a player";

		// Check for nearby territories. This is done last because it is likely to be the most resource intensive.
		if ((_territoryNearLimit>0) && {[_pos,_territoryNearLimit] call ExileClient_util_world_isTerritoryInRange}) throw "a territory";


		// No exceptions found
		_isValidPos	= true;
	}
	catch
	{
		/*
		_dot = createMarker [format ["DMS_DebugMarker_attempt%1", _pos], _pos];
		_dot setMarkerColor "ColorWEST";
		_dot setMarkerType "mil_dot";
		_dot setMarkerText (format["close to: %1",_exception]);
		DMS_DebugMarkers pushBack _dot;
		*/
		if (DMS_DEBUG) then
		{
			(format ["IsValidPosition :: Position %1 is too close to %2!",_pos,_exception]) call DMS_fnc_DebugLog;
		};
	};

	_isValidPos
};
