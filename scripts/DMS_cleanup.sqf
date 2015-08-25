fnc_DMS_cleanUp = {
	private ["_marker","_boxes"];
	_marker = _this select 0;
	_objects  = _this select 1;

	if (_marker == "Ended") then {
		deleteMarker "DMS_MainMarker";
		deleteMarker "DMS_MainDot";
	};

	if (_objects = "Clean") then {
		 
	    _this enableSimulation false;
	    _this removeAllMPEventHandlers "mpkilled";
	    _this removeAllMPEventHandlers "mphit";
	    _this removeAllMPEventHandlers "mprespawn";
	    _this removeAllEventHandlers "FiredNear";
	    _this removeAllEventHandlers "HandleDamage";
	    _this removeAllEventHandlers "Killed";
	    _this removeAllEventHandlers "Fired";
	    _this removeAllEventHandlers "GetOut";
	    _this removeAllEventHandlers "GetIn";
	    _this removeAllEventHandlers "Local";
	    clearVehicleInit _this;
	    deleteVehicle _this;
	    deleteGroup (group _this);
	    _this = nil;
	
	};
	diag_log format ["DMS :: Markers, vehicles, AI and loot boxes and other items have been cleaned up!"];
};
