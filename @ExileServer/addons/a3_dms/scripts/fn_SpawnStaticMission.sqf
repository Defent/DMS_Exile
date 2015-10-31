/*
	DMS_fnc_SpawnStaticMission
	Created by eraser1

	Usage:
	[
		_missionType,
		_parameters
	] call DMS_fnc_SpawnStaticMission;

	Simply spawns a mission with the given mission type and passes parameters to it. Returns nothing

	If the mission returns the string "delay", then DMS will attempt to spawn the mission again in 60 seconds.
*/


private ["_missionType", "_parameters", "_return"];


_missionType = param [0, DMS_StaticMissionTypesArray call BIS_fnc_selectRandom, [""]];

try
{
	if !(_missionType in DMS_StaticMissionTypesArray) then
	{
		throw format ["for a mission that isn't in DMS_StaticMissionTypesArray! Parameters: %1",_this];
	};

	if (_missionType in DMS_RunningStaticMissions) then
	{
		throw format ["with a mission that's already running! Parameters: %1",_this];
	};


	_parameters = if ((count _this)>1) then {_this select 1} else {[]};

	DMS_MissionCount = DMS_MissionCount + 1;

	_return = _parameters call compile preprocessFileLineNumbers (format ["\x\addons\DMS\missions\static\%1.sqf",_missionType]);

	if ((!isNil "_return") && {_return isEqualTo "delay"}) exitWith
	{
		DMS_MissionCount = DMS_MissionCount - 1;
		// This will cause mission spawning to run in scheduled, but that should be a fairly minor issue.
		[60, DMS_fnc_SpawnStaticMission, [_missionType], false] call ExileServer_system_thread_addTask;
		if (DMS_DEBUG) then
		{
			(format ["SpawnStaticMission :: Mission ""%1"" requested delay",_missionType]) call DMS_fnc_DebugLog;
		};
	};

	DMS_StaticMissionDelay = DMS_TimeBetweenStaticMissions call DMS_fnc_SelectRandomVal;
	DMS_StaticMissionLastStart = diag_tickTime;
	DMS_RunningStaticMissions pushBack _missionType;


	if (DMS_DEBUG) then
	{
		(format ["SpawnStaticMission :: Spawned mission %1 with parameters (%2) | DMS_StaticMissionDelay set to %3 seconds", _missionType, _parameters, DMS_StaticMissionDelay]) call DMS_fnc_DebugLog;
	};
}
catch
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnStaticMission %1", _exception];
};