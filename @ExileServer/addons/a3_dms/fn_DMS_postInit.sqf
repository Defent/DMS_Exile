/*
	Launches mission functions
	Made for Defent for Defents Mission System
	And for Numenadayz.com
	Written by eraser1
*/

RESISTANCE setFriend[WEST,0];
WEST setFriend[RESISTANCE,0];
RESISTANCE setFriend[EAST,0];
EAST setFriend[RESISTANCE,0];
EAST setFriend[WEST,0];
WEST setFriend[EAST,0];

if ((!isNil "A3XAI_isActive") && {!DMS_ai_offload_Only_DMS_AI}) then
{
	diag_log 'DMS DETECTED A3XAI. Enabling "DMS_ai_offload_Only_DMS_AI"!';
	DMS_ai_offload_Only_DMS_AI = true;
};


if(DMS_StaticMission) then
{
	call compileFinal preprocessFileLineNumbers "\x\addons\dms\static\static_init.sqf";//<---- TODO
};

if (DMS_DynamicMission) then
{
	DMS_AttemptsUntilThrottle = DMS_AttemptsUntilThrottle + 1;

	DMS_CLIENT_fnc_spawnDynamicText = compileFinal
	("
	[
		_this,
		0,
		safeZoneY,
		"+str DMS_dynamicText_Duration+",
		"+str DMS_dynamicText_FadeTime+",
		0,
		24358
	] spawn BIS_fnc_dynamicText;
	");
	publicVariable "DMS_CLIENT_fnc_spawnDynamicText";

	DMS_CLIENT_fnc_spawnTextTiles = compileFinal
	("
	[
		parseText _this,
		[
			0,
			safeZoneY,
			1,
			1
		],
		[10,10],
		"+str DMS_textTiles_Duration+",
		"+str DMS_textTiles_FadeTime+",
		0
	] spawn BIS_fnc_textTiles;
	");
	publicVariable "DMS_CLIENT_fnc_spawnTextTiles";

	call compileFinal preprocessFileLineNumbers "\x\addons\dms\missions\mission_init.sqf";
	execFSM "\x\addons\dms\FSM\missions.fsm";
};


if (DMS_ShowDifficultyColorLegend) then
{
	private "_title";
	_title = createmarker ["DMS_MissionMarker_DifficultyColorLegend",[-500,-200]];
	_title setMarkerColor "ColorRed";
	_title setmarkertext "DMS Mission Difficulties Color Legend";
	_title setMarkerType "mil_dot";
	_title setMarkerAlpha 0.5;
	{
		private ["_difficulty", "_color", "_num", "_pos", "_circle", "_dot"];

		_difficulty = _x;
		switch (_difficulty) do
		{
			case "easy": 		{_color = "ColorGreen";};
			case "moderate": 	{_color = "ColorYellow";};
			case "difficult": 	{_color = "ColorRed";};
			case "hardcore" : 	{_color = "ColorBlack";};
		};

		_num = -200 * (_forEachIndex - 0.5);
		_pos = [100,_num];

		_circle = createMarker [format ["DMS_MissionMarker_DifficultyColor_%1",_color], _pos];
		_circle setMarkerColor _color;
		_circle setMarkerShape "ELLIPSE";
		_circle setMarkerBrush "Solid";
		_circle setMarkerSize [100,100];

		_dot = createMarker [format ["DMS_MissionMarker_Difficulty_%1",_difficulty],_pos];
		_dot setMarkerColor "ColorWhite";
		_dot setMarkerType "mil_dot";
		_dot setMarkerAlpha 0.5;
		_dot setMarkerText _difficulty;
	} forEach ["hardcore","difficult","moderate","easy"];
};