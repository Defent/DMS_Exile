/*
	DMS_fnc_SelectOffsetPos
	Created by eraser1

	Usage:
	[
		_pos,
		_distance,
		_direction
	] call DMS_fnc_SelectOffsetPos;

	Returns a new position offset from the provided position with the provided distance and direction. Position provided is at ground level in ATL

*/

private ["_pos","_dis","_dir","_npos"];

_OK = params
[
	["_pos","",[[]],[2,3]],
	["_dis",0,[0]],
	["_dir",0,[0]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SelectOffsetPos with invalid parameters: %1",_this];
};

_npos = [(_pos select 0)+(sin(_dir)*_dis),(_pos select 1)+(cos(_dir)*_dis),0];


_npos