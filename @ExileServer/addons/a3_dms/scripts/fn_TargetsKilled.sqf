/*
	DMS_fnc_TargetsKilled
	Created by eraser1
	
	Usage:
	[
		_unit,
		_group,
		_object
	] call DMS_fnc_TargetsKilled;

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
			private ["_lastDistanceCheckTime", "_spawnPos"];

			_lastDistanceCheckTime = _x getVariable ["DMS_LastAIDistanceCheck",time];
			_pos = getPosWorld _x;
			_spawnPos = _x getVariable ["DMS_AISpawnPos",_pos];

			if ((DMS_MaxAIDistance>0) && {((time - _lastDistanceCheckTime)>DMS_AIDistanceCheckFrequency) && {(_pos distance2D _spawnPos)>DMS_MaxAIDistance}}) then
			{
				_x setDamage 1;
				diag_log format ["Killed a runaway unit! |%1| was more than %2m away from its spawn position %3!",_x,DMS_MaxAIDistance,_x getVariable "DMS_AISpawnPos"];
			}
			else
			{
				throw _x;
			};
		}
		else
		{
			if ((typeName _x) != "GROUP") exitWith
			{
				diag_log format ["DMS ERROR :: %1 is neither OBJECT nor GROUP!",_x];
			};
			{
				if (alive _x) then
				{
					private ["_lastDistanceCheckTime", "_spawnPos"];

					_lastDistanceCheckTime = _x getVariable ["DMS_LastAIDistanceCheck",time];
					_pos = getPosWorld _x;
					_spawnPos = _x getVariable ["DMS_AISpawnPos",_pos];

					if ((DMS_MaxAIDistance>0) && {((time - _lastDistanceCheckTime)>DMS_AIDistanceCheckFrequency) && {(_pos distance2D _spawnPos)>DMS_MaxAIDistance}}) then
					{
						_x setDamage 1;
						diag_log format ["Killed a runaway unit! |%1| was more than %2m away from its spawn position %3!",_x,DMS_MaxAIDistance,_x getVariable "DMS_AISpawnPos"];
					}
					else
					{
						throw _x;
					};
				};
			} forEach (units _x);
		};
	} forEach _this;

	_killed = true;
}
catch
{
	if (DMS_DEBUG) then
	{
		diag_log format ["DMS_DEBUG TargetsKilled :: %1 is still alive! All of %2 are not yet killed!",_exception,_this];
	};
};

_killed;