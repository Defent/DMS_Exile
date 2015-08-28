/*
	Most of this stuff is stolen from WAI :P
	https://github.com/nerdalertdk/WICKED-AI

	Created by eraser1
	[_delay, _function, _params, _persistance] call ExileServer_system_thread_addTask;
*/
	DMS_DEBUG							= false;

/* Mission System Settings */
	DMS_DynamicMission					= true;						// Enable/disable dynamic mission system
	DMS_MaxBanditMissions				= 1;						// Maximum number of Bandit Missions
	DMS_StaticMission					= false;					// Enable/disable static missions
	DMS_TimeBetweenMissions				= [600,900];				// [Minimum,Maximum] time between missions (if mission limit is not reached) | DEFAULT: 10-15 mins
	DMS_MissionTimeOut					= [900,1800]; 				// [Minimum,Maximum] time it will take for a mission to timeout | Default: 15-30 mins

	DMS_MissionMarkerWinDot				= true;						// Keep the mission marker dot with a "win" message after mission is over
	DMS_MissionMarkerLoseDot			= true;						// Keep the mission marker dot with a "lose" message after mission is over
	DMS_MissionMarkerWinDotTime			= 30;						// How many seconds the "win" mission dot will remain on the map
	DMS_MissionMarkerLoseDotTime		= 30;						// How many seconds the "lose" mission dot will remain on the map

	DMS_CompletedMissionCleanup			= true;						// Cleanup mission-spawned buildings and AI bodies after some time
	DMS_CompletedMissionCleanupTime		= 3600;						// How long until mission-spawned buildings and AI are cleaned up
	DMS_MissionTimeoutReset				= true;						// Enable mission timeout timer reset if a player is close
	DMS_MissionTimeoutResetRange		= 1000;						// If a player is this close to a mission then it won't time-out

	DMS_PlayerNearBlacklist				= 2000;						// Missions won't spawn in a position this many meters close to a player
	DMS_SpawnZoneNearBlacklist			= 2500;						// Missions won't spawn in a position this many meters close to a spawn zone
	DMS_TraderZoneNearBlacklist			= 3000;						// Missions won't spawn in a position this many meters close to a trader zone
	DMS_MissionNearBlacklist			= 4000;						// Missions won't spawn in a position this many meters close to another mission
	DMS_WaterNearBlacklist				= 750;						// Missions won't spawn in a position this many meters close to water

	DMS_SpawnBoxSmoke					= true;						// Spawn a smoke grenade on mission box upon misson completion
	DMS_SpawnBoxIRGrenade				= true;						// Spawn an IR grenade on mission box upon misson completion
	
	DMS_MinPlayerCount					= 0; 						// Minimum number of players until mission start
	DMS_MinServerFPS					= 10; 						// Minimum server FPS for missions to start

	//Mission notification settings
	DMS_PlayerNotificationTypes			= ["standardHintRequest"];	// Notification types. Supported values are: ["advancedHintRequest","dynamicTextRequest","standardHintRequest","systemChatRequest"]
	DMS_dynamicText_Size				= 0.55;						// Dynamic Text size for "dynamicTextRequest" notification type.
	DMS_dynamicText_Color				= "#FFCC00";				// Dynamic Text color for "dynamicTextRequest" notification type.

	DMS_MissionTypes =					[							//	List of missions with spawn chances. If they add up to 100%, they represent the percentage chance each one will spawn
											["mission1",25],
											["mission2",50],
											["mission3",15],
											["mission4",10]
										];

	DMS_findSafePosBlacklist =			[							// For BIS_fnc_findSafePos position blacklist info refer to: https://community.bistudio.com/wiki/BIS_fnc_findSafePos
										];
/* Mission System Settings */


