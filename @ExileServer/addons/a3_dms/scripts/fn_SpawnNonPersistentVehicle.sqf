/*
	DMS_fnc_SpawnNonPersistentVehicle

	Spawn a non-saved vehicle in Exile

	Created by Zupa
	Edited by eraser1
	
	Usage: 
    [
    	_vehicleClass,					// STRING: Classname of the vehicle
    	_pos 							// ARRAY: Position to spawn it at (roughly)
    ] call DMS_fnc_SpawnNonPersistentVehicle;

	Returns the vehicle object of the created vehicle.

	EXAMPLE:
	_exampleVeh = ['Exile_Chopper_Hummingbird_Green',_pos] call DMS_fnc_SpawnNonPersistentVehicle;

*/

private ["_vehicleClass","_position","_vehpos","_maxDistance","_vehObj"];

_OK = params
[
	["_vehicleClass","",[""]],
	["_position","",[[]],[2,3]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_SpawnNonPersistentVehicle with invalid parameters: %1",_this];
};

_vehpos = [];
_maxDistance = 10;

while{count _vehpos < 1} do
{
	_vehpos = _position findEmptyPosition [20,_maxDistance,_vehicleClass];
	_maxDistance = (_maxDistance + 15);
};

_vehObj = [_vehicleClass, _vehpos, (random 360), true] call ExileServer_object_vehicle_createNonPersistentVehicle;
_vehObj allowDamage false;
_vehObj setFuel 1;
_vehObj lock 2;
_vehObj setVectorUp (surfaceNormal _vehpos);

if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG SpawnNonPersistentVehicle :: Created %1 at %2 with calling parameters: %3",_vehObj,_vehpos,_this];
};


_vehObj
