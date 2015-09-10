/*
	DMS Pre-init
	Written by eraser1 (trainwreckdayz.com)
*/

/* Future stuff
DMS_HeliPara			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\HeliPara.sqf";
DMS_HeliPatrol			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\HeliPatrol.sqf";
DMS_VehPatrol			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\VehPatrol.sqf";
DMS_VehMonitor			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\VehMonitor.sqf";
*/

DMS_HC_Object = objNull;

//Load config
call compileFinal preprocessFileLineNumbers "\x\addons\dms\config.sqf";