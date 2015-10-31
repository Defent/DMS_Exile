/*
	DMS_fnc_MissionsMonitor_Dynamic

	Created by eraser1

	Each mission has its own index in "DMS_Mission_Arr".
	Every index is a subarray with the values:
	[
		_pos,
		_completionInfo,	//<--- More info in "DMS_fnc_MissionSuccessState"
		[_timeStarted,_timeUntilFail],
		[_AIUnit1,_AIUnit2,...,_AIUnitX],
		[
			[_cleanupObj1,_cleanupObj2,...,_cleanupObjX],
			[_vehicle1,_vehicle2,...,_vehicleX],
			[
				[_crate1,_crate_loot_values1],
				[_crate2,_crate_loot_values2]
			]
		],
		[_missionName,_msgWIN,_msgLose],
		[_markerDot,_markerCircle],
		_missionSide,
		_missionDifficulty,
		_missionEvents,
		_onSuccessScripts,
		_onFailScripts,
		[
			_onSuccessScripts,
			_onFailScripts
		]
	]

	A semi-full breakdown can be found in fn_AddMissionToMonitor.sqf
*/
if (DMS_Mission_Arr isEqualTo []) exitWith {};				// Empty array, no missions running

private ["_pos", "_success", "_timeStarted", "_timeUntilFail", "_units", "_buildings", "_vehs", "_crate_info_array", "_mines", "_missionName", "_msgWIN", "_msgLose", "_markers", "_missionSide", "_arr", "_cleanupList"];


{
	try
	{
		_pos						= _x select 0;
		_success					= (_x select 1) call DMS_fnc_MissionSuccessState;
		_timeStarted				= _x select 2 select 0;
		_timeUntilFail				= _x select 2 select 1;
		_units						= _x select 3;
		_buildings					= _x select 4 select 0;
		_vehs						= _x select 4 select 1;
		_crate_info_array			= _x select 4 select 2;
		_mines						= _x select 4 select 3;
		_missionName				= _x select 5 select 0;
		_msgWIN						= _x select 5 select 1;
		_msgLose					= _x select 5 select 2;
		_markers 					= _x select 6;
		_missionSide				= _x select 7;
		_missionDifficulty			= _x select 8;
		_missionEvents 				= _x select 9;
		_onSuccessScripts			= _x select 10 select 0;
		_onFailScripts				= _x select 10 select 1;

		/*
		if (DMS_DEBUG) then
		{
			(format ["MissionsMonitor_Dynamic :: Checking Mission Status (index %1): ""%2"" at %3",_forEachIndex,_missionName,_pos]) call DMS_fnc_DebugLog;
		};
		*/

		if (_success) then
		{
			DMS_CleanUpList pushBack [_units+_buildings,diag_tickTime,DMS_CompletedMissionCleanupTime];

			if (_missionSide == "bandit") then
			{
				DMS_RunningBMissionCount = DMS_RunningBMissionCount - 1;
			}
			else
			{
				// Not yet implemented
			};

			_arr = DMS_Mission_Arr deleteAt _forEachIndex;

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

			throw format ["Mission (%1) Success at %2 with message %3.",_missionName,_pos,_msgWIN];
		};

		if ((diag_tickTime-_timeStarted)>_timeUntilFail) then
		{
			// Check to see if the timeout should be extended before ending the mission.
			if ((DMS_MissionTimeoutResetRange>0) && {[_pos,DMS_MissionTimeoutResetRange] call DMS_fnc_IsPlayerNearby}) then
			{
				_x set [2,[diag_tickTime,_timeUntilFail]];

				throw format ["Mission Timeout Extended at %1 with timeout after %2 seconds. Position: %3",diag_tickTime,_timeUntilFail,_pos];
			};


			//Nobody is nearby so just cleanup objects from here
			_cleanupList = (_units+_buildings+_vehs);

			{
				_cleanupList pushBack (_x select 0);
			} forEach _crate_info_array;

			_cleanupList call DMS_fnc_CleanUp;


			if (_missionSide == "bandit") then
			{
				DMS_RunningBMissionCount = DMS_RunningBMissionCount - 1;
			}
			else
			{
				// Not yet implemented
			};
			
			_arr = DMS_Mission_Arr deleteAt _forEachIndex;

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

			throw format ["Mission (%1) Fail at %2 with message %3.",_missionName,_pos,_msgLose];
		};

		if (DMS_MarkerText_ShowAICount) then
		{
			private ["_dot", "_text"];

			_dot = _markers select 0;
			_text = missionNamespace getVariable [format ["%1_text",_dot],_missionName];

			if (DMS_MarkerText_ShowMissionPrefix) then
			{
				_text = format ["%1 %2",DMS_MarkerText_MissionPrefix,_text];
			};

			_dot setMarkerText (format ["%1 (%2 %3 remaining)",_text,{alive _x} count _units,DMS_MarkerText_AIName]);
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
	}
	catch
	{
		if (DMS_DEBUG) then
		{
			(format ["MissionsMonitor_Dynamic :: %1",_exception]) call DMS_fnc_DebugLog;
		};
	};
} forEach DMS_Mission_Arr;