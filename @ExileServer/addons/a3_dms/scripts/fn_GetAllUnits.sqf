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

private ["_units"];

if ((typeName _this)!="ARRAY") then
{
	_this = [_this];
};


_units = [];

{
	private ["_parameter", "_tN"];
	_parameter = _x;
	_tN = typeName _parameter;
	if (_tN == "ARRAY") then
	{
		_units append (_parameter call DMS_fnc_GetAllUnits);
	}
	else
	{
		if (_tN in ["OBJECT", "GROUP"]) then
		{
			if (!isNull _parameter) then
			{
				if (_tN == "OBJECT") then
				{
					if (alive _parameter) then
					{
						_units pushBack _parameter;
					};
				}
				else
				{
					{
						if (alive _x) then
						{
							_units pushBack _x;
						};
					} forEach (units _parameter);
				};
			};
		}
		else
		{
			diag_log format ["DMS ERROR :: Calling DMS_fnc_GetAllUnits with an invalid parameter: %1 | Type: %2", _x, _tN];
		};
	};
} forEach _this;

if (DMS_DEBUG) then
{
	(format ["GetAllUnits :: Input (%1) produced units: %2",_this,_units]) call DMS_fnc_DebugLog;
};


_units