/*
	DMS Pre-init
	Created by eraser1
*/
#define CALLFILE(FILE) call compile preprocessFileLineNumbers FILE;

// Enables debug logging in DMS functions. !!!NOTE:!!! You must uncomment the line above if you want DMS to even check whether or not debug mode is enabled!
// Logs will be written in the RPT, and if you have infiSTAR's "ARMA_LOG" DLL loaded, it will also produce logs in the server directory.
// If you have mARMA by maca134, DMS will also utilize mARMA logs.
// This will produce A LOT of logs, so make sure you leave it to false unless you know what you're doing.
DMS_DEBUG = false;



DMS_CleanUpList	= [];

DMS_Version = getText (configFile >> "CfgPatches" >> "a3_dms" >> "a3_DMS_version");


//Load main config
CALLFILE("\x\addons\dms\config.sqf");

// Let's be honest - you know it's gonna happen.
if (isNil "DMS_AI_NamingType") then
{
	for "_i" from 0 to 99 do
	{
		diag_log format["!!!!!!!!MAKE SURE YOUR DMS CONFIG IS UPDATED!!!!!"];
	};
	DMS_ConfigLoaded = nil;
};


//Load map-specific configs. Should make it easier for people with multiple servers/maps. One PBO to rule them all...
if (DMS_Use_Map_Config) then
{
	private _file = preprocessFileLineNumbers (format ["\x\addons\dms\map_configs\%1_config.sqf",toLower worldName]);
	if (_file isEqualTo "") then
	{
		'You need to set the config value "DMS_Use_Map_Config" to false!' call DMS_fnc_DebugLog;
	}
	else
	{
		call compile _file;
	};
};

DMS_MagRange = DMS_MaximumMagCount - DMS_MinimumMagCount;

/*
	Original Functions from
	http://maca134.co.uk/portfolio/m3editor-arma-3-map-editor/

	Slightly modified by eraser1
*/

M3E_fnc_getCenter = DMS_fnc_GetCenter;

M3E_fnc_subArr = DMS_fnc_SubArr;

// Because I fucked up the name on first implementation and don't want to mess anybody up who didn't realize to change every occurence of "DMS_MaxSurfaceNormal" to "DMS_MinSurfaceNormal".
DMS_MaxSurfaceNormal = DMS_MinSurfaceNormal;


DMS_AttemptsUntilThrottle = DMS_AttemptsUntilThrottle + 1;

DMS_HelisToClean = [];
DMS_HeliParatrooper_Arr = [];
DMS_FrozenAIGroups = [];



DMS_CLIENT_fnc_spawnDynamicText = compileFinal
("
if (isNil 'DMS_CLIENT_DynamicText_inProgress') then
{
	DMS_CLIENT_DynamicText_inProgress = true;
	_this spawn
	{
		[
			_this,
			0,
			safeZoneY,
			"+str DMS_dynamicText_Duration+",
			"+str DMS_dynamicText_FadeTime+",
			0,
			24358
		] call BIS_fnc_dynamicText;
		DMS_CLIENT_DynamicText_inProgress = nil;
	};
}
else
{
	["+str (DMS_dynamicText_Duration+DMS_dynamicText_FadeTime) +",{_this call DMS_CLIENT_fnc_spawnDynamicText},_this,false,false] call ExileClient_system_thread_addTask;
};
");

DMS_CLIENT_fnc_spawnTextTiles = compileFinal
("
if (isNil 'DMS_CLIENT_TextTiles_inProgress') then
{
	DMS_CLIENT_TextTiles_inProgress = true;
	_this spawn
	{
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
		] call BIS_fnc_textTiles;
		DMS_CLIENT_TextTiles_inProgress = nil;
	};
}
else
{
	["+str (DMS_textTiles_Duration+DMS_textTiles_FadeTime) +",{_this call DMS_CLIENT_fnc_spawnTextTiles},_this,false,false] call ExileClient_system_thread_addTask;
};
");

DMS_CLIENT_fnc_hintSilent = compileFinal "hintSilent parsetext format['%1',_this];";


// Initialize mission variables...
CALLFILE("\x\addons\dms\missions\static_init.sqf");
CALLFILE("\x\addons\dms\missions\mission_init.sqf");


{
	private _mission = _x select 0;

	missionNamespace setVariable
	[
		format["DMS_SpecialMission_%1",_mission],
		compileFinal preprocessFileLineNumbers (format ["\x\addons\DMS\missions\special\%1.sqf",_mission])
	];

	missionNamespace setVariable [format["DMS_SpecialMissionSpawnCount_%1",_mission], 0];
	missionNamespace setVariable [format["DMS_SpecialMissionLastSpawn_%1",_mission], 0];
} forEach DMS_SpecialMissions;
