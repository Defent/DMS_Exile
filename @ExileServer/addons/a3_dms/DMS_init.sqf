// Made by Defent for Defents Mission System
// And for Numenadayz.com

	// Compiles for custom files.
	DMS_findSafePos				= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_findSafePos.sqf";
	DMS_createBox				= compile preprocessFileLineNumbers "\x\addons\dms\crates\DMS_CreateBox.sqf";
	DMS_CreateMarker 			= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_CreateMarker.sqf";
	DMS_spawnAI 				= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_spawnAI.sqf";
	DMS_selectMission 			= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_selectMission.sqf";
	DMS_CleanUp		     		= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_CleanUp.sqf";
	DMS_markerLoop				= compile preprocessFileLineNumbers "\x\addons\dms\scripts\DMS_markerLoop.sqf";
	
	
	// CONFIGS
	//DMS_UseMissions 		= true;
	//DMS_DetectNearWater 	= true;
	//DMS_MissionMin 		= 60; // Timers in seconds
	//DMS_MissionMax 		= 120; // Timers in seconds
	//DMS_player_minDist = 700;
	// CONFIGS

	uiSleep 2;
	
	// Selects the mission
	[] call DMS_selectMission;

	// Loops markers
	//[] call DMS_markerLoop;
 	
	diag_log "DMS :: Functions loaded - starting the rest of the script.";