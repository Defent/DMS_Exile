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

if ((typeName _this) != "ARRAY") exitWith
{
	diag_log format ["DMS ERROR :: DMS_fnc_MissionSuccessState called with invalid parameter: %1",_this];
};

private ["_success", "_exit"];

_success = true;
_exit = false;

{
	if (_exit) exitWith {};

	try
	{
		private ["_OK","_completionType","_completionArgs","_absoluteWinCondition"];

		_OK = _x params
		[
			["_completionType", "", [""] ],
			["_completionArgs", [], [[],grpNull] ]
		];

		if (!_OK) then
		{
			diag_log format ["DMS ERROR :: DMS_fnc_MissionSuccessState has invalid parameters in: %1",_x];
			throw "ERROR";
		};


		_absoluteWinCondition = false;
		if (((count _x)>2) && {_x select 2}) then
		{
			_absoluteWinCondition = true;
		};

		if (!_success && {!_absoluteWinCondition}) then
		{
			throw format ["Skipping completion check for condition |%1|; Condition is not absolute and a previous condition has already been failed.",_x];
		};


		if (DMS_DEBUG) then
		{
			diag_log format ["DMS_DEBUG MissionSuccessState :: Checking completion type %1 with parameter %2. Absolute: %3",_completionType,_completionArgs,_absoluteWinCondition];
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
			diag_log format ["DMS_DEBUG MissionSuccessState :: %1",_exception];
		};
	};
} forEach _this;

_success;