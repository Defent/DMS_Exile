/*
	DMS_CreateMarker
	Created by Defent and eraser1

	Usage:
	[
		_pos,					// Array: Position of the markers
		_text,					// String: The text on the map marker that will appear on the map
		_difficulty,			// !!!OPTIONAL!!! String: "hardcore","difficult","moderate", "easy", OR custom color
	] call DMS_CreateMarker;

	Returns markers in format:
	[
		_markerDot,
		_markerCircle
	]
	
*/


private["_pos", "_text", "_difficulty", "_num", "_color", "_dot", "_circle"];


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

_num = DMS_MissionCount;

call
{
	if(_difficulty == "easy")		exitWith {_color = "ColorGreen"};
	if(_difficulty == "moderate")		exitWith {_color = "ColorYellow"};
	if(_difficulty == "difficult")		exitWith {_color = "ColorRed"};
	if(_difficulty == "hardcore") 	exitWith {_color = "ColorBlack"};
	_color = _difficulty;
};

_circle = createMarker [format ["DMS_MissionMarkerCircle%1",_num], _pos];
_circle setMarkerColor _color;
_circle setMarkerShape "ELLIPSE";
_circle setMarkerBrush "Grid";
_circle setMarkerSize [150,150];

_dot = createMarker [format ["DMS_MissionMarkerDot%1",_num], _pos];
_dot setMarkerColor "ColorBlack";
_dot setMarkerType "mil_dot";
_dot setMarkerText _text;

if (DMS_DEBUG) then
{
	diag_log format ["Created markers |%1| at %2 with text |%3| colored %4",[_dot,_circle],_pos,_text,_color];
};


[_dot,_circle];