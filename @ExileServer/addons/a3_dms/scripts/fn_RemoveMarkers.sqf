/*
	DMS_fnc_RemoveMarkers
	Created by eraser1

	Usage:
	[
		[
			_markerDot,
			_markerCircle
		],
		_status
	] call DMS_fnc_RemoveMarkers;
*/

private ["_markerDot", "_markerCircle", "_status", "_text"];

_markerDot		= _this select 0 select 0;
_markerCircle	= _this select 0 select 1;
_status 		= _this select 1;
_text 			= missionNamespace getVariable [format ["%1_text",_markerDot],markerText _markerDot];


if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG RemoveMarkers :: Calling DMS_RemoveMarkers with parameters %1.",_this];
};


deleteMarker _markerCircle;
missionNamespace setVariable [format ["%1_pos",_markerDot], nil];
missionNamespace setVariable [format ["%1_text",_markerDot], nil];

if (_status == "win") then
{
	if (!DMS_MissionMarkerWinDot) exitWith
	{
		deleteMarker _markerDot;
	};
	_markerDot setMarkerText ("COMPLETED: "+_text);
	_markerDot setMarkerColor DMS_MissionMarkerWinDotColor;
	//_markerDot spawn {sleep DMS_MissionMarkerWinDotTime;deleteMarker _this;};
	[DMS_MissionMarkerWinDotTime, {deleteMarker _this;}, _markerDot, false] call ExileServer_system_thread_addTask;
	if (DMS_DEBUG) then
	{
		diag_log format ["DMS_DEBUG RemoveMarkers :: %1 Marker will be removed in %2 seconds!",_markerDot,DMS_MissionMarkerWinDotTime];
	};
}
else
{
	if (!DMS_MissionMarkerLoseDot) exitWith
	{
		deleteMarker _markerDot;
	};
	_markerDot setMarkerText ("FAILED: "+_text);
	_markerDot setMarkerColor DMS_MissionMarkerLoseDotColor;
	//_markerDot spawn {sleep DMS_MissionMarkerLoseDotTime;deleteMarker _this;};
	[DMS_MissionMarkerLoseDotTime, {deleteMarker _this;}, _markerDot, false] call ExileServer_system_thread_addTask;
	if (DMS_DEBUG) then
	{
		diag_log format ["DMS_DEBUG RemoveMarkers :: %1 Marker will be removed in %2 seconds!",_markerDot,DMS_MissionMarkerLoseDotTime];
	};
};