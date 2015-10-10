/*
	DMS_fnc_IsNearWater
	Original function by WAI
	Improved by eraser1

	Usage:
	[
		_position,
		_radius
	] call DMS_fnc_IsNearWater

*/

private["_result","_position","_radius"];

_position 	= _this select 0;
_radius		= _this select 1;


_result 	= false;

try
{
	if (surfaceIsWater _position) then
	{
		throw true;
	};

	for "_i" from 0 to 359 step 45 do
	{
		if (surfaceIsWater ([_position,_radius,_i] call DMS_fnc_SelectOffsetPos)) then
		{
			throw true;
		};
	};
}
catch
{
	_result = true;
};

_result