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



if (isNil "DMS_ConfigLoaded") exitWith
{
	for "_i" from 0 to 99 do
	{
		diag_log "DMS ERROR :: You have made an error in your DMS config.sqf! Please look for any script errors. Cancelling DMS Launch.";
	};
};


// This code is NECESSARY for spawning persistent vehicles. DO NOT REMOVE THIS CODE UNLESS YOU KNOW WHAT YOU ARE DOING
if !("isKnownAccount:DMS_PersistentVehicle" call ExileServer_system_database_query_selectSingleField) then
{
	"createAccount:DMS_PersistentVehicle:DMS_PersistentVehicle" call ExileServer_system_database_query_fireAndForget;
};





// Some custom maps don't have the proper safePos config entries.
// DMS no longer uses these values as of October 30, 2015.
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
	case "taviana";										// Thanks to JamieKG for this info
	case "tavi":
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



EAST setFriend[WEST,0];
EAST setFriend[RESISTANCE,0];
RESISTANCE setFriend[WEST,0];
RESISTANCE setFriend[EAST,0];
WEST setFriend[EAST,0];
WEST setFriend[RESISTANCE,0];



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

if !(DMS_ai_offload_to_client) then
{
	DMS_ai_offloadOnUnfreeze = false;
};

if !(DMS_ai_allowFreezing) then
{
	DMS_ai_freezeOnSpawn = false;
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



// Send Client Functions using compileFinal for security.
publicVariable "DMS_CLIENT_fnc_spawnDynamicText";
publicVariable "DMS_CLIENT_fnc_spawnTextTiles";
publicVariable "DMS_CLIENT_fnc_hintSilent";

publicVariable "DMS_Version";


format["DMS_Version: %1",DMS_Version] remoteExecCall ["diag_log", -2, "DMS_LogVersion_JIP_ID"];



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


execFSM "\x\addons\dms\FSM\missions.fsm";


if (DMS_ShowDifficultyColorLegend) then
{
	private "_title";
	_title = createmarker ["DMS_MissionMarker_DifficultyColorLegend",[-500,-200]];
	_title setMarkerColor "ColorRed";
	_title setmarkertext "DMS Mission Difficulties Color Legend";
	_title setMarkerType "mil_dot";
	_title setMarkerAlpha 0.5;
	{
		private _difficulty = _x;

		private _color = "ColorGreen";
		private _markerType = "ExileMissionEasyIcon";


		switch (_difficulty) do
		{
			case "moderate":
			{
				_color = "ColorYellow";
				_markerType = "ExileMissionModerateIcon";
			};
			case "difficult":
			{
				_color = "ColorRed";
				_markerType = "ExileMissionDifficultIcon";
			};
			case "hardcore":
			{
				_color = "ColorBlack";
				_markerType = "ExileMissionHardcoreIcon";
			};
		};

		private _num = -200 * (_forEachIndex - 0.5);
		private _pos = [100,_num];

		if (DMS_ShowMarkerCircle) then
		{
			private _circle = createMarker [format ["DMS_MissionMarker_DifficultyColor_%1",_color], _pos];
			_circle setMarkerColor _color;
			_circle setMarkerShape "ELLIPSE";
			_circle setMarkerBrush "Solid";
			_circle setMarkerSize [100,100];
		};

		private _dot = createMarker [format ["DMS_MissionMarker_Difficulty_%1",_difficulty],_pos];
		_dot setMarkerType _markerType;
		_dot setMarkerText _difficulty;
		_dot setMarkerAlpha 0.5;
	} forEach ["hardcore","difficult","moderate","easy"];
};


// Add heli paratroopers monitor to the thread system.
[5, DMS_fnc_HeliParatroopers_Monitor, [], true] call ExileServer_system_thread_addTask;


{
	[_x] call DMS_fnc_ImportFromM3E_Static;			// Spawn all of the bases that are supposed to be spawned on server startup.
} forEach DMS_BasesToImportOnServerStart;


{
	missionNamespace setVariable
	[
		format["DMS_Mission_%1",_x],
		compileFinal preprocessFileLineNumbers (format ["\x\addons\DMS\missions\bandit\%1.sqf",_x])
	];

	[_x] call DMS_fnc_SpawnBanditMission;
} forEach DMS_BanditMissionsOnServerStart;


if (DMS_StaticMission) then
{
	private _temp = DMS_StaticMinPlayerDistance;
	DMS_StaticMinPlayerDistance = 0;

	{
		missionNamespace setVariable
		[
			format["DMS_StaticMission_%1",_x],
			compileFinal preprocessFileLineNumbers (format ["\x\addons\DMS\missions\static\%1.sqf",_x])
		];

		[_x] call DMS_fnc_SpawnStaticMission;
	} forEach DMS_StaticMissionsOnServerStart;

	DMS_StaticMinPlayerDistance = _temp;
};


for "_i" from 1 to DMS_RandomBanditMissionsOnStart do
{
	[selectRandom DMS_BanditMissionTypesArray] call DMS_fnc_SpawnBanditMission;
};




format ["DMS post-init complete. productVersion: %1 | infiSTAR version: %2", productVersion, if (!isNil "INFISTARVERSION") then {INFISTARVERSION} else {"not installed"}] call DMS_fnc_DebugLog;
