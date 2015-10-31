/*
	DMS_fnc_ImportFromM3E_Static
	Created by eraser1

	Check out M3 Editor: http://maca134.co.uk/portfolio/m3editor-arma-3-map-editor/

	Usage:
	[
		_file							// String: The filename (or filepath under the objects folder) that contains the exported M3E objects
	] call DMS_fnc_ImportFromM3E_Static;

	_file call DMS_fnc_ImportFromM3E_Static; // This also works

	This function will simply create the objects from a file that was exported from M3Editor.
*/

private ["_OK", "_varname", "_file", "_export"];


_OK = params
[
	["_file","",[""]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E_Static with invalid parameters: %1",_this];
	[]
};

_varname = format ["DMS_StaticBaseSpawned_%1",_file];

if (missionNamespace getVariable [_varname,false]) exitWith
{
	diag_log format ["DMS ERROR :: Attempting to spawn static base with file ""%1"" after it has already been spawned!",_file];
};

missionNamespace setVariable [_varname,true];



_export = call compile preprocessFileLineNumbers (format ["\x\addons\DMS\objects\static\%1.sqf",_file]);

if ((isNil "_export") || {(typeName _export)!="ARRAY"}) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E_Static with invalid file/filepath: %1 | _export: %2",_file,_export];
	[]
};


_objs = [];

{
	private ["_obj","_pos"];
	_obj = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
	_pos = _x select 1;
	_obj enableSimulationGlobal false;
	if (_x select 4) then
	{
		_obj setDir (_x select 2);
		_obj setPosATL _pos;
	}
	else
	{
		_obj setPosATL _pos;
		_obj setVectorDirAndUp (_x select 3);
	};
	_objs pushBack _obj;
} foreach _export;


_objs