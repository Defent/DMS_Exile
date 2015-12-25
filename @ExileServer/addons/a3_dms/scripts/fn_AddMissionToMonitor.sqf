/*
	DMS_fnc_AddMissionToMonitor
	Created by eraser1

	Parses and adds mission information to "DMS_Mission_Arr" for Mission Monitoring.

	Usage:
	[
		_position,
		[
			[
				_completionType1,
				_completionArgs1
			],
			[
				_completionType2,
				_completionArgs3
			],
			...
			[
				_completionTypeN,
				_completionArgsN
			],
		],
		[
			_timeStarted,
			_timeUntilFail
		],
		[
			_AIUnitOrGroup1,
			_AIUnitOrGroup2,
			...,
			_AIUnitOrGroupN
		],
		[
			[_cleanupObj1,_cleanupObj2,...,_cleanupObjX],
			[_vehicle1,_vehicle2,...,_vehicleX],
			[
				[_crate1,_crate_loot_values1],
				[_crate2,_crate_loot_values2]
			]
		],
		[_missionName,_msgWIN,_msgLose],
		_markers,
		_side,
		_difficulty,
		_missionEvents,
		[
			_onSuccessScripts,			// (OPTIONAL) Array of code or string to be executed on mission completion (in addition to regular code).
			_onFailScripts,				// (OPTIONAL) Array of code or stirng to be executed on mission failure (in addition to regular code).
			_onMonitorStart,			// (OPTIONAL) Code to run when the monitor starts to check the mission status, however it is checked AFTER "MissionSuccessState" is checked, so you can use/set the variable "_success" manually. The passed parameter (_this) is the mission data array itself.
			_onMonitorEnd				// (OPTIONAL) Code to run when the monitor is done with checking the mission status. The passed parameter (_this) is the mission data array itself.
		]
	] call DMS_fnc_AddMissionToMonitor;

	Returns whether or not info was added successfully

*/

private ["_added", "_pos", "_onEndingScripts", "_completionInfo", "_timeOutInfo", "_units", "_inputUnits", "_missionObjs", "_mines", "_difficulty", "_side", "_messages", "_markers", "_arr", "_timeStarted", "_timeUntilFail", "_buildings", "_vehs", "_crate_info_array", "_missionName", "_msgWIN", "_msgLose", "_markerDot", "_markerCircle", "_missionEvents", "_onSuccessScripts", "_onFailScripts"];


_added = false;


if !(params
[
	["_pos","",[[]],[2,3]],
	["_completionInfo","",[[]]],
	["_timeOutInfo","",[[]],[1,2]],
	["_inputUnits","",[[]]],
	["_missionObjs","",[[]],[3,4]],
	["_messages","",[[]],[3]],
	["_markers","",[[]],[DMS_MissionMarkerCount]],
	["_side","bandit",[""]],
	["_difficulty","moderate",[""]],
	["_missionEvents",[],[[]]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_AddMissionToMonitor with invalid parameters: %1",_this];
	false;
};

_onEndingScripts = if ((count _this)>10) then {_this select 10} else {[[],[],{},{}]};


try
{
	if ((count _pos) isEqualTo 2) then
	{
		_pos set [2,0];
	};

	if (_completionInfo isEqualTo []) then
	{
		throw "_completionInfo is empty!";
	};

	_timeOutInfo params
	[
		["_timeStarted",diag_tickTime,[0]],
		["_timeUntilFail",DMS_MissionTimeOut call DMS_fnc_SelectRandomVal,[0]]
	];

	_units = _inputUnits call DMS_fnc_GetAllUnits;


	if !(_missionObjs params
	[
		["_buildings","",[[]]],
		["_vehs","",[[]]],
		["_crate_info_array","",[[]]]
	])
	then
	{
		throw format["_missionObjs |%1|",_missionObjs];
	};

	_mines = [];
	
	if ((count _missionObjs)>3) then
	{
		_mines = _missionObjs param [3,[],[[]]];
	};

	// Don't spawn a minefield if there is one already defined in _missionObjs.
	if (DMS_SpawnMinefieldForEveryMission && {_mines isEqualTo []}) then
	{
		_mines = [_pos, _difficulty, _side] call DMS_fnc_SpawnMinefield;
	};



	if !(_messages params
	[
		["_missionName","",[""]],
		["_msgWIN",[],[[]],[2]],
		["_msgLose",[],[[]],[2]]
	])
	then
	{
		throw format["_messages |%1|",_messages];
	};


	if !(_onEndingScripts params
	[
		["_onSuccessScripts", [], [[]]],
		["_onFailScripts", [], [[]]],
		["_onMonitorStart", {}, [{}]],
		["_onMonitorEnd", {}, [{}]]
	])
	then
	{
		throw format["_onEndingScripts |%1|",_onEndingScripts];
	};

	_arr = 
	[
		_pos,
		_completionInfo,
		[
			_timeStarted,
			_timeUntilFail
		],
		_units,
		[
			_buildings,
			_vehs,
			_crate_info_array,
			_mines
		],
		[
			_missionName,
			_msgWIN,
			_msgLose
		],
		_markers,
		_side,
		_difficulty,
		_missionEvents,
		[
			_onSuccessScripts,
			_onFailScripts,
			_onMonitorStart,
			_onMonitorEnd
		]
	];
	DMS_Mission_Arr pushBack _arr;
	_added = true;

	if (DMS_MarkerText_ShowAICount) then
	{
		_markerDot = _markers select 0;
		_markerDot setMarkerText (format ["%1 (%2 %3 remaining)",markerText _markerDot,count _units,DMS_MarkerText_AIName]);
	};

	if (DMS_DEBUG) then
	{
		(format ["AddMissionToMonitor :: Added |%1| to DMS_Mission_Arr!",_arr]) call DMS_fnc_DebugLog;
	};
}
catch
{
	diag_log format ["DMS ERROR :: Calling DMS_AddMissionToMonitor with invalid parameter: %1",_exception];
};

_added