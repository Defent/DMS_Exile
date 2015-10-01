/*
	DMS_fnc_ImportFromM3E_Convert
	Created by eraser1

	Check out M3 Editor: http://maca134.co.uk/portfolio/m3editor-arma-3-map-editor/

	Usage:
	[
		_file,							// String: The filename (or filepath under the objects folder) that contains the exported M3E objects
		_missionPos 					// Object or Array: Center position
	] call DMS_fnc_ImportFromM3E;

	This function will take a file exported from M3Editor, convert it into relative position, then place the objects from the converted relative positions.
	Use this function if you don't know how to get the relative position, and you only have the exported static positions.

	This function will return all created objects.
*/

private ["_file", "_missionPos", "_objs", "_export", "_obj", "_objPos"];

_OK = params
[
	["_file","",[""]],
	["_missionPos","",[[],objNull],[2,3]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E with invalid parameters: %1",_this];
	[]
};


// Get the position if an object was supplied instead of position
if ((typeName _missionPos)=="OBJECT") then
{
	_missionPos = getPosATL _missionPos;
};

// Set the center pos to 0 if it isn't defined
if ((count _missionPos)<3) then
{
	_missionPos set [2,0];
};


_objs = [];


_export = call compile preprocessFileLineNumbers (format ["\x\addons\DMS\objects\static\%1.sqf",_file]);


{
	private ["_obj","_pos"];
	_obj = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
	_pos = _x select 1;
	_pos set [2,(_pos select 2)+5000];
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

[_objs,_missionPos] call DMS_fnc_setRelPositions;


_objs