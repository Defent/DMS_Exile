/*
	DMS_fnc_MissionsMonitor_Static

	Created by eraser1
	Mostly identical to "DMS_fnc_MissionsMonitor_Dynamic"


	Each mission has its own index in "DMS_StaticMission_Arr".
	Every index is a subarray with the values:
	[
		_missionPos,
		_completionInfo,					//<--- More info in "DMS_fnc_MissionSuccessState"
		_groupReinforcementsInfo,			//<--- More info in "DMS_fnc_GroupReinforcementsManager"
		[_timeStarted,_timeUntilFail],
		[_AIGroup1,_AIGroup2,...,_AIGroupX],
		[
			[_cleanupObj1,_cleanupObj2,...,_cleanupObjX],
			[_vehicle1,_vehicle2,...,_vehicleX],
			[
				[_crate1,_crate_loot_values1],
				[_crate2,_crate_loot_values2],
				...
				[_crateX,_crate_loot_valuesX]
			],
			[_mine1,_mine2,...,_mineX]
		],
		[_missionName,_msgWIN,_msgLose],
		[_markerDot,_markerCircle],
		_missionSide,
		_missionDifficulty,
		_missionEvents,
		[
			_onSuccessScripts,
			_onFailScripts
		]
	]

	A semi-full breakdown can be found in fn_AddStaticMissionToMonitor.sqf
*/
if (DMS_StaticMission_Arr isEqualTo []) exitWith {};				// Empty array, no static missions running


