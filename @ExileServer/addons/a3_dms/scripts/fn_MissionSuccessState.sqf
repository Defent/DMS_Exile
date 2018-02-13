/*
	DMS_fnc_MissionSuccessState
	Created by eraser1

	Usage:
	[
		[_completionType1,_completionArgs1,_isAbsoluteCondition],
		[_completionType2,_completionArgs2,_isAbsoluteCondition],
		...
		[_completionTypeN,_completionArgsN,_isAbsoluteCondition]
	] call DMS_fnc_MissionSuccessState;
*/

if !(_this isEqualType []) exitWith
{
	diag_log format ["DMS ERROR :: DMS_fnc_MissionSuccessState called with invalid parameter: %1",_this];
};

private _success = true;
private _exit = false;

{
	if (_exit) exitWith {};

	try
	{
		if !(_x params
		[
			"_completionType",
			"_completionArgs"
		])
		then
		{
			diag_log format ["DMS ERROR :: DMS_fnc_MissionSuccessState has invalid parameters in: %1",_x];
			throw "ERROR";
		};


		private _absoluteWinCondition = _x param [2, false, [true]];

		if (!_success && {!_absoluteWinCondition}) then
		{
			throw format ["Skipping completion check for condition |%1|; Condition is not absolute and a previous condition has already been failed.",_x];
		};


		if (DMS_DEBUG) then
		{
			(format ["MissionSuccessState :: Checking completion type ""%1"" with argument |%2|. Absolute: %3",_completionType,_completionArgs,_absoluteWinCondition]) call DMS_fnc_DebugLog;
		};

		switch (toLower _completionType) do
		{
			case "kill":
			{
				_success = _completionArgs call DMS_fnc_TargetsKilled;
			};
			/*
			case "killpercent":
			{
				_success = _completionArgs call DMS_fnc_TargetsKilledPercent;//<---TODO
			};
			*/
			case "playernear":
			{
				_success = _completionArgs call DMS_fnc_IsPlayerNearby;
			};
			case "external":			// This is a special completion type. It is intended to be a flag for people who want to control mission completion using _onMonitorStart and _onMonitorEnd through array manipulation. You probably don't want to use this unless you know what you're doing.
			{
				_success = _completionArgs;
			};
			default
			{
				diag_log format ["DMS ERROR :: Invalid completion type (%1) with args: %2",_completionType,_completionArgs];
				throw "ERROR";
			};
		};


		if (_success && {_absoluteWinCondition}) then
		{
			_exit = true;
			throw format ["Mission completed because of absolute win condition: %1",_x];
		};
	}
	catch
	{
		if (DMS_DEBUG) then
		{
			(format ["MissionSuccessState :: %1",_exception]) call DMS_fnc_DebugLog;
		};
	};
} forEach _this;

_success;
