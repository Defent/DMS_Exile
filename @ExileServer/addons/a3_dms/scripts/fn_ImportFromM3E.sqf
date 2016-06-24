/*
	DMS_fnc_ImportFromM3E
	Created by eraser1

	Check out M3 Editor: http://maca134.co.uk/portfolio/m3editor-arma-3-map-editor/

	Usage:
	[
		_file,							// String: The filename (or filepath under the objects folder) that contains the exported M3E objects
		_pos 							// Object or Array: Center position
	] call DMS_fnc_ImportFromM3E;

	It takes RELATIVE POSITION as argument. In order to get relative positions, check this link: http://maca134.co.uk/portfolio/m3editor-arma-3-map-editor/

	Returns all created objects.
*/

if !(params
[
	["_file","",[""]],
	["_pos","",[[],objNull],[2,3]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E with invalid parameters: %1",_this];
	[]
};


// Get the position if an object was supplied instead of position
if (_pos isEqualType objNull) then
{
	_pos = getPosATL _pos;
};

// Set the center pos to 0 if it isn't defined
if ((count _pos)<3) then
{
	_pos set [2,0];
};

private _export = call compile preprocessFileLineNumbers (format ["\x\addons\DMS\objects\%1.sqf",_file]);

if ((isNil "_export") || {!(_export isEqualType [])}) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_ImportFromM3E with invalid file/filepath: %1 | _export: %2",_file,_export];
	[]
};

private _objs = _export apply
{
	// Create the object
	private _obj = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
	_obj enableSimulationGlobal false;

	// Calculate the object's position using provided relative position
	private _objPos = [_pos,_x select 1] call DMS_fnc_CalcPos;

	if (((count _x)>4) && {!(_x select 4)}) then
	{
		// Supports bank/pitch
		_obj setPosATL _objPos;
		_obj setVectorDirAndUp (_x select 3);
	}
	else
	{
		_obj setDir (_x select 2);
		_obj setPos _objPos;
	};

	_obj;
};


_objs
