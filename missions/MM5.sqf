private ["_crate","_pos","_missname","_aiAmmount","_misText","_missEnd","_group"];
 
/*
_playerClose = false;
_mainTimer = true;
//_missStartTime = floor(time);
*/

// associate pos with find safe pos
_pos = call DMS_findSafePos; 

uiSleep 1;


_missname = "Main Mission 5";
diag_log format ["DMS :: Main Mission 5 started at (%1)",_pos];

["standardHintRequest",["Mission starting! Check your map"]] call ExileServer_system_network_send_broadcast;


// Spawn Marker
[_pos,_missname] call DMS_CreateMarker;

// Spawn Box
_crate = createVehicle ["Box_NATO_AmmoOrd_F",[(_pos select 0) - 10, _pos select 1,0],[], 0, "CAN_COLLIDE"];
//[_crate] call createBox;
// [_crate, amount of weapons, amount of ammo] call createBox;
[1,_crate] call DMS_createBox;

sleep 2;


//[_pos, amount of ai ] call DMS_SpawnAI;
[_pos,4] call DMS_SpawnAI;



waitUntil{{isPlayer _x && _x distance _pos < 30  } count playableUnits > 0}; 


["standardHintRequest",["Mission has ended, good job!"]] call ExileServer_system_network_send_broadcast;

//  Run Cleanup
[] call DMS_CleanUp;
 

 	deleteMarker "DMS_MainMarker";
	deleteMarker "DMS_MainDot";

sleep 150;

[] call DMS_SelectMission;
