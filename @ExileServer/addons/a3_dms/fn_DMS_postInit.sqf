/*
	Launches mission functions
	Made for Defent for Defents Mission System
	And for Numenadayz.com
	Written by eraser1


	[_delay, _function, _params, _persistance] call ExileServer_system_thread_addTask;
*/

RESISTANCE setFriend[WEST,0];
WEST setFriend[RESISTANCE,0];
RESISTANCE setFriend[EAST,0];
EAST setFriend[RESISTANCE,0];
EAST setFriend[WEST,0];
WEST setFriend[EAST,0];

_code =
{
	"DMS_HC_INIT" addPublicVariableEventHandler
	{
		DMS_HC_Object = _this select 1 select 0;
		diag_log format ["DMS Headless Client :: DMS_HC_Object = %1 | serverTime: %2",DMS_HC_Object,(_this select 1 select 1)];
	};
};
[0, _code, [], false] call ExileServer_system_thread_addTask;


if(DMS_StaticMission) then
{
	call compileFinal preprocessFileLineNumbers "\x\addons\dms\static\static_init.sqf";//<---- TODO
};

if (DMS_DynamicMission) then
{
	call compileFinal preprocessFileLineNumbers "\x\addons\dms\missions\mission_init.sqf";
	execFSM "\x\addons\dms\FSM\missions.fsm";
};
