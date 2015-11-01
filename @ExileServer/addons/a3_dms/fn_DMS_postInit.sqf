/*
	DMS post-init

	Created by eraser1 and Defent
*/

if !(isServer) exitWith
{
	for "_i" from 0 to 99 do
	{
		diag_log "The DMS PBO is for the SERVER ONLY. It will NOT work for any form of client! DMS launch cancelled.";
	};
};


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

DMS_A3_AllMarkerColors = [];
for "_i" from 0 to ((count(configfile >> "CfgMarkerColors"))-1) do
{
	DMS_A3_AllMarkerColors pushBack (toLower (configName ((configfile >> "CfgMarkerColors") select _i)));
};


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

// Set up the minimum/maximum co-ordinate values for x and y...
DMS_MinMax_X_Coords = [DMS_MinDistFromWestBorder, worldSize - DMS_MinDistFromEastBorder];
DMS_MinMax_Y_Coords = [DMS_MinDistFromSouthBorder, worldSize - DMS_MinDistFromNorthBorder];


if (DMS_DynamicMission || {DMS_StaticMission}) then
{
	call compileFinal preprocessFileLineNumbers "\x\addons\dms\missions\static_init.sqf";

	call compileFinal preprocessFileLineNumbers "\x\addons\dms\missions\mission_init.sqf";


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


	execFSM "\x\addons\dms\FSM\missions.fsm";
}
else
{
	diag_log "Enjoy the DMS functions! :)";
};


DMS_Version = "October 30 2015";

"DMS post-init complete." call DMS_fnc_DebugLog;
