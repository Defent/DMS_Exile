// Loads compiles 
// Made by Defent for Defents Mission System
// And for Numenadayz.com


if(isServer) then {

	// compilation list
	DMS_findSafePos				= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_findSafePos.sqf";
	DMS_createBox				= compile preprocessFileLineNumbers "\x\addons\dms\crates\DMS_CreateBox.sqf";
	DMS_CreateMarker 			= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_CreateMarker.sqf";
	DMS_spawnAI 				= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_spawnAI.sqf";
	DMS_selectMission 			= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_selectMission.sqf";
	DMS_CleanUp		     		= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_CleanUp.sqf";
	//DMS_Config 					= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_Config.sqf";
	
	// CONFIGS
	//DMS_UseMissions 		= true;
	//DMS_DetectNearWater 	= true;
	//DMS_MissionMin 		= 60; // Timers in seconds
	//DMS_MissionMax 		= 120; // Timers in seconds
	// CONFIGS

	uiSleep 2;
	

	
	//[] call compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_selectMission.sqf";
	//[] execVM "\x\addons\dms\scripts\DMS_selectMission.sqf";
	[] call DMS_selectMission;
	
	diag_log "DMS :: Functions loaded - starting the rest of the script.";
	
	
};
