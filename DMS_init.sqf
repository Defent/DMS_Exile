// Loads compiles 
// Made by Defent for Defents Mission System
// And for Numenadayz.com

if(isServer) then {

	// compilation list
	DMS_findSafePos				= compile preprocessFileLineNumbers "\x\addons\DMS\scripts\DMS_findSafePos.sqf";
	DMS_createBox				= compile preprocessFileLineNumbers "\x\addons\DMS\crates\DMS_CreateBox.sqf";
	DMS_CreateMarker 			= compile preprocessFileLineNumbers "\x\addons\DMS\scripts\DMS_CreateMarker.sqf";
	DMS_spawnAI 				= compile preprocessFileLineNumbers "\x\addons\DMS\scripts\DMS_spawnAI.sqf";
	DMS_selectMission 			= compile preprocessFileLineNumbers "\x\addons\DMS\scripts\DMS_selectMission.sqf";
	DMS_CleanUp		     		= compile preprocessFileLineNumbers "\x\addons\DMS\scripts\DMS_CleanUp.sqf";
	DMS_Config 					= compile preprocessFileLineNumbers "\x\addons\DMS\scripts\DMS_Config.sqf";



	// not fully loaded yet
	/*
	DMS_Loaded = false;

	call DMS_Config;

	waitUntil {DMS_Loaded};
	
	
	*/

	//call DMS_selectMission;
	
	
	//[] call compile preprocessFileLineNumbers "\x\addons\DMS\scripts\DMS_selectMission.sqf";
	
	diag_log "DMS :: Functions loaded - starting the rest of the script.";
	
	
};
