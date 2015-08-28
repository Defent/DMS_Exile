private ["_i","_safePosParams","_validspot","_position"];

if (worldName=="Altis") then {
	_safePosParams		= [[16000,16000],0,16000,(_this select 0),0,0.5,0,DMS_findSafePosBlacklist];
} else {
	_safePosParams		= [[],0,-1,(_this select 0),0,0.5,0,DMS_findSafePosBlacklist];
};

_validspot 	= false;
_i = 0;
while{!_validspot} do {
	_position 	= _safePosParams call BIS_fnc_findSafePos;
	_validspot	= true;
	_i = _i+1;
	call {
		if ([_position,wai_near_water] call DMS_isNearWater) exitWith 
		{
			_validspot = false;
			if (DMS_DEBUG) then {diag_log "Position is too close to water!";};
		};
		
		if ([_position,DMS_PlayerNearBlacklist] call ExileServer_util_position_isPlayerNearby) exitWith
		{
			_validspot = false;
			if (DMS_DEBUG) then {diag_log "Position has players nearby!";};
		};

		/*
		markertype _x=="ExileSpawnZone" || "ExileTraderZone"

		if(DMS_DEBUG) then { diag_log("WAI DEBUG: FINDPOS: Checking nearby mission markers: " + str(wai_mission_markers)); };
		{
			if ({getMarkerColor _x != "" && {_position distance (getMarkerPos _x) < wai_avoid_missions}}) exitWith
			{
				_validspot = false;
				if (DMS_DEBUG) then {diag_log "Position is too close to another mission!";};
			};
			false;
		} count allMapMarkers;
		*/
	};
	if(_validspot) then {
		if(DMS_DEBUG) then { diag_log format["Mission position %1 with %2 params found in %3 attempts.",_position,_safePosParams,_i]; };	
	};
};
_position set [2, 0];
_position;