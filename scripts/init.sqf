// Loads compiles 
// Made by Defent for Defents Mission System
// And for Numenadayz.com

if(isServer) then {

	// compilation list
	DMS_findSafePos				= compile preprocessFileLineNumbers "mission\scripts\DMS_findSafePos.sqf";
	DMS_createBox				= compile preprocessFileLineNumbers "mission\crates\DMS_CreateBox.sqf";
	DMS_CreateMarker 			= compile preprocessFileLineNumbers "mission\scripts\DMS_CreateMarker.sqf";
	DMS_spawnAI 				= compile preprocessFileLineNumbers "mission\scripts\DMS_spawnAI.sqf";
	DMS_selectMission 			= compile preprocessFileLineNumbers "mission\scripts\DMS_selectMission.sqf";
	DMS_CleanUp		     		= compile preprocessFileLineNumbers "mission\scripts\DMS_CleanUp.sqf";


	// not fully loaded yet
	DMS_Loaded 			= false;

	execVM 	 "mission\scripts\DMS_Config.sqf";
	waitUntil {DMS_Loaded};

	execVM "mission\scripts\DMS_selectMission.sqf";
	
	
	diag_log "DMS :: Functions loaded - starting the rest of the script.";
	
	
};
