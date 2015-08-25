// Loads compiles 
// Made by Defent for Defents Mission System
// And for Numenadayz.com

if(isServer) then {

	// compilation list
	DMS_findSafePos				= compileFinal preprocessFileLineNumbers "scripts\DMS_findSafePos.sqf";
	DMS_createBox				= compileFinal preprocessFileLineNumbers "crates\DMS_CreateBox.sqf";
	DMS_CreateMarker 			= compileFinal preprocessFileLineNumbers "scripts\DMS_CreateMarker.sqf";
	DMS_spawnAI 				= compileFinal preprocessFileLineNumbers "scripts\DMS_spawnAI.sqf";
	DMS_selectMission 			= compileFinal preprocessFileLineNumbers "scripts\DMS_selectMission.sqf";
	DMS_CleanUp		     		= compileFinal preprocessFileLineNumbers "scripts\DMS_CleanUp.sqf";
	DMS_Config 				= compileFinal preprocessFileLineNumbers "scripts\DMS_Config.sqf";



	// not fully loaded yet
	DMS_Loaded 			= false;

	call DMS_Config;

	waitUntil {DMS_Loaded};

	call DMS_selectMission;
	
	
	diag_log "DMS :: Functions loaded - starting the rest of the script.";
	
	
};
