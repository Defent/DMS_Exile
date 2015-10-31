/*
	DMS_fnc_MissionsMonitor

	Created by eraser1

	Calls the respective functions for Dynamic and Static mission monitoring based on DMS configuration.
*/

if (DMS_DynamicMission) then
{
	call DMS_fnc_MissionsMonitor_Dynamic;
};

if (DMS_StaticMission) then
{
	call DMS_fnc_MissionsMonitor_Static;
};