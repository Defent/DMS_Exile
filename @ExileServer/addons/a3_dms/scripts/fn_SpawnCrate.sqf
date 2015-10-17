/*
	DMS_fnc_SpawnCrate
	Created by eraser1

	Usage:
	[
		_crateClassName,			// STRING: The classname of the crate you want to spawn.
		_pos,						// ARRAY (position): Where to spawn the crate.
		_spawnATL					// (OPTIONAL) BOOLEAN: Whether or not to spawn the crate ATL (Above Terrain Level) or ASL (Above Sea Level). Default: true (ATL)
	] call DMS_fnc_SpawnCrate;
	Returns crate object

*/

private ["_crateClassName", "_pos", "_crate"];

_OK = params
[
	["_crateClassName","_crateClassName ERROR",[""]],
	["_pos","_pos ERROR",[[]],[3]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_SpawnCrate with invalid parameters: %1",_this];
	objNull
};

if !(isClass (configFile >> "CfgVehicles" >> _crateClassName)) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnCrate with non-existent vehicle className: %1",_crateClassName];
	objNull
};

_spawnATL = if ((count _this)>2) then {_this select 2} else {true};

_crate = createVehicle [_crateClassName,_pos,[], 0, "CAN_COLLIDE"];

_crate setDir (random 360);

if (_spawnATL) then
{
	_crate setPosATL _pos;
}
else
{
	_crate setPosASL _pos;
};

_crate allowDamage false;

clearWeaponCargoGlobal 		_crate;
clearItemCargoGlobal 		_crate;
clearMagazineCargoGlobal 	_crate;
clearBackpackCargoGlobal 	_crate;

if (DMS_HideBox) then
{
	_crate hideObjectGlobal true;
};

_crate;