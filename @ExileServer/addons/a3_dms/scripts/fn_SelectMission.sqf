/*
	DMS_fnc_selectMission
	Influenced by WAI
	Created by eraser1

	Selects/Spawns missions. Takes no arguments, returns nothing.
*/
private "_time";

_time = diag_tickTime;

if (DMS_RunningBMissionCount >= DMS_MaxBanditMissions) then
{
	DMS_BMissionLastStart = _time;
};

if (diag_fps >= DMS_MinServerFPS && {(count allPlayers) >= DMS_MinPlayerCount}) then
{
	// More Mission types coming soon
	if (_time - DMS_BMissionLastStart > DMS_BMissionDelay) then
	{
		private "_mission";
		_mission = DMS_BanditMissionTypesArray call BIS_fnc_selectRandom;

		if (DMS_DEBUG) then
		{
			(format ["SelectMission :: Selected bandit mission: %1"]) call DMS_fnc_DebugLog;
		};

		[_mission] call DMS_fnc_SpawnBanditMission;

		if (DMS_DEBUG) then
		{
			(format ["SelectMission :: Spawning of bandit mission ""%1"" complete!"]) call DMS_fnc_DebugLog;
		};
	};
};