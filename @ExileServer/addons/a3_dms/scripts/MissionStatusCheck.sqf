/*
	[
		_position,
		[_completionType,_completionArgs],
		[_timeStarted,_timeUntilFail],
		[_AIUnit1,_AIUnit2,...,_AIUnitX],
		[
			[_cleanupObj1,_cleanupObj2,...,_cleanupObjX],
			[_crate,_vehicle1,_vehicle2,...,_vehicleX]
		],
		[_msgWIN,_msgLose]
	]
*/
if !(DMS_Mission_Arr isEqualTo []) then {
	_index = 0;
	{
		_index = _index + 1;
		call {
			if (DMS_DEBUG) then
			{
				diag_log ("DMS :: Checking Mission Status: "+str _x);
			};
			_position					= _x select 0;
			_success					= (_x select 1) call MissionSuccessState;
			_timeStarted				= _x select 2 select 0;
			_timeUntilFail				= _x select 2 select 1;
			_units						= _x select 3;
			_buildings					= _x select 4 select 0;
			_loot						= _x select 4 select 1;
			_msgSuccess					= _x select 5 select 0;
			_msgFail					= _x select 5 select 1;

			if (_success) exitWith {
				[DMS_CompletedMissionCleanup_Time,DMS_CleanUp,(_units+_buildings),false] call ExileServer_system_thread_addTask;
				_arr = DMS_Mission_Arr deleteAt _index;
				(_loot select 0) call DMS_FillCrate;
				_msgSuccess call DMS_BroadcastMissionStatus;
			};

			if (DMS_player_reset_timeout && {[_position,DMS_player_reset_timeout_range] call ExileServer_util_position_isPlayerNearby}) exitWith
			{
				_x set [2,[diag_tickTime,_timeUntilFail]];
			};

			if ((diag_tickTime-_timeStarted)>_timeUntilFail) exitWith
			{
				_arr = DMS_Mission_Arr deleteAt _index;
				(_units+_buildings+_loot) call DMS_CleanUp;
				_msgFail call DMS_BroadcastMissionStatus;
			};
		};
		false;
	} count DMS_Mission_Arr;
};