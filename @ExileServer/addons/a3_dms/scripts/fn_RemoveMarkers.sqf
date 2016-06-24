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

private _markerDot		= _this select 0 select 0;
private _markerCircle	= _this select 0 select 1;
private _status 		= _this select 1;
private _text 			= missionNamespace getVariable [format ["%1_text",_markerDot],markerText _markerDot];


if (DMS_DEBUG) then
{
	(format ["RemoveMarkers :: Calling DMS_RemoveMarkers with parameters %1.",_this]) call DMS_fnc_DebugLog;
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
	_markerDot setMarkerType DMS_MissionMarkerWinDot_Type;
	//_markerDot spawn {sleep DMS_MissionMarkerWinDotTime;deleteMarker _this;};
	[DMS_MissionMarkerWinDotTime, {deleteMarker (_this select 0);}, [_markerDot], false] call ExileServer_system_thread_addTask;
	if (DMS_DEBUG) then
	{
		(format ["RemoveMarkers :: %1 Marker will be removed in %2 seconds!",_markerDot,DMS_MissionMarkerWinDotTime]) call DMS_fnc_DebugLog;
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
	_markerDot setMarkerType DMS_MissionMarkerLoseDot_Type;
	//_markerDot spawn {sleep DMS_MissionMarkerLoseDotTime;deleteMarker _this;};
	[DMS_MissionMarkerLoseDotTime, {deleteMarker (_this select 0);}, [_markerDot], false] call ExileServer_system_thread_addTask;
	if (DMS_DEBUG) then
	{
		(format ["RemoveMarkers :: %1 Marker will be removed in %2 seconds!",_markerDot,DMS_MissionMarkerLoseDotTime]) call DMS_fnc_DebugLog;
	};
};
