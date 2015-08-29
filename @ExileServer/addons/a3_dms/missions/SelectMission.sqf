/*
	DMS_selectMission
	Influenced by WAI
	Created by eraser1

	Selects/Spawns missions. Takes no arguments, returns nothing.
*/
private "_time";

_time = diag_tickTime;

if (DMS_RunningBMissionCount isEqualTo DMS_MaxBanditMissions) then
{
	DMS_BMissionLastStart = _time;
};

if ((_time - DMS_BMissionLastStart >= DMS_TimeBetweenMissions) && {diag_fps >= DMS_MinServerFPS && {(count allPlayers) >= DMS_MinPlayerCount}}) then
{
	private "_mission";

	DMS_MissionCount 			= DMS_MissionCount + 1;
	DMS_RunningBMissionCount 	= DMS_RunningBMissionCount + 1;
	
	DMS_BMissionLastStart 		= _time;
	_mission					= DMS_MissionTypesArray call BIS_fnc_selectRandom;

	DMS_BMissionDelay 			= (DMS_TimeBetweenMissions select 0) + random((DMS_TimeBetweenMissions select 1) - (DMS_TimeBetweenMissions select 0));

	if (DMS_DEBUG) then
	{
		diag_log format ["DMS_DEBUG SelectMission :: Spawning mission: %1 | DMS_BMissionDelay set to %2",_mission,DMS_TimeBetweenMissions];
	};

	call compile preprocessFileLineNumbers (format ["\x\addons\DMS\missions\%1.sqf",_mission]);
};