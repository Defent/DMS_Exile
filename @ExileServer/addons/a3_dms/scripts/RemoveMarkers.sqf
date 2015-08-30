/*
	DMS_RemoveMarkers
	Created by eraser1

	Usage:
	[
		[
			_markerDot,
			_markerCircle
		],
		_status
	] call DMS_RemoveMarkers;
*/

private ["_markerDot","_markerCircle","_status"];

_markerDot		= _this select 0 select 0;
_markerCircle	= _this select 0 select 1;
_status 		= _this select 1;


if (DMS_DEBUG) then
{
	diag_log format["DMS_DEBUG RemoveMarkers :: Calling DMS_RemoveMarkers with parameters %1.",_this];
};

deleteMarker _markerCircle;

if (_status == "win") then
{
	if (!DMS_MissionMarkerWinDot) exitWith {
		deleteMarker _markerDot;
	};
	_markerDot setMarkerText ("COMPLETED: "+markerText _markerDot);
	_markerDot setMarkerColor DMS_MissionMarkerWinDotColor;
	[DMS_MissionMarkerWinDotTime, {deleteMarker _this;}, _markerDot, false] call ExileServer_system_thread_addTask;
	if (DMS_DEBUG) then
	{
		diag_log format["DMS_DEBUG RemoveMarkers :: %1 Marker will be removed in %2 seconds!",DMS_MissionMarkerWinDotTime,_markerDot];
	};
}
else
{
	if (!DMS_MissionMarkerLoseDot) exitWith {
		deleteMarker _markerDot;
	};
	_markerDot setMarkerText ("FAILED: "+markerText _markerDot);
	_markerDot setMarkerColor DMS_MissionMarkerLoseDotColor;
	[DMS_MissionMarkerLoseDotTime, {deleteMarker _this;}, _markerDot, false] call ExileServer_system_thread_addTask;
	if (DMS_DEBUG) then
	{
		diag_log format["DMS_DEBUG RemoveMarkers :: %1 Marker will be removed in %2 seconds!",DMS_MissionMarkerLoseDotTime,_markerDot];
	};
};