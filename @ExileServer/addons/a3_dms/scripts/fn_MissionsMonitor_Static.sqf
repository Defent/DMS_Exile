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
		[_timeStarted,_failTime],
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
		_markers,
		_missionSide,
		_missionDifficulty,
		_missionEvents,
		[
			_onSuccessScripts,
			_onFailScripts,
			_onMonitorStart,
			_onMonitorEnd
		],
		_prevAICount
	]

	A semi-full breakdown can be found in fn_AddStaticMissionToMonitor.sqf
*/

{
	if !(_x params
	[
		"_missionPos",
		"_completionInfo",
		"_groupReinforcementsInfo",
		"_timing",
		"_inputAIUnits",
		"_missionObjs",
		"_msgInfo",
		"_markers",
		"_missionSide",
		"_missionDifficulty",
		"_missionEvents",
		"_missionScripts",
		"_prevAICount"
	])
	then
	{
		DMS_StaticMission_Arr deleteAt _forEachIndex;
		diag_log format ["DMS ERROR :: Invalid Index (%1) in DMS_StaticMission_Arr: %2",_forEachIndex,_x];
	};


	if !(_timing params
	[
		"_timeStarted",
		"_failTime"
	])
	exitWith
	{
		DMS_StaticMission_Arr deleteAt _forEachIndex;
		diag_log format ["DMS ERROR :: Invalid _timing (%1) in DMS_StaticMission_Arr: %2",_timing,_x];
	};


	if !(_missionObjs params
	[
		"_buildings",
		"_vehs",
		"_crate_info_array",
		"_mines"
	])
	exitWith
	{
		DMS_StaticMission_Arr deleteAt _forEachIndex;
		diag_log format ["DMS ERROR :: Invalid _missionObjs (%1) in DMS_StaticMission_Arr: %2",_missionObjs,_x];
	};


	if !(_msgInfo params
	[
		"_missionName",
		"_msgWIN",
		"_msgLose"
	])
	exitWith
	{
		DMS_StaticMission_Arr deleteAt _forEachIndex;
		diag_log format ["DMS ERROR :: Invalid _msgInfo (%1) in DMS_StaticMission_Arr: %2",_msgInfo,_x];
	};


	if !(_missionScripts params
	[
		"_onSuccessScripts",
		"_onFailScripts",
		"_onMonitorStart",
		"_onMonitorEnd"
	])
	exitWith
	{
		DMS_StaticMission_Arr deleteAt _forEachIndex;
		diag_log format ["DMS ERROR :: Invalid _missionScripts (%1) in DMS_StaticMission_Arr: %2",_missionScripts,_x];
	};

	try
	{
		/*
		if (DMS_DEBUG) then
		{
			(format ["MissionsMonitor_Static :: Checking Mission Status (index %1): ""%2"" at %3",_forEachIndex,_missionName,_missionPos]) call DMS_fnc_DebugLog;
		};
		*/

		if !(_onMonitorStart isEqualTo {}) then
		{
			if (DMS_DEBUG) then
			{
				(format ["MissionsMonitor_Static :: Calling _onMonitorStart (index %1): ""%2"". Code: %3",_forEachIndex,_missionName,_onMonitorStart]) call DMS_fnc_DebugLog;
			};
			_x call _onMonitorStart;
		};


		if (_completionInfo call DMS_fnc_MissionSuccessState) then
		{
			DMS_CleanUpList pushBack [_buildings,diag_tickTime,DMS_CompletedMissionCleanupTime];

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
				_params = _x select 0;
				_code = _x select 1;
				if (_code isEqualType "") then
				{
					_code = compile _code;
				};
				_params call _code;
			} forEach _onSuccessScripts;

			[_missionName,_msgWIN] call DMS_fnc_BroadcastMissionStatus;
			[_markers,"win"] call DMS_fnc_RemoveMarkers;

			DMS_StaticMission_Arr deleteAt _forEachIndex;
			DMS_RunningStaticMissions deleteAt _forEachIndex;

			throw format ["Mission (%1) Success at %2 with message %3.",_missionName,_missionPos,_msgWIN];
		};


		private _timeElapsed = diag_tickTime - _timeStarted;

		if (DMS_ResetStaticMissionTimeoutOnKill) then
		{
			private _AICount = count (_inputAIUnits call DMS_fnc_GetAllUnits);

			if (_AICount != _prevAICount) then
			{
				_x set [3,[diag_tickTime,_failTime]];
				_x set [12, _AICount];
				_timeElapsed = 0;

				if (DMS_DEBUG) then
				{
					format["MissionsMonitor_Static :: Static Mission Timeout Extended to %1 more seconds; AI count changed from %2 to %3. Position: %4, MissionIndex: %5",_failTime, _prevAICount, _AICount,_pos,_forEachIndex] call DMS_fnc_DebugLog;
				};
			};
		};

		switch (true) do
		{
			case (_timeElapsed > DMS_SMissionTimeoutResetFrequency):
			{
				if ([_missionPos,DMS_StaticMissionTimeoutResetRange] call DMS_fnc_IsPlayerNearby) then
				{
					_x set [3,[diag_tickTime,_failTime]];

					if (DMS_DEBUG) then
					{
						format["MissionsMonitor_Static :: Static Mission Timeout Extended to %1 more seconds; player found within %2 meters. Position: %3, MissionIndex: %4",_failTime,DMS_StaticMissionTimeoutResetRange,_pos,_forEachIndex] call DMS_fnc_DebugLog;
					};
				};
			};

			case (_timeElapsed > _failTime):
			{
				// Check to see if the timeout should be extended before ending the mission.
				if ((DMS_StaticMissionTimeoutResetRange>0) && {[_missionPos,DMS_StaticMissionTimeoutResetRange] call DMS_fnc_IsPlayerNearby}) then
				{
					_x set [3,[diag_tickTime,_failTime]];

					throw format ["Mission Timeout Extended at %1 with timeout after %2 seconds. Position: %3",diag_tickTime,_failTime,_missionPos];
				};

				//Nobody is nearby so just cleanup objects from here
				_cleanupList = ((_inputAIUnits call DMS_fnc_GetAllUnits)+_buildings+_vehs+_mines);

				{
					_cleanupList pushBack (_x select 0);
				} forEach _crate_info_array;

				private _prev = DMS_CleanUp_PlayerNearLimit;
				DMS_CleanUp_PlayerNearLimit = 0;			// Temporarily set the limit to 0 since we want to delete all the stuff regardless of player presence.

				_cleanupList call DMS_fnc_CleanUp;

				DMS_CleanUp_PlayerNearLimit = _prev;


				{
					_params = _x select 0;
					_code = _x select 1;
					if (_code isEqualType "") then
					{
						_code = compile _code;
					};
					_params call _code;
				} forEach _onFailScripts;

				[_missionName,_msgLose] call DMS_fnc_BroadcastMissionStatus;
				[_markers,"lose"] call DMS_fnc_RemoveMarkers;

				DMS_StaticMission_Arr deleteAt _forEachIndex;
				DMS_RunningStaticMissions deleteAt _forEachIndex;

				throw format ["Mission (%1) Fail at %2 with message %3.",_missionName,_missionPos,_msgLose];
			};
		};


		if (DMS_MarkerText_ShowAICount_Static) then
		{
			private _dot = _markers select 0;
			private _text = missionNamespace getVariable [format ["%1_text",_dot],_missionName];

			if (DMS_MarkerText_ShowMissionPrefix) then
			{
				_text = format ["%1 %2",DMS_MarkerText_MissionPrefix,_text];
			};

			_dot setMarkerText (format ["%1 (%2 %3 remaining)",_text,count (_inputAIUnits call DMS_fnc_GetAllUnits),DMS_MarkerText_AIName]);
		};


		if (DMS_AllowStaticReinforcements) then
		{
			{
				if (_x call DMS_fnc_GroupReinforcementsManager) then
				{
					_groupReinforcementsInfo deleteAt _forEachIndex;
				};
			} forEach _groupReinforcementsInfo;
		};


		if !(_onMonitorEnd isEqualTo {}) then
		{
			if (DMS_DEBUG) then
			{
				(format ["MissionsMonitor_Static :: Calling _onMonitorEnd (index %1): ""%2"". Code: %3",_forEachIndex,_missionName,_onMonitorEnd]) call DMS_fnc_DebugLog;
			};
			_x call _onMonitorEnd;
		};
	}
	catch
	{
		if !(_onMonitorEnd isEqualTo {}) then
		{
			if (DMS_DEBUG) then
			{
				(format ["MissionsMonitor_Static :: Calling _onMonitorEnd (index %1): ""%2"". Code: %3",_forEachIndex,_missionName,_onMonitorEnd]) call DMS_fnc_DebugLog;
			};
			_x call _onMonitorEnd;
		};


		if (DMS_DEBUG) then
		{
			(format ["MissionsMonitor_Static :: %1",_exception]) call DMS_fnc_DebugLog;
		};
	};
} forEach DMS_StaticMission_Arr;
