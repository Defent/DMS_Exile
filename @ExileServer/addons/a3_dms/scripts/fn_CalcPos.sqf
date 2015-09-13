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


_OK = params
[
	["_pos","",[[],objNull]],
	["_relPos","",[[]],[2,3]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_CalcPos with invalid parameters: %1",_this];
};


// Get the position if an object was supplied instead of position
if ((typeName _pos)=="OBJECT") then
{
	_pos = getPos _pos;
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


_npos =
[
	(_pos select 0)+(_relPos select 0),
	(_pos select 1)+(_relPos select 1),
	(_pos select 2)+(_relPos select 2)
];


_npos