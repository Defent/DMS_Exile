/*
	DMS Pre-init
	Written by eraser1 (trainwreckdayz.com)
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


// Initialize mission variables...
CALLFILE("\x\addons\dms\missions\static_init.sqf");
CALLFILE("\x\addons\dms\missions\mission_init.sqf");
