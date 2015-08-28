private ["_i","_traders","_safePosParams","_validspot","_position"];

markerready = false;

_safePosParams		= [[16000,16000,0],1500,16000,(_this select 0),0,0.5,0];

_validspot 	= false;
_i = 0;
while{!_validspot} do {
	_position 	= _safePosParams call BIS_fnc_findSafePos;
	_validspot	= true;
	_i = _i+1;
	call {
		if (_position distance [14570, 16760, 0]<2000) exitWith
		{
			_validspot = false;
			if (debug_mode) then {diag_log "Position is too close to trader zone!";};
		};
		if ([_position,wai_near_water] call wai_isNearWater) exitWith 
		{
			_validspot = false;
			if (debug_mode) then {diag_log "Position is too close to water!";};
		};
		
		if ([_position] call wai_nearbyPlayers) exitWith
		{
			_validspot = false;
			if (debug_mode) then {diag_log "Position has players nearby!";};
		};

		/*
		Leave this off for now

		if(debug_mode) then { diag_log("WAI DEBUG: FINDPOS: Checking nearby mission markers: " + str(wai_mission_markers)); };
		{
			if ({getMarkerColor _x != "" && {_position distance (getMarkerPos _x) < wai_avoid_missions}}) exitWith
			{
				_validspot = false;
				if (debug_mode) then {diag_log "Position is too close to another mission!";};
			};
		} count wai_mission_markers;
		*/
	};
	if(_validspot) then {
		if(debug_mode) then { diag_log("Loop complete, valid position " +str(_position) + " in " + str(_i) + " attempts"); };	
	};
};
_position set [2, 0];
_position;