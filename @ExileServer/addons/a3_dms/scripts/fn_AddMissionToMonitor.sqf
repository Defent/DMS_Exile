/*
	DMS_fnc_AddMissionToMonitor
	Created by eraser1

	https://github.com/Defent/DMS_Exile/wiki/DMS_fnc_AddMissionToMonitor

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
			_onSuccessScripts,			// (OPTIONAL) Array of code or string to be executed on mission completion (in addition to regular code). Each element should be an array in the form [_params, _code].
			_onFailScripts,				// (OPTIONAL) Array of code or string to be executed on mission failure (in addition to regular code). Each element should be an array in the form [_params, _code].
			_onMonitorStart,			// (OPTIONAL) Code to run when the monitor starts to check the mission status. The passed parameter (_this) is the mission data array itself.
			_onMonitorEnd				// (OPTIONAL) Code to run when the monitor is done with checking the mission status. The passed parameter (_this) is the mission data array itself.
		]
	] call DMS_fnc_AddMissionToMonitor;

	Returns whether or not info was added successfully

*/

private _added = false;

if !(params
[
	"_pos",
	"_completionInfo",
	"_timeOutInfo",
	"_units",
	"_missionObjs",
	"_messages",
	"_markers",
	"_side",
	"_difficulty",
	"_missionEvents"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_AddMissionToMonitor with invalid parameters: %1",_this];
	false;
};

private _onEndingScripts = if ((count _this)>10) then {_this select 10} else {[[],[],{},{}]};


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

	private _mines = _missionObjs param [3,[],[[]]];

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
	_msgWIN pushBack "win";
	_msgLose pushBack "lose";


	if !(_onEndingScripts params
	[
		["_onSuccessScripts", [], [[]]],
		["_onFailScripts", [], [[]]],
		["_onMonitorStart", {}, [{}]],
		["_onMonitorEnd", {}, [{}]]
	])
	then
	{
		//throw format["_onEndingScripts |%1|",_onEndingScripts];
	};

	private _unitCount = count (_units call DMS_fnc_GetAllUnits);

	private _arr =
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
		],
		_unitCount
	];
	DMS_Mission_Arr pushBack _arr;
	_added = true;

	if (DMS_MarkerText_ShowAICount) then
	{
		private _markerDot = _markers select 0;
		_markerDot setMarkerText (format ["%1 (%2 %3 remaining)",markerText _markerDot,_unitCount,DMS_MarkerText_AIName]);
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
