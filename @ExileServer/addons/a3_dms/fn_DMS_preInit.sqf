/*
	DMS Pre-init (compiles)
	Written by eraser1 (trainwreckdayz.com)
*/

// Initialize Variables
DMS_Mission_Arr = [];
DMS_MissionCount = 0;

/* compiles
DMS_CreateMarker 		= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_CreateMarker.sqf";
DMS_spawnAI 			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_spawnAI.sqf";
DMS_selectMission 		= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_selectMission.sqf";
spawn_group				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\spawn_group.sqf";
spawn_soldier			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\spawn_soldier.sqf";
spawn_static			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\spawn_static.sqf";
group_waypoints			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\group_waypoints.sqf";
heli_para				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\heli_para.sqf";
heli_patrol				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\heli_patrol.sqf";
vehicle_patrol			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\vehicle_patrol.sqf";
on_kill					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\on_kill.sqf";
bandit_behaviour		= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\bandit_behaviour.sqf";
vehicle_monitor			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\vehicle_monitor.sqf";
find_position			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\find_position.sqf";
load_ammo				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\load_ammo.sqf";
*/

//Completed
DMS_MissionStatusCheck				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\MissionStatusCheck.sqf";
DMS_MissionSuccessState 			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\MissionSuccessState.sqf";//<--- TODO
DMS_findSafePos						= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\FindSafePos.sqf";
DMS_BroadcastMissionStatus			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\BroadcastMissionStatus.sqf";
DMS_CleanUp		     				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\CleanUp.sqf";
DMS_isPlayerNearbyARRAY				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\IsPlayerNearbyARRAY.sqf";
DMS_FillCrate						= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\FillCrate.sqf";
DMS_isNearWater						= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\IsNearWater.sqf";
DMS_RemoveMarkers					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\RemoveMarkers.sqf";
DMS_selectMagazine					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\SelectMagazine.sqf";

//Load config
#include "config.sqf";