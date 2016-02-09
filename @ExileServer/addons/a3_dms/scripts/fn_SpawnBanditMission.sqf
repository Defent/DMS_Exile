/*
	DMS_fnc_SpawnBanditMission
	Created by eraser1

	Usage:
	[
		_missionType,
		_parameters
	] call DMS_fnc_SpawnBanditMission;

	Simply spawns a mission with the given mission type and passes parameters to it. Returns nothing
*/


private ["_mission", "_parameters"];



_mission =
[
	missionNamespace getVariable format
	[
		"DMS_Mission_%1",
		_this param [0, DMS_BanditMissionTypesArray call BIS_fnc_selectRandom, [""]]
	]
] param [0, "no",[{}]];

if (_mission isEqualTo "no") then
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnBanditMission for a mission that isn't in DMS_BanditMissionTypesArray! Parameters: %1",_this];
}
else
{
	_parameters = if ((count _this)>1) then {_this select 1} else {[]};

	DMS_MissionCount 			= DMS_MissionCount + 1;
	DMS_RunningBMissionCount 	= DMS_RunningBMissionCount + 1;
	DMS_BMissionDelay 			= DMS_TimeBetweenMissions call DMS_fnc_SelectRandomVal;

	_parameters call _mission;

	DMS_BMissionLastStart 		= diag_tickTime;


	if (DMS_DEBUG) then
	{
		(format ["SpawnBanditMission :: Spawned mission %1 with parameters (%2) | DMS_BMissionDelay set to %3 seconds", _mission, _parameters, DMS_BMissionDelay]) call DMS_fnc_DebugLog;
	};
};
