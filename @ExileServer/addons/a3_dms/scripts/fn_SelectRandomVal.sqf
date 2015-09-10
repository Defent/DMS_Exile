/*
	DMS_fnc_SelectRandomVal
	Created by eraser1

	Usage:
	[
		_min,
		_max
	] call DMS_fnc_SelectRandomVal;

	Returns a random value between _min and _max.

*/

private ["_OK", "_min", "_max", "_return"];

_OK = params
[
	["_min",0,[0]],
	["_max",0,[0]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SelectRandomVal with invalid parameters: %1",_this];
};

_return	= _min + random(_max - _min);

_return