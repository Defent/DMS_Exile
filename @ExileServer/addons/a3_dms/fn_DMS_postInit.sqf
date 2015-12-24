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



if (isNil "DMS_DynamicMission") exitWith
{
	for "_i" from 0 to 99 do
	{
		diag_log "DMS ERROR :: You have made an error in your DMS config.sqf! Cancelling DMS Launch.";
	};
};


// This code is NECESSARY for spawning persistent vehicles. DO NOT REMOVE THIS CODE UNLESS YOU KNOW WHAT YOU ARE DOING
if !("isKnownAccount:76561198027700602" call ExileServer_system_database_query_selectSingleField) then
{
	"createAccount:76561198027700602:eraser1" call ExileServer_system_database_query_fireAndForget;
};





// Some custom maps don't have the proper safePos config entries.
// If you are using one and you have an issue with mission spawns, please create an issue on GitHub or post a comment in the DMS thread.
switch (toLower worldName) do
{ 
	case "altis":										// [16000,16000] w/ radius of 16000 works well for Altis
	{
		DMS_MapCenterPos 	= [16000,16000];
		DMS_MapRadius 		= 16000;
	};
	case "bornholm":									// Thanks to thirdhero for testing this info
	{
		DMS_MapCenterPos 	= [11265,11265];
		DMS_MapRadius 		= 12000;
	};
	case "esseker":										// Thanks to Flowrider for this info
	{
		DMS_MapCenterPos 	= [6275,6350];
		DMS_MapRadius 		= 5000;
	};
	case "tavi":										// Thanks to JamieKG for this info
	{
		DMS_MapCenterPos 	= [12800,12800];
		DMS_MapRadius 		= 12800;
	};
	default 											// Use "worldSize" to determine map center/radius (not always very nice).
	{
		private "_middle";
		_middle = worldSize/2;
		DMS_MapCenterPos 	= [_middle,_middle];
		DMS_MapRadius 		= _middle;
	};
};

// Since we use primarily ATL
DMS_MapCenterPos set [2,0];



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

if ((isClass (configFile >> "CfgPatches" >> "Ryanzombies")) && {!DMS_ai_offload_Only_DMS_AI}) then
{
	diag_log 'DMS DETECTED RyanZombies. Enabling "DMS_ai_offload_Only_DMS_AI"!';
	DMS_ai_offload_Only_DMS_AI = true;
};



DMS_A3_AllMarkerColors = [];
for "_i" from 0 to ((count(configfile >> "CfgMarkerColors"))-1) do
{
	DMS_A3_AllMarkerColors pushBack (toLower (configName ((configfile >> "CfgMarkerColors") select _i)));
};


if !((toLower DMS_MissionMarkerWinDotColor) in DMS_A3_AllMarkerColors) then
{
	diag_log format ["DMS ERROR :: Unsupported color for DMS_MissionMarkerWinDotColor (""%1""). Switching color to ""ColorBlue"".",DMS_MissionMarkerWinDotColor];
	DMS_MissionMarkerWinDotColor = "ColorBlue";
};

if !((toLower DMS_MissionMarkerLoseDotColor) in DMS_A3_AllMarkerColors) then
{
	diag_log format ["DMS ERROR :: Unsupported color for DMS_MissionMarkerLoseDotColor (""%1""). Switching color to ""ColorRed"".",DMS_MissionMarkerLoseDotColor];
	DMS_MissionMarkerLoseDotColor = "ColorRed";
};



// Create and send Client Functions using compileFinal for security.
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



// Add the weighted predefined locations to the list of predefined locations
{
	for "_i" from 1 to (_x select 1) do
	{
		DMS_PredefinedMissionLocations pushBack (_x select 0);
	};
} forEach DMS_PredefinedMissionLocations_WEIGHTED;



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
	diag_log "Enjoy DMS functions! :)";
};


{
	[_x] call DMS_fnc_ImportFromM3E_Static;			// Spawn all of the bases that are supposed to be spawned on server startup.
} forEach DMS_BasesToImportOnServerStart;





format ["DMS post-init complete. productVersion: %1 | infiSTAR version: %2", productVersion, if (!isNil "INFISTARVERSION") then {INFISTARVERSION} else {"not installed"}] call DMS_fnc_DebugLog;
