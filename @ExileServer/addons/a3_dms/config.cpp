class CfgPatches
{
	class A3_dms
	{
		units[] = {};
		weapons[] = {};
		a3_DMS_version = 3.0;
		requiredVersion = 1.36;
		requiredAddons[] = {"exile_client","exile_server_config"};
	};
};
class CfgFunctions
{
	class DMS
	{
		class main
		{
			file = "\x\addons\dms";
			class DMS_preInit
			{
				preInit = 1;
			};
			class DMS_postInit
			{
				postInit = 1;
			};
		};
		class compiles
		{
			file = "\x\addons\dms\scripts";
			class AddMissionToMonitor 			{};
			class AILocalityManager 			{};
			class BroadcastMissionStatus 		{};
			class CleanUp 						{};
			class CleanUpManager 				{};
			class CreateMarker 					{};
			class FillCrate 					{};
			class FindSafePos 					{};
			class FindSuppressor 				{};
			class IsNearWater 					{};
			class MissionsMonitor 				{};
			class MissionSuccessState 			{};
			class OnKilled 						{};
			class RemoveMarkers 				{};
			class SelectMagazine 				{};
			class SelectMission 				{};
			class SetAILocality 				{};
			class SetGroupBehavior 				{};
			class SpawnAIGroup 					{};
			class SpawnAISoldier 				{};
			class SpawnCrate 					{};
			class SpawnNonPersistentVehicle 	{};
			class TargetsKilled 				{};
		};
	};
};
