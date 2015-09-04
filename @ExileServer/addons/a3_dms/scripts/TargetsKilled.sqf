/*
	DMS_TargetsKilled
	Created by eraser1
	
	Usage:
	[
		_unit,
		_group,
		_object
	] call DMS_TargetsKilled;

	Will accept non-array argument of group, unit, or object.
*/

if ((typeName _this) in ["GROUP","OBJECT"]) then
{
	_this = [_this];
};

if (_this isEqualTo []) exitWith
{
	diag_log "DMS ERROR :: Calling DMS_TargetsKilled with empty array!";
};

private "_killed";

_killed = false;

try
{
	{
		if (((typeName _x) == "OBJECT") && {!isNull _x && {alive _x}}) then
		{
			throw _x;
		}
		else
		{
			if !((typeName _x) == "GROUP") exitWith
			{
				diag_log format ["DMS ERROR :: %1 is neither OBJECT nor GROUP!",_x];
			};
			{
				if (!isNull _x && {alive _x}) exitWith
				{
					throw _x;
				};
			} forEach (units _x);
		};
	} forEach _this;

	_killed = true;
}
catch
{
	if (DMS_DEBUG) then {
		diag_log format ["DMS_DEBUG TargetsKilled :: %1 is still alive! All of %2 are not yet killed!",_exception,_this];
	};
};

_killed;