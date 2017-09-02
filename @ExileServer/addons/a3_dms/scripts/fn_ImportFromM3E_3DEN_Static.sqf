/*
	DMS_fnc_ImportFromM3E_3DEN_Static
	Created by eraser1

	Check out M3 Editor - 3DEN: https://github.com/maca134/m3e_3den/releases

	Usage:
	[
		_file							// String: The filename (or filepath under the objects folder) that contains the exported M3E objects
	] call DMS_fnc_ImportFromM3E_3DEN_Static;

	_file call DMS_fnc_ImportFromM3E_3DEN_Static; // This also works

	This function will simply create the objects from a file that was exported from M3Editor, and return a list of those objects.
*/

if !(params
[
	["_file","",[""]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E_Static with invalid parameters: %1",_this];
	[]
};

// The next few lines checks to see if the static base has been spawned previously, in order to avoid spawning duplicate objects.
private _varname = format ["DMS_StaticBaseSpawned_%1",_file];

if (missionNamespace getVariable [_varname,false]) exitWith
{
	diag_log format ["DMS ERROR :: Attempting to spawn static base with file ""%1"" after it has already been spawned!",_file];
};

missionNamespace setVariable [_varname,true];


private _export = call compile preprocessFileLineNumbers (format ["\x\addons\DMS\objects\static\%1.sqf",_file]);

if ((isNil "_export") || {!(_export isEqualType [])}) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E_Static with invalid file/filepath: %1 | _export: %2",_file,_export];
	[]
};

private _objs = _export apply
{
	private _object = (_x select 0) createVehicle [0,0,0];
	_object setPosASL (_x select 1);
	_object setVectorDirAndUp (_x select 2);
	_object enableSimulationGlobal ((_x select 3) select 0);
	_object allowDamage ((_x select 3) select 1);

	_object;
};


_objs
