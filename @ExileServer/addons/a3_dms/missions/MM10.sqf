private ["_crate","_pos","_missname","_aiAmmount","_misText","_missEnd","_group"];
 
// associate pos with find safe pos
_pos = call DMS_findSafePos; 


_missname = "Main Mission 10";
diag_log format ["DMS :: Main Mission 10 started at (%1)",_pos];

["standardHintRequest",["Mission starting! Check your map"]] call ExileServer_system_network_send_broadcast;


// Spawn Marker
[_pos,_missname] call DMS_CreateMarker;

// Spawn Box
_crate = createVehicle ["Box_NATO_Wps_F",[(_pos select 0) - 10, _pos select 1,0],[], 0, "CAN_COLLIDE"];
[1,_crate] call DMS_createBox;

uiSleep 2;

// spawn AI
[_pos,5,4] call DMS_SpawnAI;


 waitUntil{sleep 1; {(isPlayer _x) && (_x distance _pos < 30)  } count playableUnits > 0}; 
 

["standardHintRequest",["Mission has ended, good job!"]] call ExileServer_system_network_send_broadcast;

//  Run Cleanup
[_pos,_crate] call DMS_CleanUp;
 

[] call DMS_SelectMission;