{
	try
	{
		private ["_missionPos", "_completionInfo", "_groupReinforcementsInfo", "_timing", "_inputAIUnits", "_missionObjs", "_msgInfo", "_markers", "_missionSide", "_missionDifficulty", "_missionEvents", "_endingScripts", "_success", "_timeStarted", "_timeUntilFail", "_buildings", "_vehs", "_crate_info_array", "_mines", "_missionName", "_msgWIN", "_msgLose", "_onSuccessScripts", "_onFailScripts"];

		if !(_x params
		[
			["_missionPos", 				[],		[[]],	[2,3]	],
			["_completionInfo",				[],		[[]]			],
			["_groupReinforcementsInfo",	[],		[[]]			],
			["_timing",						[],		[[]],	[2]		],
			["_inputAIUnits",				[],		[[]]			],
			["_missionObjs",				[],		[[]],	[4]		],
			["_msgInfo",					[],		[[]],	[3]		],
			["_markers",					[],		[[]],	[2]		],
			["_missionSide",				"",		[""]			],
			["_missionDifficulty",			"",		[""]			],
			["_missionEvents",				[],		[[]]			],
			["_endingScripts",				[],		[[]],	[2]		]
		])
		then
		{
			DMS_StaticMission_Arr deleteAt _forEachIndex;
			diag_log format ["DMS ERROR :: Invalid Index (%1) in DMS_StaticMission_Arr: %2",_forEachIndex,_x];
			throw "DMS ERROR";
		};


		_success					= _completionInfo call DMS_fnc_MissionSuccessState;
		_timeStarted				= _timing select 0;
		_timeUntilFail				= _timing select 1;
		_buildings					= _missionObjs select 0;
		_vehs						= _missionObjs select 1;
		_crate_info_array			= _missionObjs select 2;
		_mines						= _missionObjs select 3;
		_missionName				= _msgInfo select 0;
		_msgWIN						= _msgInfo select 1;
		_msgLose					= _msgInfo select 2;
		_onSuccessScripts			= _endingScripts select 0;
		_onFailScripts				= _endingScripts select 1;

		/*
		if (DMS_DEBUG) then
		{
			(format ["MissionsMonitor_Dynamic :: Checking Mission Status (index %1): ""%2"" at %3",_forEachIndex,_missionName,_missionPos]) call DMS_fnc_DebugLog;
		};
		*/

		if (_success) then
		{
			_AIUnits = _inputAIUnits call DMS_fnc_GetAllUnits;

			DMS_CleanUpList pushBack [_AIUnits+_buildings,diag_tickTime,DMS_CompletedMissionCleanupTime];

			{
				_x allowDamage true;
				_x enableRopeAttach true;
				_x enableSimulationGlobal true;

				if (_x getVariable ["ExileIsPersistent", false]) then
				{
					_x lock 0;
					_x setVariable ["ExileIsLocked",0];

					_x setVariable ["ExileLastLockToggleAt", time];
					_x setVariable ["ExileAccessDenied", false];
					_x setVariable ["ExileAccessDeniedExpiresAt", 0];

					// NOW we save the vehicle in the database, since we know we're not deleting this vehicle.
					_x call ExileServer_object_vehicle_database_insert;
					_x call ExileServer_object_vehicle_database_update;
				}
				else
				{
					_x lock 1;
				};

				_x call ExileServer_system_simulationMonitor_addVehicle;
			} forEach _vehs;

			{
				_x call DMS_fnc_FillCrate;
			} forEach _crate_info_array;

			if (DMS_despawnMines_onCompletion) then
			{
				{
					deleteVehicle _x;
				} forEach _mines;
			};

			{
				_code = _x;
				if ((typeName _code)=="STRING") then
				{
					_code = compile _code;
				};
				call _code;
			} forEach _onSuccessScripts;

			[_missionName,_msgWIN] call DMS_fnc_BroadcastMissionStatus;
			[_markers,"win"] call DMS_fnc_RemoveMarkers;

			DMS_StaticMission_Arr deleteAt _forEachIndex;
			DMS_RunningStaticMissions deleteAt _forEachIndex;

			throw format ["Mission (%1) Success at %2 with message %3.",_missionName,_missionPos,_msgWIN];
		};

		if ((diag_tickTime-_timeStarted)>_timeUntilFail) then
		{
			// Check to see if the timeout should be extended before ending the mission.
			if ((DMS_StaticMissionTimeoutResetRange>0) && {[_missionPos,DMS_StaticMissionTimeoutResetRange] call DMS_fnc_IsPlayerNearby}) then
			{
				_x set [2,[diag_tickTime,_timeUntilFail]];

				throw format ["Mission Timeout Extended at %1 with timeout after %2 seconds. Position: %3",diag_tickTime,_timeUntilFail,_missionPos];
			};


			_AIUnits = _inputAIUnits call DMS_fnc_GetAllUnits;

			//Nobody is nearby so just cleanup objects from here
			_cleanupList = (_AIUnits+_buildings+_vehs);

			{
				_cleanupList pushBack (_x select 0);
			} forEach _crate_info_array;

			_cleanupList call DMS_fnc_CleanUp;


			{
				_code = _x;
				if ((typeName _code)=="STRING") then
				{
					_code = compile _code;
				};
				call _code;
			} forEach _onFailScripts;

			[_missionName,_msgLose] call DMS_fnc_BroadcastMissionStatus;
			[_markers,"lose"] call DMS_fnc_RemoveMarkers;
			
			DMS_StaticMission_Arr deleteAt _forEachIndex;
			DMS_RunningStaticMissions deleteAt _forEachIndex;

			throw format ["Mission (%1) Fail at %2 with message %3.",_missionName,_missionPos,_msgLose];
		};

		if (DMS_MarkerText_ShowAICount) then
		{
			private ["_dot", "_text"];

			_AIUnits = _inputAIUnits call DMS_fnc_GetAllUnits;

			_dot = _markers select 0;
			_text = missionNamespace getVariable [format ["%1_text",_dot],_missionName];

			if (DMS_MarkerText_ShowMissionPrefix) then
			{
				_text = format ["%1 %2",DMS_MarkerText_MissionPrefix,_text];
			};

			_dot setMarkerText (format ["%1 (%2 %3 remaining)",_text,{alive _x} count _AIUnits,DMS_MarkerText_AIName]);
		};

		if !(_missionEvents isEqualTo []) then
		{
			/*
			Coming soon...

			{
				_x call DMS_fnc_HandleMissionEvents;
			} forEach _missionEvents;
			*/
		};


		{
			if (_x call DMS_fnc_GroupReinforcementsManager) then
			{
				_groupReinforcementsInfo deleteAt _forEachIndex;
			};
		} forEach _groupReinforcementsInfo;
	}
	catch
	{
		if (DMS_DEBUG) then
		{
			(format ["MissionsMonitor_Dynamic :: %1",_exception]) call DMS_fnc_DebugLog;
		};
	};
} forEach DMS_StaticMission_Arr;