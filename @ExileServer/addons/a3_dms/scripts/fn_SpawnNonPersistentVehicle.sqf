/*
	DMS_fnc_SpawnNonPersistentVehicle

	Spawns a vehicle, but it isn't saved to database by this function.
	This function takes into consideration Exile config settings for enabling/disabling Night Vision and Thermal Equipment on a vehicle.
	It will also apply all regular Exile EventHandlers, as well as an additional "RopeAttach" EventHandler that will enable simulation on a vehicle that is about to be lifted to prevent issues. (Only for helis)

	The vehicle is LOCKED, has godmode, disabled simulation, and is not able to be slingloaded on spawn.

	NOTE: This function only takes ATL, and will not necessarily spawn directly on the given pos. It will attempt to find a clear position for the given vehicle, and then spawn it at the "clear" position.
	If you want the vehicle to be placed precisely at the position provided, you will have to do a setPosXXX at that position on the vehicle after spawning.

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

if !(params
[
	"_vehicleClass",
	"_position"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnNonPersistentVehicle with invalid parameters: %1",_this];
	objNull
};

if !(isClass (configFile >> "CfgVehicles" >> _vehicleClass)) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnNonPersistentVehicle with non-existent vehicle className: %1",_vehicleClass];
	objNull
};

//make sure area to spawn vehicle is clear
_objs = nearestTerrainObjects [_position, ["TREE","BUSH","SMALL TREE","ROCK","ROCKS","FENCE","WALL"], 50];
{ _x hideObjectGlobal true; } forEach _objs;

private _vehObj = createVehicle [_vehicleClass, _position, [], 0, "NONE"];

clearWeaponCargoGlobal 		_vehObj;
clearItemCargoGlobal 		_vehObj;
clearBackpackCargoGlobal 	_vehObj;

if (_vehicleClass isKindOf "I_UGV_01_F") then
{
	createVehicleCrew _vehObj;
};
if (getNumber (configFile >> "CfgSettings" >> "VehicleSpawn" >> "nightVision") isEqualTo 0) then
{
	_vehObj disableNVGEquipment true;
};
if (getNumber (configFile >> "CfgSettings" >> "VehicleSpawn" >> "thermalVision") isEqualTo 0) then
{
	_vehObj disableTIEquipment true;
};

_vehObj setFuel (0.75+(random 0.25));
_vehObj setDir (random 360);

if ((getTerrainHeightASL _position)>0) then
{
	_vehObj setVectorUp (surfaceNormal _position);
};

_vehObj setVariable ["ExileMoney",0,true];
_vehObj setVariable ["ExileIsPersistent", false];
_vehObj setVariable ["ExileIsSimulationMonitored", false];
_vehObj addMPEventHandler ["MPKilled", { if (isServer) then {_this call ExileServer_object_vehicle_event_onMPKilled;};}];
_vehObj addEventHandler ["GetIn", {_this call ExileServer_object_vehicle_event_onGetIn}];


if (!isNil "AVS_Version") then
{
	_vehObj call AVS_fnc_sanitizeVehicle;
};

_vehObj lock 2;
_vehObj allowDamage false;
_vehObj enableRopeAttach false;
_vehObj enableSimulationGlobal false;


if (DMS_DEBUG) then
{
	(format ["SpawnNonPersistentVehicle :: Created %1 at %2 with calling parameters: %3",_vehObj,_position,_this]) call DMS_fnc_DebugLog;
};


_vehObj
