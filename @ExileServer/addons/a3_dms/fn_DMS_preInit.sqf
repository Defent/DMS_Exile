/*
	DMS Pre-init
	Written by eraser1 (trainwreckdayz.com)
*/
#define CALLFILE(FILE) call compile preprocessFileLineNumbers FILE;

DMS_HC_Object = objNull;

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


DMS_AttemptsUntilThrottle = DMS_AttemptsUntilThrottle + 1;

DMS_HelisToClean = [];
DMS_HeliParatrooper_Arr = [];


// Initialize mission variables...
CALLFILE("\x\addons\dms\missions\static_init.sqf");
CALLFILE("\x\addons\dms\missions\mission_init.sqf");
