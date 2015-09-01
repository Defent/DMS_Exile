/*
	Spawn a non-saved vehicle in Exile
	Created by Zupa
*/

private ["_vehicleClass","_position","_vehpos","_maxDistance","_vehObj"];

_vehicleClass = _this select 0;
_position = _this select 1;
_vehpos = [];
_maxDistance = 40;

while{count _vehpos < 1} do {
	_vehpos = _position findEmptyPosition[20,_maxDistance,_vehicleClass];
	_maxDistance = (_maxDistance + 15);
};

_vehObj = ObjNull;
_vehObj = [_vehicleClass, _vehpos, (random 360), true] call ExileServer_object_vehicle_createNonPersistentVehicle;
_vehObj
