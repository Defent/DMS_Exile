class CfgPatches
{
	class a3_dms
	{
		units[] = {};
		weapons[] = {};
		a3_DMS_version = "September 7, 2017";
		requiredVersion = 1.68;
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
			class AddWeapon						{};
			class AILocalityManager 			{};
			class BroadcastMissionStatus 		{};
			class CalcPos						{};
			class CleanUp 						{};
			class CleanUpManager 				{};
			class CreateMarker 					{};
			class DebugLog						{};
			class FillCrate 					{};
			class FindSafePos 					{};
			class FindSafePos_InRange			{};
			class FindSuppressor 				{};
			class FreezeManager 				{};
			class FreezeToggle					{};
			class GetAllUnits					{};
			class GetCenter						{};
			class GetEmptySeats					{};
			class GroupReinforcementsManager	{};
			//class HandleMissionEvents			{};
			class HeliParatroopers_Monitor		{};
			class ImportFromM3E					{};
			class ImportFromM3E_Convert			{};
			class ImportFromM3E_Static			{};
			class ImportFromM3E_3DEN			{};
			class ImportFromM3E_3DEN_Convert	{};
			class ImportFromM3E_3DEN_Static		{};
			class IsPlayerNearby				{};
			class IsPosBlacklisted				{};
			class IsNearWater 					{};
			class IsValidPosition				{};
			class MissionParams					{};
			class MissionsMonitor 				{};
			class MissionsMonitor_Dynamic		{};
			class MissionsMonitor_Static		{};
			class MissionSuccessState 			{};
			class OnKilled 						{};
			class PlayerAwardOnAIKill			{};
			class RemoveMarkers 				{};
			class SelectRandomVal				{};
			class SelectMagazine 				{};
			class SelectMission 				{};
			class SelectOffsetPos				{};
			class SetAILocality 				{};
			class SetGroupBehavior 				{};
			class SetGroupBehavior_Separate		{};
			class SetRelPositions				{};
			class SpawnAIGroup 					{};
			class SpawnAIGroup_MultiPos			{};
			class SpawnAIVehicle				{};
			class SpawnAISoldier 				{};
			class SpawnAIStaticMG 				{};
			class SpawnBanditMission			{};
			class SpawnCrate 					{};
			class SpawnHeliReinforcement		{};
			class SpawnMinefield				{};
			class SpawnNonPersistentVehicle 	{};
			class SpawnPersistentVehicle 		{};
			class SpawnStaticMission			{};
			class SubArr						{};
			class TargetsKilled 				{};
		};
	};
};
