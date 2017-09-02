/*
	DMS_fnc_ImportFromM3E_3DEN
	Created by eraser1

	Check out M3 Editor - 3DEN: https://github.com/maca134/m3e_3den/releases

	Usage:
	[
		_file,							// String: The filename (or filepath under the objects folder) that contains the exported M3E objects
		_center 						// Object or Array (PositionATL): Center position
	] call DMS_fnc_ImportFromM3E_3DEN;

	This function is should be used with the "Export Objects (Relative)" command.

	Returns all created objects.
*/

if !(params
[
	["_file","",[""]],
	["_center","",[[],objNull],[2,3]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E with invalid parameters: %1",_this];
	[]
};


// Get the position if an object was supplied instead of position
if (_center isEqualType objNull) then
{
	_center = getPosATL _center;
};

// Set the center pos to 0 if it isn't defined
if ((count _center)<3) then
{
	_center set [2,0];
};

private _export = call compile preprocessFileLineNumbers (format ["\x\addons\DMS\objects\%1.sqf",_file]);

if ((isNil "_export") || {!(_export isEqualType [])}) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E with invalid file/filepath: %1 | _export: %2",_file,_export];
	[]
};

private _objs = _export apply
{
	private _object = (_x select 0) createVehicle [0,0,0];
	_object setDir (_x select 2);
	_object setPosATL (_center vectorAdd (_x select 1));
	_object enableSimulationGlobal ((_x select 3) select 0);
	_object allowDamage ((_x select 3) select 1);
	_object;
};


_objs
