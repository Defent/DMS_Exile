/*
	DMS_fnc_GetAllUnits
	Created by eraser1


	Usage:
	[
		_unitOrGroupOrArray1,
		_unitOrGroupOrArray2,
		...
		_unitOrGroupOrArrayN
	] call DMS_fnc_GetAllUnits;

	Returns all living units from a given array of groups or objects.
*/

if !(_this isEqualType []) then
{
	_this = [_this];
};

private _units = [];

{
	private _parameter = _x;

	_units append
	(
		switch (typeName _parameter) do
		{
			case "ARRAY":
			{
				_parameter call DMS_fnc_GetAllUnits
			};

			case "OBJECT":
			{
				[
					[],
					[_parameter]
				] select (alive _parameter);
			};

			case "GROUP":
			{
				(units _parameter) select {alive _x};
			};

			default
			{
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GetAllUnits with an invalid parameter: %1 | Type: %2", _parameter, typeName _parameter];
				[]
			};
		}
	);
} forEach _this;

if (DMS_DEBUG) then
{
	(format ["GetAllUnits :: Input (%1) produced units: %2",_this,_units]) call DMS_fnc_DebugLog;
};


_units
