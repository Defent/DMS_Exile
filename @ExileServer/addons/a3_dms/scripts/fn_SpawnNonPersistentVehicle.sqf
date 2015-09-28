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
	_maxDistance = (_maxDistance + 5);
};

_vehpos set [2, 0.1];

_vehObj = createVehicle [_vehicleClass, _vehpos, [], 0, "CAN_COLLIDE"];

clearBackpackCargoGlobal _vehObj;
clearItemCargoGlobal _vehObj;
clearMagazineCargoGlobal _vehObj;
clearWeaponCargoGlobal _vehObj;

_vehObj setFuel (0.75+(random 0.25));
_vehObj setDir (random 360);
_vehObj setPosATL _vehpos;
_vehObj setVectorUp (surfaceNormal _vehpos);

_vehObj setVariable ["ExileIsPersistent", false];
_vehObj addEventHandler ["GetIn", { _this call ExileServer_object_vehicle_event_onGetIn}];
if (_vehObj isKindOf "Helicopter") then
{
	_vehObj addEventHandler ["RopeAttach", 
	{
		private "_vehicle";
		_vehicle = _this select 2;

		if !(simulationEnabled _vehicle) then
		{
			_vehicle enableSimulationGlobal true;
		};
	}];
};

if (!isNil "RS_VLS") then
{
	[_vehObj] call RS_VLS_sanitizeVehicle;
};

_vehObj lock 2;
_vehObj allowDamage false;
_vehObj enableRopeAttach false;
_vehObj enableSimulationGlobal false;

if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG SpawnNonPersistentVehicle :: Created %1 at %2 with calling parameters: %3",_vehObj,_vehpos,_this];
};


_vehObj
