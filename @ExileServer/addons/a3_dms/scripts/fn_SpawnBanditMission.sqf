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


private ["_OK", "_missionType", "_parameters"];


_missionType = param [0, DMS_BanditMissionTypesArray call BIS_fnc_selectRandom, [""]];

if !(_missionType in DMS_BanditMissionTypesArray) then
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnBanditMission for a mission that isn't in DMS_BanditMissionTypesArray! Parameters: %1",_this];
}
else
{
	_parameters = [];

	if ((count _this)>1) then
	{
		_parameters = _this select 1;
	};

	DMS_MissionCount 			= DMS_MissionCount + 1;
	DMS_RunningBMissionCount 	= DMS_RunningBMissionCount + 1;
	DMS_BMissionDelay 			= DMS_TimeBetweenMissions call DMS_fnc_SelectRandomVal;

	_parameters call compile preprocessFileLineNumbers (format ["\x\addons\DMS\missions\bandit\%1.sqf",_missionType]);

	DMS_BMissionLastStart 		= diag_tickTime;


	if (DMS_DEBUG) then
	{
		diag_log format ["DMS_DEBUG SelectMission :: Spawned mission %1 with parameters (%2) | DMS_BMissionDelay set to %3 seconds",str _missionType,_parameters,DMS_BMissionDelay];
	};
};