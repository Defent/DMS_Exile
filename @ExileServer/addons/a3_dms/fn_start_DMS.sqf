// Loads compiles 
// Made by Defent for Defents Mission System
// And for Numenadayz.com
// Rewritten by eraser1

//Load config
#include "config.sqf";

RESISTANCE setFriend[WEST,0];
WEST setFriend[RESISTANCE,0];
RESISTANCE setFriend[EAST,0];
EAST setFriend[RESISTANCE,0];
EAST setFriend[WEST,0];
WEST setFriend[EAST,0];

if(DMS_StaticMission) then {
	call compileFinal preprocessFileLineNumbers "\x\addons\dms\static\init.sqf";
};

if (DMS_DynamicMission) then {
	call compileFinal preprocessFileLineNumbers "\x\addons\dms\missions\mission_init.sqf";//<---- TODO
	[1, DMS_MissionStatusCheck, [], true] call ExileServer_system_thread_addTask;
};
