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

private _missionType = param [0, selectRandom DMS_StaticMissionTypesArray, [""]];

private _mission =
[
	missionNamespace getVariable format
	[
		"DMS_StaticMission_%1",
		_missionType
	]
] param [0, "no", [{}]];

try
{
	if (_mission isEqualTo "no") then
	{
		throw format ["for a mission that isn't in DMS_StaticMissionTypesArray! Parameters: %1",_this];
	};

	if (_missionType in DMS_RunningStaticMissions) then
	{
		throw format ["with a mission that's already running! Parameters: %1",_this];
	};


	private _parameters = param [1, []];

	private _return = _parameters call _mission;

	if ((!isNil "_return") && {_return isEqualTo "delay"}) then
	{
		if (DMS_DEBUG) then
		{
			(format ["SpawnStaticMission :: Mission ""%1"" requested delay",_missionType]) call DMS_fnc_DebugLog;
		};
	}
	else
	{
		DMS_MissionCount = DMS_MissionCount + 1;
		DMS_StaticMissionDelay = DMS_TimeBetweenStaticMissions call DMS_fnc_SelectRandomVal;
		DMS_StaticMissionLastStart = diag_tickTime;
		DMS_RunningStaticMissions pushBack _missionType;

		if (DMS_DEBUG) then
		{
			(format ["SpawnStaticMission :: Spawned mission %1 with parameters (%2) | DMS_StaticMissionDelay set to %3 seconds", _missionType, _parameters, DMS_StaticMissionDelay]) call DMS_fnc_DebugLog;
		};
	};
}
catch
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnStaticMission %1", _exception];
};
