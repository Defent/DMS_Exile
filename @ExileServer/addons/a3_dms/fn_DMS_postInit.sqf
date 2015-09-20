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
	call compileFinal preprocessFileLineNumbers "\x\addons\dms\missions\mission_init.sqf";
	execFSM "\x\addons\dms\FSM\missions.fsm";
};
