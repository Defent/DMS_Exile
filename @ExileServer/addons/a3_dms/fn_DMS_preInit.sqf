/*
	DMS Pre-init (compiles)
	Written by eraser1 (trainwreckdayz.com)
*/

/* compiles
spawn_static			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\spawn_static.sqf";
heli_para				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\heli_para.sqf";
heli_patrol				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\heli_patrol.sqf";
vehicle_patrol			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\vehicle_patrol.sqf";
vehicle_monitor			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\vehicle_monitor.sqf";
*/

//Completed or WIP
DMS_selectMission 					= compileFinal preprocessFileLineNumbers "\x\addons\dms\missions\SelectMission.sqf";
DMS_MissionsMonitor					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\MissionsMonitor.sqf";
DMS_MissionSuccessState 			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\MissionSuccessState.sqf";
DMS_findSafePos						= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\FindSafePos.sqf";
DMS_BroadcastMissionStatus			= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\BroadcastMissionStatus.sqf";
DMS_CleanUp		     				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\CleanUp.sqf";
DMS_CleanUpManager					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\CleanUpManager.sqf";
DMS_isPlayerNearbyARRAY				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\IsPlayerNearbyARRAY.sqf";
DMS_FillCrate						= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\FillCrate.sqf";
DMS_isNearWater						= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\IsNearWater.sqf";
DMS_RemoveMarkers					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\RemoveMarkers.sqf";
DMS_selectMagazine					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\SelectMagazine.sqf";
DMS_TargetsKilled					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\TargetsKilled.sqf";
DMS_SpawnAIGroup					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\SpawnAIGroup.sqf";
DMS_SpawnAISoldier					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\SpawnAISoldier.sqf";
DMS_OnKilled						= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\OnKilled.sqf";
DMS_SetGroupBehavior				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\SetGroupBehavior.sqf";
DMS_AddMissionToMonitor				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\AddMissionToMonitor.sqf";
DMS_CreateMarker 					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\CreateMarker.sqf";
DMS_FindSuppressor					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\FindSuppressor.sqf";
DMS_SpawnCrate						= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\SpawnCrate.sqf";
DMS_SetAILocality					= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\SetAILocality.sqf";
DMS_AILocalityManager				= compileFinal preprocessFileLineNumbers "\x\addons\dms\scripts\AILocalityManager.sqf";

//Load config
call compileFinal preprocessFileLineNumbers "\x\addons\dms\config.sqf";