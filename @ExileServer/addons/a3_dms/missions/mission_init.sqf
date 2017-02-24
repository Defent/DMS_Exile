/*
	mission_init.sqf
	Created by eraser1

	Initializes dynamic mission variables for DMS
*/

diag_log "DMS :: Initializing Dynamic Mission Variables";

// Initialize Variables
DMS_Mission_Arr					= [];
DMS_MissionCount 				= 0;
DMS_RunningBMissionCount		= 0;
DMS_BMissionLastStart			= diag_tickTime;
DMS_BMissionDelay 				= DMS_TimeToFirstMission call DMS_fnc_SelectRandomVal;


if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG mission_init :: Random time between missions is initially set to %1s | DMS_BMissionLastStart: %2",DMS_BMissionDelay,DMS_BMissionLastStart];
};

// Set mission frequencies from config
DMS_BanditMissionTypesArray = [];
{
	private _missionName = _x select 0;

	for "_i" from 1 to (_x select 1) do
	{
		DMS_BanditMissionTypesArray pushBack _missionName;
	};

	missionNamespace setVariable
	[
		format["DMS_Mission_%1",_missionName],
		compileFinal preprocessFileLineNumbers (format ["\x\addons\DMS\missions\bandit\%1.sqf",_missionName])
	];
} forEach DMS_BanditMissionTypes;
