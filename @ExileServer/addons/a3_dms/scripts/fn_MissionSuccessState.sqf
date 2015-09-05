/*
	DMS_fnc_MissionSuccessState
	Created by eraser1
	
	Usage:
	[
		[_completionType1,_completionArgs1],
		[_completionType2,_completionArgs2],
		...
		[_completionTypeN,_completionArgsN]
	] call DMS_fnc_MissionSuccessState;
*/

if !((typeName _this) == "ARRAY") exitWith
{
	diag_log format ["DMS ERROR :: DMS_MissionSuccessState called with invalid parameter: %1",_this];
};

private "_success";

_success = true;

{
	if (!_success) exitWith
	{
		if (DMS_DEBUG) then
		{
			diag_log format ["DMS_DEBUG MissionSuccessState :: Mission not yet completed with parameters: %1 | at time %2",_this,diag_tickTime];
		};
	};

	private ["_OK","_completionType","_completionArgs"];

	_OK = _x params
	[
		["_completionType", "", [""] ],
		["_completionArgs", [], [[],grpNull] ]
	];

	if (!_OK) exitWith
	{
		diag_log format ["DMS ERROR :: DMS_MissionSuccessState has invalid parameters in: %1",_x];
	};

	switch (_completionType) do 
	{
		// Using switch-do so that future cases can be added easily
		case "kill":
		{
			_success = _completionArgs call DMS_fnc_TargetsKilled;
		};
		case "killPercent":
		{
			_success = _completionArgs call DMS_fnc_TargetsKilledPercent;//<---TODO
		};
		case "playerNear":
		{
			_success = _completionArgs call DMS_fnc_IsPlayerNearby;
		};
	};
} forEach _this;

_success;