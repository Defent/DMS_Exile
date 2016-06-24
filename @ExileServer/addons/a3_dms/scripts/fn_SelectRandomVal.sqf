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

if !(params
[
	"_min",
	"_max"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SelectRandomVal with invalid parameters: %1",_this];
};

_min + random(_max - _min)
