/*
	DMS_fnc_ImportFromM3E_3DEN_Convert
	Created by eraser1

	Check out M3 Editor - 3DEN: https://github.com/maca134/m3e_3den/releases

	Usage:
	[
		_file,							// String: The filename (or filepath under the objects folder) that contains the exported M3E objects
		_missionPos 					// Object or Array: Center position
	] call DMS_fnc_ImportFromM3E_3DEN_Convert;

	This function will take a file exported from M3Editor, convert it into relative position, then place the objects from the converted relative positions.
	Use this function if you don't know how to get the relative position, and you only have the exported static positions.

	This function will return all created objects.
*/

if !(params
[
	["_file","",[""]],
	["_missionPos","",[[],objNull],[2,3]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E_Convert with invalid parameters: %1",_this];
	[]
};


// Get the position if an object was supplied instead of position
if (_missionPos isEqualType objNull) then
{
	_missionPos = getPosATL _missionPos;
};

// Set the center pos to 0 if it isn't defined
if ((count _missionPos)<3) then
{
	_missionPos set [2,0];
};


private _export = call compile preprocessFileLineNumbers (format ["\x\addons\DMS\objects\static\%1.sqf",_file]);

if ((isNil "_export") || {!(_export isEqualType [])}) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E_Convert with invalid file/filepath: %1 | _export: %2",_file,_export];
	[]
};

private _objs = _export apply
{
	private _object = (_x select 0) createVehicle [0,0,0];
	_object setPosASL ((_x select 1) vectorAdd [0,0,5000]);
	_object setVectorDirAndUp (_x select 2);
	_object enableSimulationGlobal ((_x select 3) select 0);
	_object allowDamage ((_x select 3) select 1);

	_object;
};

[_objs,_missionPos] call DMS_fnc_SetRelPositions;


_objs