/* AI Settings */
	DMS_ai_wep_accessories				= ["acc_pointer_IR","acc_flashlight"];
	DMS_ai_wep_suppressors				= ["muzzle_snds_H","muzzle_snds_L","muzzle_snds_M","muzzle_snds_B","muzzle_snds_H_MG","muzzle_snds_acp"];


	DMS_banditSide						= EAST;						// The side (team) that AI Bandits will spawn on
	DMS_clear_AI_body					= false;					// Clear AI body when they die
	DMS_remove_roadkill					= false; 					// Delete AI bodies that are roadkill
	DMS_remove_roadkill_chance			= 0;						// Percentage chance that roadkilled AI bodies will be deleted

	DMS_ai_share_info					= true;						// Share info about killer
	DMS_ai_share_info_distance			= 300;						// The distance killer's info will be shared to other AI

	DMS_ai_use_launchers				= true;						// Enable/disable spawning an AI in a group with a launcher
	DMS_ai_use_launchers_chance			= 0.5;						// Percentage chance to actually spawn the launcher (per-group)
	DMS_ai_remove_launchers				= false;					// Remove rocket launchers on AI death
	DMS_ai_enable_water_equipment		= true;						// Enable/disable overriding default weapons of an AI if it spawns on/in water

	// https://community.bistudio.com/wiki/AI_Sub-skills#general
	DMS_ai_static_skills				= true;						// Use "DMS_ai_skill_static" for AI on static guns
	DMS_ai_skill_extreme				= [["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Extreme
	DMS_ai_skill_hard					= [["aimingAccuracy",0.70],["aimingShake",0.70],["aimingSpeed",0.70],["spotDistance",0.70],["spotTime",0.80],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.70]]; 	// Hard
	DMS_ai_skill_medium					= [["aimingAccuracy",0.60],["aimingShake",0.60],["aimingSpeed",0.60],["spotDistance",0.60],["spotTime",0.60],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.60]];	// Medium
	DMS_ai_skill_easy					= [["aimingAccuracy",0.30],["aimingShake",0.50],["aimingSpeed",0.50],["spotDistance",0.50],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.50]];	// Easy
	DMS_ai_skill_static					= [["aimingAccuracy",0.20],["aimingShake",0.70],["aimingSpeed",0.75],["spotDistance",0.70],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];
	DMS_ai_skill_random					= [ai_skill_extreme,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_easy];
	DMS_static_weapons					= ["O_HMG_01_F","O_HMG_01_high_F"];	// Static weapons for AI

	DMS_assault_weps					= ["arifle_Katiba_GL_F","arifle_MX_GL_Black_F","arifle_Mk20_GL_F","arifle_TRG21_GL_F","arifle_Katiba_F","arifle_MX_Black_F","arifle_TRG21_F","arifle_TRG20_F","arifle_Mk20_plain_F","arifle_Mk20_F"];	// Assault
	DMS_assault_pistols 				= ["hgun_PDW2000_F","hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F"];
	DMS_assault_scopes					= ["optic_Arco","optic_Hamr","optic_Aco","optic_Holosight","optic_MRCO","optic_DMS"];
	DMS_assault_scope_chance			= 0.75;						// Percentage chance that assault AI will get a scope on their weapon
	DMS_assault_items					= ["ItemGPS"];
	DMS_assault_helmets					= ["H_HelmetSpecB_paint1","H_HelmetIA_camo","H_HelmetLeaderO_ocamo","H_HelmetLeaderO_oucamo"];
	DMS_assault_clothes					= ["U_O_CombatUniform_ocamo","U_O_PilotCoveralls","U_B_Wetsuit","U_BG_Guerilla3_1","U_BG_Guerilla2_3","U_BG_Guerilla2_2","U_BG_Guerilla1_1","U_BG_Guerrilla_6_1","U_IG_Guerilla3_2","U_B_SpecopsUniform_sgg","U_I_OfficerUniform","U_B_CTRG_3","U_I_G_resistanceLeader_F"];
	DMS_assault_vests					= ["V_PlateCarrierH_CTRG","V_PlateCarrierSpec_rgr","V_PlateCarrierGL_blk","V_PlateCarrierGL_mtp","V_PlateCarrierGL_rgr","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_mtp","V_PlateCarrierL_CTRG","V_TacVest_blk_POLICE","V_PlateCarrierIA2_dgtl"];
	DMS_assault_backpacks				= ["B_Bergen_rgr","B_Carryall_oli","B_Kitbag_mcamo","B_Carryall_cbr","B_FieldPack_oucamo","B_FieldPack_cbr","B_Bergen_blk"];

	DMS_MG_weps							= ["LMG_Zafir_F","LMG_Mk200_F","arifle_MX_SW_Black_F","MMG_01_hex_F"];	// LMGs
	DMS_MG_pistols 						= ["hgun_PDW2000_F","hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F"];
	DMS_MG_scopes						= ["optic_Hamr","optic_Aco","optic_Holosight","optic_MRCO"];
	DMS_MG_scope_chance					= 0.5;						// Percentage chance that MG AI will get a scope on their weapon
	DMS_MG_items						= ["ItemWatch","ItemMap","ItemCompass","Binocular"];
	DMS_MG_helmets						= ["H_PilotHelmetHeli_I","H_PilotHelmetHeli_O","H_PilotHelmetFighter_I","H_PilotHelmetFighter_O","H_HelmetCrew_O","H_CrewHelmetHeli_I","H_HelmetSpecB_paint1","H_HelmetIA_camo","H_HelmetLeaderO_ocamo","H_HelmetLeaderO_oucamo"];
	DMS_MG_clothes						= ["U_O_CombatUniform_ocamo","U_O_PilotCoveralls","U_B_Wetsuit","U_BG_Guerilla3_1","U_BG_Guerilla2_3","U_BG_Guerilla2_2","U_BG_Guerilla1_1","U_BG_Guerrilla_6_1","U_IG_Guerilla3_2","U_B_SpecopsUniform_sgg","U_I_OfficerUniform","U_B_CTRG_3","U_I_G_resistanceLeader_F"];
	DMS_MG_vests						= ["V_PlateCarrierH_CTRG","V_PlateCarrierSpec_rgr","V_PlateCarrierGL_blk","V_PlateCarrierGL_mtp","V_PlateCarrierGL_rgr","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_mtp","V_PlateCarrierL_CTRG","V_TacVest_blk_POLICE","V_PlateCarrierIA2_dgtl","V_HarnessO_brn","V_HarnessO_gry"];
	DMS_MG_backpacks					= ["B_Bergen_rgr","B_Carryall_oli","B_Kitbag_mcamo","B_Carryall_cbr","B_Bergen_blk"];

	DMS_sniper_weps						= ["srifle_EBR_F","srifle_DMR_01_F","srifle_GM6_F","srifle_LRR_F","arifle_MXM_F","arifle_MXM_Black_F","srifle_DMR_02_F"];	// Sniper rifles
	DMS_sniper_pistols 					= ["hgun_PDW2000_F","hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F"];
	DMS_sniper_scopes					= ["optic_SOS","optic_DMS","optic_LRPS"];
	DMS_sniper_scope_chance				= 1;						// Percentage chance that sniper AI will get a scope on their weapon
	DMS_sniper_items					= ["Rangefinder","ItemGPS"];
	DMS_sniper_helmets					= ["H_HelmetSpecB_paint1","H_HelmetIA_camo","H_HelmetLeaderO_ocamo","H_HelmetLeaderO_oucamo"];
	DMS_sniper_clothes					= ["U_O_GhillieSuit","U_B_FullGhillie_ard","U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_GhillieSuit","U_I_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_GhillieSuit","U_O_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard"];
	DMS_sniper_vests					= ["V_PlateCarrierH_CTRG","V_PlateCarrierSpec_rgr","V_PlateCarrierGL_blk","V_PlateCarrierGL_mtp","V_PlateCarrierGL_rgr","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_mtp","V_PlateCarrierL_CTRG","V_TacVest_blk_POLICE","V_PlateCarrierIA2_dgtl","V_HarnessO_brn","V_HarnessO_gry"];
	DMS_sniper_backpacks				= ["B_Bergen_rgr","B_Carryall_oli","B_Kitbag_mcamo","B_Carryall_cbr","B_Bergen_blk"];
	DMS_random_AI						= ["assault","assault","assault","sniper","machine"];	// random weapon 60% chance assault rifle,20% light machine gun,20% sniper rifle

	DMS_AI_wep_launchers				= ["Exile_Melee_Axe"];
