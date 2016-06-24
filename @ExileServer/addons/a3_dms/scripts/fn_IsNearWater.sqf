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

if !(params
[
	"_position",
	"_radius"
])
exitWith
{
	diag_log format["DMS ERROR :: Calling DMS_fnc_IsNearWater with invalid parameters: %1",_this];
	false
};

private _result	= false;

try
{
	if (surfaceIsWater _position) then
	{
		throw true;
	};

	for "_i" from 0 to 359 step 45 do
	{
		if (surfaceIsWater (_position getPos [_radius,_i])) then
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
