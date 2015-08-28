private ["_markerDot","_markerCircle","_status"];
	
/*
To CALL on lose:
[[_markerDot,_markerCircle],"lose"] call DMS_RemoveMarkers;

To CALL on win:
[[_markerDot,_markerCircle],"win"] call DMS_RemoveMarkers;

to clean markers:

*/

_markerDot		= _this select 0 select 0;
_markerCircle	= _this select 0 select 1;
_status 		= _this select 1;

	if (_status == "win") then
	{
		deleteMarker _markerCircle;
		if (!DMS_MissionMarkerWinDot) exitWith {
			deleteMarker _markerDot;
		};
		_markerDot setMarkerText ("COMPLETED: "+markerText _markerDot);
		_markerDot setMarkerColor DMS_MissionMarkerWinDotColor;
		[DMS_MissionMarkerWinDotTime, {deleteMarker _this;}, _markerDot, false] call ExileServer_system_thread_addTask;
	}
	else
	{
		deleteMarker _markerCircle;
		if (!DMS_MissionMarkerLoseDot) exitWith {
			deleteMarker _markerDot;
		};
		_markerDot setMarkerText ("FAILED: "+markerText _markerDot);
		_markerDot setMarkerColor DMS_MissionMarkerLoseDotColor;
		[DMS_MissionMarkerLoseDotTime, {deleteMarker _this;}, _markerDot, false] call ExileServer_system_thread_addTask;
	};

};