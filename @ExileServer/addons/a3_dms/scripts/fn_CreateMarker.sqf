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


private _randomMarker =
	if ((count _this)>3) then
	{
		_this select 3;
	}
	else
	{
		DMS_MarkerPosRandomization;
	};

private _num = DMS_MissionCount;


private _markerType = "mil_dot";

private _color =
	switch (toLower _difficulty) do
	{
		case "easy":
		{
			_markerType = "ExileMissionEasyIcon";
			"ColorGreen"
		};
		case "moderate":
		{
			_markerType = "ExileMissionModerateIcon";
			"ColorYellow"
		};
		case "difficult":
		{
			_markerType = "ExileMissionDifficultIcon";
			"ColorRed"
		};
		case "hardcore":
		{
			_markerType = "ExileMissionHardcoreIcon";
			"ColorBlack"
		};

		default
		{
			_difficulty
		};
	};

/*
// Don't think this is really needed, ArmA gives you an error anyways.
if !((toLower _color) in DMS_A3_AllMarkerColors) then
{
	diag_log format ["DMS ERROR :: Color ""%1"" is not a valid marker color! Switching to ""ColorRed""",_color];
	_color = "ColorRed";
};
*/

private _circle = createMarker [format ["DMS_MissionMarkerCircle%1_%2",_num,round(time)], _pos];

if (DMS_ShowMarkerCircle) then
{
	_circle setMarkerColor _color;
	_circle setMarkerShape "ELLIPSE";
	_circle setMarkerBrush "Solid";
	_circle setMarkerSize [150,150];
};

private _dot = createMarker [format ["DMS_MissionMarkerDot%1_%2",_num,round(time)], _pos];
_dot setMarkerType _markerType;
_dot setMarkerText _text;

missionNamespace setVariable [format ["%1_pos",_dot], _pos];
missionNamespace setVariable [format ["%1_text",_dot], _text];

if (DMS_MarkerText_ShowMissionPrefix) then
{
	_dot setMarkerText (format ["%1 %2",DMS_MarkerText_MissionPrefix,_text]);
};

if (_randomMarker) then
{
	private _dis = DMS_MarkerPosRandomRadius call DMS_fnc_SelectRandomVal;
	private _npos = _pos getPos [_dis,random 360];

	_circle setMarkerPos _npos;
	_dot setMarkerPos _npos;
	_circle setMarkerBrush DMS_RandomMarkerBrush;

	if (DMS_DEBUG) then
	{
		(format ["CreateMarker :: Moving markers %1 from %2 to %3 (%4m away)",[_dot,_circle],_pos,_npos,_dis]) call DMS_fnc_DebugLog;
	};
};

if (DMS_DEBUG) then
{
	(format ["CreateMarker :: Created markers |%1| at %2 with text |%3| colored %4",[_dot,_circle],_pos,_text,_color]) call DMS_fnc_DebugLog;
};


[_dot,_circle];
