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
			class AddMissionToMonitor_Static	{};
			class AILocalityManager 			{};
			class BroadcastMissionStatus 		{};
			class CalcPos						{};
			class CleanUp 						{};
			class CleanUpManager 				{};
			class CreateMarker 					{};
			class DebugLog						{};
			class FillCrate 					{};
			class FindSafePos 					{};
			class FindSuppressor 				{};
			class GetAllUnits					{};
			class GroupReinforcementsManager	{};
			//class HandleMissionEvents			{};
			//class HeliParatroopers			{};
			//class HeliPatrol					{};
			class ImportFromM3E					{};
			class ImportFromM3E_Convert			{};
			class ImportFromM3E_Static			{};
			class IsPlayerNearby				{};
			class IsNearWater 					{};
			class IsValidPosition				{};
			class MissionParams					{};
			class MissionsMonitor 				{};
			class MissionsMonitor_Dynamic		{};
			class MissionsMonitor_Static		{};
			class MissionSuccessState 			{};
			class OnKilled 						{};
			class RemoveMarkers 				{};
			class SelectRandomVal				{};
			class SelectMagazine 				{};
			class SelectMission 				{};
			class SelectOffsetPos				{};
			class SetAILocality 				{};
			class SetGroupBehavior 				{};
			class SpawnAIGroup 					{};
			class SpawnAIVehicle				{};
			class SpawnAISoldier 				{};
			class SpawnAIStaticMG 				{};
			class SpawnBanditMission			{};
			class SpawnStaticMission			{};
			class SpawnCrate 					{};
			class SpawnMinefield				{};
			class SpawnPersistentVehicle 		{};
			class SpawnNonPersistentVehicle 	{};
			class TargetsKilled 				{};
		};
	};
};
