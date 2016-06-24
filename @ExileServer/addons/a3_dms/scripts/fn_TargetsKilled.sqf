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

if (_this isEqualTo []) exitWith
{
	diag_log "DMS ERROR :: Calling DMS_TargetsKilled with empty array!";
};

private _killed = false;

try
{
	{
		private _lastDistanceCheckTime = _x getVariable ["DMS_LastAIDistanceCheck",time];
		private _pos = getPosWorld _x;
		private _spawnPos = _x getVariable ["DMS_AISpawnPos",0];

		if ((DMS_MaxAIDistance>0) && {!(_spawnPos isEqualTo 0)} && {((time - _lastDistanceCheckTime)>DMS_AIDistanceCheckFrequency) && {(_pos distance2D _spawnPos)>DMS_MaxAIDistance}}) then
		{
			_x setDamage 1;
			diag_log format ["Killed a runaway unit! |%1| was more than %2m away from its spawn position %3!",_x,DMS_MaxAIDistance,_spawnPos];
		}
		else
		{
			_x setVariable ["DMS_LastAIDistanceCheck",time];
			throw _x;
		};
	} forEach (_this call DMS_fnc_GetAllUnits);					// DMS_fnc_GetAllUnits will return living AI unit objects only, so we only need to check for runaway units

	_killed = true;
}
catch
{
	if (DMS_DEBUG) then
	{
		(format ["TargetsKilled :: %1 is still alive! All of %2 are not yet killed!",_exception,_this]) call DMS_fnc_DebugLog;
	};
};

_killed;
