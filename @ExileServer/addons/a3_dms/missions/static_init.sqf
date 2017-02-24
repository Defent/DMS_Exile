/*
	static_init.sqf
	Created by eraser1

	Initializes static mission variables for DMS
*/

diag_log "DMS :: Initializing Static Mission Variables";

// Initialize Variables
DMS_StaticMission_Arr			= [];
DMS_RunningStaticMissions		= [];
DMS_StaticMissionLastStart		= diag_tickTime;
DMS_StaticMissionDelay			= DMS_TimeToFirstStaticMission call DMS_fnc_SelectRandomVal;


if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG static_init :: Random time between missions is initially set to %1s | DMS_BMissionLastStart: %2",DMS_StaticMissionDelay,DMS_StaticMissionLastStart];
};

// Set mission frequencies from config
DMS_StaticMissionTypesArray = [];
{
	private _missionName = _x select 0;

	for "_i" from 1 to (_x select 1) do
	{
		DMS_StaticMissionTypesArray pushBack _missionName;
	};

	missionNamespace setVariable
	[
		format["DMS_StaticMission_%1",_missionName],
		compileFinal preprocessFileLineNumbers (format ["\x\addons\DMS\missions\static\%1.sqf",_missionName])
	];
} forEach DMS_StaticMissionTypes;