/* AI Settings */

/* Loot Settings */
	DMS_BoxWeapons =					[							//List of weapons that can potentially spawn in a crate
											"Exile_Melee_Axe",
											"arifle_Katiba_GL_F",
											"arifle_MX_GL_Black_F",
											"arifle_Mk20_GL_F",
											"arifle_TRG21_GL_F",
											"arifle_Katiba_F",
											"arifle_MX_Black_F",
											"arifle_TRG21_F",
											"arifle_TRG20_F",
											"arifle_Mk20_plain_F",
											"arifle_Mk20_F",
											"LMG_Zafir_F",
											"LMG_Mk200_F",
											"arifle_MX_SW_Black_F",
											"MMG_01_hex_F",
											"srifle_EBR_F",
											"srifle_DMR_01_F",
											"srifle_GM6_F",
											"srifle_LRR_F",
											"arifle_MXM_F",
											"arifle_MXM_Black_F",
											"srifle_DMR_02_F"
										];
	DMS_BoxSurvivalSupplies	=			[							//List of survival supplies (food/drink/meds)
											"Exile_Item_Catfood_Cooked",
											"Exile_Item_SausageGravy_Cooked",
											"Exile_Item_BBQSandwich_Cooked",
											"Exile_Item_PlasticBottleFreshWater",
											"Exile_Item_PlasticBottleFreshWater",
											"Exile_Item_Matches",
											"Exile_Item_CookingPot"
										];
	DMS_BoxBuildingSupplies	=			[							//List of building supplies
											"Exile_Item_CamoTentKit",
											"Exile_Item_MetalPole",
											"Exile_Item_MetalBoard",
											"Exile_Item_LightBulb",
											"Exile_Item_JunkMetal",
											"Exile_Item_ExtensionCord",
											"Exile_Item_DuctTape"
										];
	DMS_BoxOptics =						[
											"optic_Arco",
											"optic_Hamr",
											"optic_Aco",
											"optic_Holosight",
											"optic_MRCO",
											"optic_SOS",
											"optic_DMS",
											"optic_LRPS",
											"optic_Nightstalker"
										];
	DMS_BoxBackpacks =					[							//List of backpacks that can potentially spawn in a crate
											"B_Bergen_rgr",
											"B_Carryall_oli",
											"B_Kitbag_mcamo",
											"B_Carryall_cbr",
											"B_FieldPack_oucamo",
											"B_FieldPack_cbr",
											"B_Bergen_blk"
										];
	DMS_BoxItems						= DMS_BoxSurvivalSupplies+DMS_BoxBuildingSupplies+DMS_BoxOptics;	// Random "items" can spawn optics, survival supplies, or building supplies
	DMS_RareLoot						= true;																// Potential chance to spawn rare loot in any crate.
	DMS_RareLootList					= ["Exile_Item_SafeKit","Exile_Item_CodeLock"];						// List of rare loot to spawn
	DMS_RareLootChance					= 0.1;																// Chance to spawn rare loot in any crate | Default: 10%

	// Vehicles
	DMS_ArmedVehicles	 				= ["Exile_Car_Offroad_Armed_Guerilla01"];
	DMS_RefuelTrucks					= ["Exile_Car_Van_Fuel_Black","Exile_Car_Van_Fuel_White","Exile_Car_Van_Fuel_Red","Exile_Car_Van_Fuel_Guerilla01","Exile_Car_Van_Fuel_Guerilla02","Exile_Car_Van_Fuel_Guerilla03"];
	DMS_TransportTrucks 				= ["Exile_Car_Van_Guerilla01","Exile_Car_Van_Black"];
	
	DMS_TransportHelis 					= ["Exile_Chopper_Hummingbird_Green","Exile_Chopper_Orca_BlackCustom","Exile_Chopper_Mohawk_FIA","Exile_Chopper_Huron_Black","Exile_Chopper_Hellcat_Green","Exile_Chopper_Taru_Transport_Black"];
	DMS_MilitaryVehicles 				= ["Exile_Car_Strider","Exile_Car_Hunter","Exile_Car_Ifrit"];

	DMS_CivilianVehicles 				= ["Exile_Car_Hatchback_Rusty1","Exile_Car_Hatchback_Rusty2","Exile_Car_Hatchback_Sport_Red","Exile_Car_SUV_Red","Exile_Car_Offroad_Rusty2","Exile_Bike_QuadBike_Fia"];
/* Loot Settings */

	// Debug Overwrites
	if(DMS_DEBUG) then {
		DMS_TimeBetweenMissions			= [60,60];
		DMS_MissionTimeOut				= [300,300];
	};