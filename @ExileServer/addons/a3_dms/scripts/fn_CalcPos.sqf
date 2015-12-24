/*
	DMS_fnc_CalcPos
	Created by eraser1

	Usage:
	[
		_positionOrObject,				// Object or Position: The center
		_relativePosition				// Array: The offset
	] call DMS_fnc_CalcPos;

	Returns the absolute position from the provided relative position from the provided center position or object.
*/


private ["_pos", "_relPos", "_npos"];



if !(params
[
	["_pos","",[[],objNull],[2,3]],
	["_relPos","",[[]],[2,3]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_CalcPos with invalid parameters: %1",_this];
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


// Set the z-pos offset to 0 if it isn't defined
if ((count _relPos)<3) then
{
	_relPos set [2,0];
};

// Script command "vectorAdd" is much faster than adding each element manually.
_pos vectorAdd _relPos