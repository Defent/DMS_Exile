private ["_crate","_pos","_missname","_aiAmmount","_misText","_missEnd","_group"];
 
/*
_playerClose = false;
_mainTimer = true;
//_missStartTime = floor(time);
*/

// associate pos with find safe pos
_pos = call DMS_findSafePos; 

uiSleep 1;
 

_missname = "Main Mission 10";
diag_log format ["DMS :: Main Mission 10 started at (%1)",_pos];

["standardHintRequest",["Mission starting! Check your map"]] call ExileServer_system_network_send_broadcast;


// Spawn Marker
[_pos,_missname] call DMS_CreateMarker;

// Spawn Box
_crate = createVehicle ["Box_NATO_Wps_F",[(_pos select 0) - 10, _pos select 1,0],[], 0, "CAN_COLLIDE"];
[1,_crate] call DMS_createBox;

uiSleep 2;
//_crate = [_pos,40,4,2,2] execVM "mission\crates\MM_Box1.sqf";

// spawn AI
//[_pos,5,4] call DMS_SpawnAI;
[_pos,5,4] call DMS_SpawnAI;



 waitUntil{sleep 1; {(isPlayer _x) && (_x distance _pos < 30)  } count playableUnits > 0}; 
 
uiSleep 1;

["standardHintRequest",["Mission has ended, good job!"]] call ExileServer_system_network_send_broadcast;

//  Run Cleanup
[_pos] call DMS_CleanUp;
 

uiSleep 150;

[] call DMS_SelectMission;

