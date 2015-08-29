/*
	DMS: mission_init.sqf
	Created by eraser1

	Initializes variables for DMS
*/

diag_log "DMS :: Initializing";

// Initialize Variables
DMS_Mission_Arr					= [];
DMS_CleanUpList					= [];
DMS_MissionCount 				= 0;
DMS_RunningBMissionCount		= 0;
DMS_BMissionLastStart			= diag_tickTime;

DMS_BMissionDelay = (DMS_TimeBetweenMissions select 0) + random((DMS_TimeBetweenMissions select 1) - (DMS_TimeBetweenMissions select 0));

if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG mission_init :: Random time between missions is initialized at %1s",DMS_TimeBetweenMissions];
};

// Set mission frequencies from config
{
	for "_i" from 1 to (_x select 1) do {
		DMS_MissionTypesArray pushBack (_x select 0);
	};
} count DMS_MissionTypes;