/*
	DMS_fnc_SpawnCrate
	Created by eraser1

	Usage:
	[
		_crateClassName,
		_pos
	] call DMS_fnc_SpawnCrate;
	Returns crate object

*/

private ["_crateClassName", "_pos", "_crate"];

_OK = params
[
	["_crateClassName","ERROR",[""]],
	["_pos","ERROR",[[]],[3]]
];

if (!_OK) then
{
	diag_log format ["DMS ERROR :: Calling DMS_SpawnCrate with invalid parameters: %1",_this];
};

_crate = createVehicle [_crateClassName,_pos,[], 0, "CAN_COLLIDE"];

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