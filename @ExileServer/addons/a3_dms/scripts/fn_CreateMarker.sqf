/*
	DMS_fnc_CreateMarker
	Created by Defent and eraser1

	Usage:
	[
		_pos,					// Array: Position of the markers
		_text,					// String: The text on the map marker that will appear on the map
		_difficulty,			// (OPTIONAL) String: "hardcore","difficult","moderate", "easy", OR custom color
		_randomMarker			// (OPTIONAL) Boolean: Whether or not to place the map marker on a random offset from mission, defined by DMS_MarkerPosRandomRadius
	] call DMS_fnc_CreateMarker;

	Returns markers in format:
	[
		_markerDot,
		_markerCircle
	]
	
*/


private["_pos", "_text", "_difficulty", "_randomMarker", "_num", "_color", "_dot", "_circle", "_dir", "_dis", "_npos"];


params
[
	["_pos","ERROR",[[]],[2,3]],
	["_text","ERROR",[""]],
	["_difficulty","moderate",[""]]
];

if ((_pos isEqualTo "ERROR") || ("_text" isEqualTo "ERROR")) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_CreateMarker with invalid parameters: %1",_this];

	[];
};


_randomMarker = DMS_MarkerPosRandomization;
if ((count _this)>3) then
{
	_randomMarker = param [3,DMS_MarkerPosRandomization,[false]];
};

_num = DMS_MissionCount;

switch (_difficulty) do
{
	case "easy": 		{_color = "ColorGreen";};
	case "moderate": 	{_color = "ColorYellow";};
	case "difficult": 	{_color = "ColorRed";};
	case "hardcore" : 	{_color = "ColorBlack";};
	default 			{_color = _difficulty;};
};

_circle = createMarker [format ["DMS_MissionMarkerCircle%1",_num], _pos];
_circle setMarkerColor _color;
_circle setMarkerShape "ELLIPSE";
_circle setMarkerBrush "Solid";
_circle setMarkerSize [150,150];

_dot = createMarker [format ["DMS_MissionMarkerDot%1",_num], _pos];
_dot setMarkerColor "ColorBlack";
_dot setMarkerType "mil_dot";
_dot setMarkerText _text;

missionNamespace setVariable [format ["%1_pos",_dot], _pos];
missionNamespace setVariable [format ["%1_text",_dot], _text];

if (DMS_MarkerText_ShowMissionPrefix) then
{
	_dot setMarkerText (format ["%1 %2",DMS_MarkerText_MissionPrefix,_text]);
};

if (_randomMarker) then
{
	_dir = random 360;
	_dis = DMS_MarkerPosRandomRadius call DMS_fnc_SelectRandomVal;
	_npos = [_pos,_dis,_dir] call DMS_fnc_SelectOffsetPos;

	_circle setMarkerPos _npos;
	_dot setMarkerPos _npos;
	_circle setMarkerBrush DMS_RandomMarkerBrush;

	if (DMS_DEBUG) then
	{
		diag_log format ["Moving markers %1 from %2 to %3 (%4m away)",[_dot,_circle],_pos,_npos,_dis];
	};
};

if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG CreateMarker :: Created markers |%1| at %2 with text |%3| colored %4",[_dot,_circle],_pos,_text,_color];
};


[_dot,_circle];