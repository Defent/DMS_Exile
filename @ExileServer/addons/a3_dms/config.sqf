/*
	A lot of these configs are influenced by WAI :P
	https://github.com/nerdalertdk/WICKED-AI

	Created by eraser1
*/
DMS_DEBUG = false;



/* Mission System Settings */
	DMS_DynamicMission					= true;						// Enable/disable dynamic mission system
	DMS_MaxBanditMissions				= 3;						// Maximum number of Bandit Missions running at the same time
	DMS_StaticMission					= false;					// Enable/disable static missions
	DMS_TimeBetweenMissions				= [600,900];				// [Minimum,Maximum] time between missions (if mission limit is not reached) | DEFAULT: 10-15 mins
	DMS_MissionTimeOut					= [900,1800]; 				// [Minimum,Maximum] time it will take for a mission to timeout | Default: 15-30 mins

	DMS_playerNearRadius				= 75;						// How close a player has to be to a mission in order to satisfy the "playerNear" mission requirement (can be customized per mission).

	DMS_AI_KillPercent					= 100;						// The percent amount of AI that need to be killed for "killPercent" mission requirement (NOT IMPLEMENTED)

	DMS_BanditMoneyGainOnKill			= 100;						// The amount of Poptabs gained for killing a bandit
	DMS_BanditRepGainOnKill				= 25;						// The amount of Respect gained for killing a bandit

	DMS_MissionMarkerWinDot				= true;						// Keep the mission marker dot with a "win" message after mission is over
	DMS_MissionMarkerLoseDot			= true;						// Keep the mission marker dot with a "lose" message after mission is over
	DMS_MissionMarkerWinDotTime			= 30;						// How many seconds the "win" mission dot will remain on the map
	DMS_MissionMarkerLoseDotTime		= 30;						// How many seconds the "lose" mission dot will remain on the map
	DMS_MissionMarkerWinDotColor		= "ColorBlue";				// The color of the "win" marker dot
	DMS_MissionMarkerLoseDotColor		= "ColorRed";				// The color of the "lose" marker dot

	DMS_CompletedMissionCleanup			= true;						// Cleanup mission-spawned buildings and AI bodies after some time
	DMS_CompletedMissionCleanupTime		= 3600;						// Minimum time until mission-spawned buildings and AI are cleaned up
	DMS_CleanUp_PlayerNearLimit			= 20;						// Cleanup of an object is aborted if a player is this many meters close to the object
	DMS_MissionTimeoutReset				= true;						// Enable mission timeout timer reset if a player is close
	DMS_MissionTimeoutResetRange		= 1000;						// If a player is this close to a mission then it won't time-out

	DMS_PlayerNearBlacklist				= 2000;						// Missions won't spawn in a position this many meters close to a player
	DMS_SpawnZoneNearBlacklist			= 2500;						// Missions won't spawn in a position this many meters close to a spawn zone
	DMS_TraderZoneNearBlacklist			= 3000;						// Missions won't spawn in a position this many meters close to a trader zone
	DMS_MissionNearBlacklist			= 4000;						// Missions won't spawn in a position this many meters close to another mission
	DMS_WaterNearBlacklist				= 750;						// Missions won't spawn in a position this many meters close to water

	DMS_SpawnBoxSmoke					= true;						// Spawn a smoke grenade on mission box upon misson completion during daytime
	DMS_SpawnBoxIRGrenade				= true;						// Spawn an IR grenade on mission box upon misson completion during nighttime
	
	DMS_MinPlayerCount					= 0; 						// Minimum number of players until mission start
	DMS_MinServerFPS					= 5; 						// Minimum server FPS for missions to start

	//Mission notification settings
	DMS_PlayerNotificationTypes =		[							// Notification types. Supported values are: ["dynamicTextRequest", "standardHintRequest", "systemChatRequest"]
											//"dynamicTextRequest", <--- Currently won't work.
											"standardHintRequest",
											"systemChatRequest"
										];
	DMS_dynamicText_Size				= "0.55";					// Dynamic Text size for "dynamicTextRequest" notification type.
	DMS_dynamicText_Color				= "#FFCC00";				// Dynamic Text color for "dynamicTextRequest" notification type.

	DMS_MissionTypes =					[							//	List of missions with spawn chances. If they add up to 100%, they represent the percentage chance each one will spawn
											["mission1",25],
											["mission2",25],
											["mission3",15],
											["mission4",10],
											["bauhaus",45],
											["lost_battalion",30],
											["walmart",20]
										];

	DMS_findSafePosBlacklist =			[							// For BIS_fnc_findSafePos position blacklist info refer to: https://community.bistudio.com/wiki/BIS_fnc_findSafePos
										];
/* Mission System Settings */


/* AI Settings */

	DMS_banditSide						= EAST;						// The side (team) that AI Bandits will spawn on
	DMS_clear_AI_body					= false;					// Clear AI body as soon as they die
	DMS_clear_AI_body_chance			= 50;						// Percentage chance that AI bodies will be cleared when they die
	DMS_remove_roadkill					= false; 					// Remove gear from AI bodies that are roadkilled
	DMS_remove_roadkill_chance			= 0;						// Percentage chance that roadkilled AI bodies will be deleted
	DMS_RemoveNVG						= false;					// Remove NVGs from AI bodies

	DMS_ai_offload_to_client			= true;						// Offload spawned AI groups to random clients. Helps with server performance.

	DMS_ai_share_info					= true;						// Share info about killer
	DMS_ai_share_info_distance			= 300;						// The distance killer's info will be shared to other AI

	DMS_ai_nighttime_accessory_chance	= 75;						// Percentage chance that AI will have a flashlight or laser pointer on their guns if spawned during nighttime
	DMS_ai_enable_water_equipment		= true;						// Enable/disable overriding default weapons of an AI if it spawns on/in water

	// https://community.bistudio.com/wiki/AI_Sub-skills#general
	DMS_ai_static_skills				= true;						// Use "DMS_ai_skill_static" for AI on static guns
	DMS_ai_skill_static					= [["aimingAccuracy",0.20],["aimingShake",0.70],["aimingSpeed",0.75],["spotDistance",0.70],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];	// Static AI Skills
	DMS_ai_skill_easy					= [["aimingAccuracy",0.30],["aimingShake",0.50],["aimingSpeed",0.50],["spotDistance",0.50],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.50]];	// Easy
	DMS_ai_skill_moderate				= [["aimingAccuracy",0.60],["aimingShake",0.60],["aimingSpeed",0.60],["spotDistance",0.60],["spotTime",0.60],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.60]];	// Moderate
	DMS_ai_skill_difficult				= [["aimingAccuracy",0.70],["aimingShake",0.70],["aimingSpeed",0.70],["spotDistance",0.70],["spotTime",0.80],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.70]]; 	// Difficult
	DMS_ai_skill_hardcore				= [["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Hardcore
	DMS_ai_skill_random					= ["hardcore","difficult","difficult","difficult","moderate","moderate","moderate","moderate","easy","easy"];	// Skill frequencies for "random" AI skills | Default: 10% hardcore, 30% difficult, 40% moderate, and 20% easy
	DMS_AI_WP_Radius_easy				= 20;						// Waypoint radius for "easy" AI
	DMS_AI_WP_Radius_moderate			= 40;						// Waypoint radius for "moderate" AI
	DMS_AI_WP_Radius_difficult			= 75;						// Waypoint radius for "difficult" AI
	DMS_AI_WP_Radius_hardcore			= 150;						// Waypoint radius for "hardcore" AI

	DMS_static_weapons =				[							// Static weapons for AI
											"O_HMG_01_F",
											"O_HMG_01_high_F"
										];

	DMS_ai_default_items =				[							// Toolbelt items each AI will spawn with
											"ItemWatch",
											"ItemMap",
											"ItemCompass",
											"ItemRadio"
										];
	
	DMS_ai_BipodList =					[
											"bipod_01_F_blk",
											"bipod_01_F_mtp",
											"bipod_01_F_snd",
											"bipod_02_F_blk",
											"bipod_02_F_hex",
											"bipod_02_F_tan",
											"bipod_03_F_blk",
											"bipod_03_F_oli"
										];

	//Assault Class
	DMS_assault_weps =					[							// Assault Rifles
											"arifle_Katiba_GL_F",
											"arifle_MX_GL_Black_F",
											"arifle_Mk20_GL_F",
											"arifle_TRG21_GL_F",
											"arifle_Katiba_F",
											"arifle_MX_Black_F",
											"arifle_TRG21_F",
											"arifle_TRG20_F",
											"arifle_Mk20_plain_F",
											"arifle_Mk20_F"
										];
	DMS_assault_pistols =				[							// Pistols for Assault Class (Set to empty array if you don't want to give them any pistols)
											"hgun_ACPC2_F",
											"hgun_Rook40_F",
											"hgun_P07_F",
											"hgun_Pistol_heavy_01_F",
											"hgun_Pistol_heavy_02_F"
										];
	DMS_assault_optics =				[							// Optics for Assault Class
											"optic_Arco",
											"optic_Hamr",
											"optic_Aco",
											"optic_Holosight",
											"optic_MRCO",
											"optic_DMS"
										];
	DMS_assault_optic_chance			= 75;						// Percentage chance that an Assault Class AI will get an optic
	DMS_assault_bipod_chance			= 25;						// Percentage chance that an Assault Class AI will get a bipod
	DMS_assault_suppressor_chance		= 25;						// Percentage chance that an Assault Class AI will get a suppressor

	DMS_assault_items =					[							// Items for Assault Class AI (Loot stuff that goes in uniform/vest/backpack)
											"Exile_Item_InstaDoc",
											"Exile_Item_BBQSandwich",
											"Exile_Item_Energydrink"
										];
	DMS_assault_equipment =				[							// Equipment for Assault Class AI (stuff that goes in toolbelt slots)
											"ItemGPS"
										];
	DMS_assault_helmets	=				[							// Helmets for Assault Class
											"H_HelmetSpecB_paint1",
											"H_HelmetIA_camo",
											"H_HelmetLeaderO_ocamo",
											"H_HelmetLeaderO_oucamo"
										];
	DMS_assault_clothes	=				[							// Uniforms for Assault Class
											"U_O_CombatUniform_ocamo",
											"U_O_PilotCoveralls",
											"U_B_Wetsuit",
											"U_BG_Guerilla3_1",
											"U_BG_Guerilla2_3",
											"U_BG_Guerilla2_2",
											"U_BG_Guerilla1_1",
											"U_BG_Guerrilla_6_1",
											"U_IG_Guerilla3_2",
											"U_B_SpecopsUniform_sgg",
											"U_I_OfficerUniform",
											"U_B_CTRG_3",
											"U_I_G_resistanceLeader_F"
										];
	DMS_assault_vests =					[							// Vests for Assault Class
											"V_PlateCarrierH_CTRG",
											"V_PlateCarrierSpec_rgr",
											"V_PlateCarrierGL_blk",
											"V_PlateCarrierGL_mtp",
											"V_PlateCarrierGL_rgr",
											"V_PlateCarrierSpec_blk",
											"V_PlateCarrierSpec_mtp",
											"V_PlateCarrierL_CTRG",
											"V_TacVest_blk_POLICE",
											"V_PlateCarrierIA2_dgtl"
										];
	DMS_assault_backpacks =				[							// Backpacks for Assault Class
											"B_Bergen_rgr",
											"B_Carryall_oli",
											"B_Kitbag_mcamo",
											"B_Carryall_cbr",
											"B_FieldPack_oucamo",
											"B_FieldPack_cbr",
											"B_Bergen_blk"
										];

	//Machine Gun Class
	DMS_MG_weps	=						[							// Machine Guns
											"LMG_Zafir_F",
											"LMG_Mk200_F",
											"arifle_MX_SW_Black_F",
											"MMG_01_hex_F"
										];
	DMS_MG_pistols =					[							// Pistols for MG Class (Set to empty array if you don't want to give them any pistols)
											"hgun_ACPC2_F",
											"hgun_Rook40_F",
											"hgun_P07_F",
											"hgun_Pistol_heavy_01_F",
											"hgun_Pistol_heavy_02_F"
										];
	DMS_MG_optics =						[							//	Optics for MG Class
											"optic_Hamr",
											"optic_Aco",
											"optic_Holosight",
											"optic_MRCO"
										];
	DMS_MG_optic_chance					= 50;						// Percentage chance that an MG Class AI will get an optic
	DMS_MG_bipod_chance					= 90;						// Percentage chance that an MG Class AI will get a bipod
	DMS_MG_suppressor_chance			= 10;						// Percentage chance that an MG Class AI will get a suppressor

	DMS_MG_items =						[							// Items for MG Class AI (Loot stuff that goes in uniform/vest/backpack)
											"Exile_Item_InstaDoc",
											"Exile_Item_Catfood_Cooked",
											"Exile_Item_PlasticBottleFreshWater",
											"Exile_Item_CookingPot"
										];
	DMS_MG_equipment =					[							// Equipment for MG Class AI (stuff that goes in toolbelt slots)
											"Binocular"
										];
	DMS_MG_helmets =					[							// Helmets for MG Class
											"H_PilotHelmetHeli_I",
											"H_PilotHelmetHeli_O",
											"H_PilotHelmetFighter_I",
											"H_PilotHelmetFighter_O",
											"H_HelmetCrew_O",
											"H_CrewHelmetHeli_I",
											"H_HelmetSpecB_paint1",
											"H_HelmetIA_camo",
											"H_HelmetLeaderO_ocamo",
											"H_HelmetLeaderO_oucamo"
										];
	DMS_MG_clothes =					[							// Uniforms for MG Class
											"U_O_CombatUniform_ocamo",
											"U_O_PilotCoveralls",
											"U_B_Wetsuit",
											"U_BG_Guerilla3_1",
											"U_BG_Guerilla2_3",
											"U_BG_Guerilla2_2",
											"U_BG_Guerilla1_1",
											"U_BG_Guerrilla_6_1",
											"U_IG_Guerilla3_2",
											"U_B_SpecopsUniform_sgg",
											"U_I_OfficerUniform",
											"U_B_CTRG_3",
											"U_I_G_resistanceLeader_F"
										];
	DMS_MG_vests =						[							// Vests for MG Class
											"V_PlateCarrierH_CTRG",
											"V_PlateCarrierSpec_rgr",
											"V_PlateCarrierGL_blk",
											"V_PlateCarrierGL_mtp",
											"V_PlateCarrierGL_rgr",
											"V_PlateCarrierSpec_blk",
											"V_PlateCarrierSpec_mtp",
											"V_PlateCarrierL_CTRG",
											"V_TacVest_blk_POLICE",
											"V_PlateCarrierIA2_dgtl",
											"V_HarnessO_brn",
											"V_HarnessO_gry"
										];
	DMS_MG_backpacks =					[							// Backpacks for MG Class
											"B_Bergen_rgr",
											"B_Carryall_oli",
											"B_Kitbag_mcamo",
											"B_Carryall_cbr",
											"B_Bergen_blk"
										];

	//Sniper Class
	DMS_sniper_weps =					[							// Sniper Rifles
											"srifle_EBR_F",
											"srifle_DMR_01_F",
											"srifle_GM6_F",
											"srifle_LRR_F",
											"arifle_MXM_F",
											"arifle_MXM_Black_F",
											"srifle_DMR_02_F"
										];
	DMS_sniper_pistols =				[							// Pistols for Sniper Class (Set to empty array if you don't want to give them any pistols)
											"hgun_ACPC2_F",
											"hgun_Rook40_F",
											"hgun_P07_F",
											"hgun_Pistol_heavy_01_F",
											"hgun_Pistol_heavy_02_F"
										];
	DMS_sniper_optics =					[							// Optics for Sniper Class
											"optic_SOS",
											"optic_DMS",
											"optic_LRPS"
										];
	DMS_sniper_optic_chance				= 100;						// Percentage chance that a Sniper Class AI will get an optic
	DMS_sniper_bipod_chance				= 90;						// Percentage chance that a Sniper Class AI will get a bipod
	DMS_sniper_suppressor_chance		= 15;						// Percentage chance that a Sniper Class AI will get a suppressor

	DMS_sniper_items =					[							// Items for Sniper Class AI (Loot stuff that goes in uniform/vest/backpack)
											"Exile_Item_InstaDoc",
											"Exile_Item_Surstromming_Cooked",
											"Exile_Item_PlasticBottleFreshWater",
											"Exile_Item_PlasticBottleFreshWater",
											"Exile_Item_Matches"
										];
	DMS_sniper_equipment =				[							// Equipment for Sniper Class AI (stuff that goes in toolbelt slots)
											"Rangefinder",
											"ItemGPS"
										];
	DMS_sniper_helmets =				[							// Helmets for Sniper Class
											"H_HelmetSpecB_paint1",
											"H_HelmetIA_camo",
											"H_HelmetLeaderO_ocamo",
											"H_HelmetLeaderO_oucamo"
										];
	DMS_sniper_clothes =				[							// Uniforms for Sniper Class
											"U_O_GhillieSuit",
											"U_B_FullGhillie_ard",
											"U_B_FullGhillie_lsh",
											"U_B_FullGhillie_sard",
											"U_B_GhillieSuit",
											"U_I_FullGhillie_ard",
											"U_I_FullGhillie_lsh",
											"U_I_FullGhillie_sard",
											"U_I_GhillieSuit",
											"U_O_FullGhillie_ard",
											"U_O_FullGhillie_lsh",
											"U_O_FullGhillie_sard"
										];
	DMS_sniper_vests =					[							// Vests for Sniper Class
											"V_PlateCarrierH_CTRG",
											"V_PlateCarrierSpec_rgr",
											"V_PlateCarrierGL_blk",
											"V_PlateCarrierGL_mtp",
											"V_PlateCarrierGL_rgr",
											"V_PlateCarrierSpec_blk",
											"V_PlateCarrierSpec_mtp",
											"V_PlateCarrierL_CTRG",
											"V_TacVest_blk_POLICE",
											"V_PlateCarrierIA2_dgtl",
											"V_HarnessO_brn",
											"V_HarnessO_gry"
										];
	DMS_sniper_backpacks =				[							// Backpacks for Sniper Class
											"B_Bergen_rgr",
											"B_Carryall_oli",
											"B_Kitbag_mcamo",
											"B_Carryall_cbr",
											"B_Bergen_blk"
										];
	
	DMS_ai_SupportedClasses =			[							// Allowed AI classes. If you want to create your own class, make sure you define everything as I've defined above, and add it here
											"assault",
											"MG",
											"sniper"
										];

	DMS_random_AI =						[							// The classes that a "random" AI can spawn as | DEFAULT: 60% Assault, 20% MG, 20% Sniper
											"assault",
											"assault",
											"assault",
											"MG",
											"sniper"
										];

	DMS_ai_use_launchers				= true;						// Enable/disable spawning an AI in a group with a launcher
	DMS_ai_use_launchers_chance			= 50;						// Percentage chance to actually spawn the launcher (per-group)
	DMS_AI_launcher_ammo_count			= 2;						// How many rockets an AI will get with its launcher
	DMS_ai_remove_launchers				= true;					// Remove rocket launchers on AI death

	DMS_AI_wep_launchers_AT =			[							// AT Launchers
											"launch_NLAW_F",
											"launch_RPG32_F",
											"launch_B_Titan_short_F"
										];
	DMS_AI_wep_launchers_AA =			[							// AA Launchers
											"launch_B_Titan_F"
										];

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

	DMS_RareLoot						= true;						// Potential chance to spawn rare loot in any crate.
	DMS_RareLootList =					[							// List of rare loot to spawn
											"Exile_Item_SafeKit",
											"Exile_Item_CodeLock"
										];
	DMS_RareLootChance					= 10;						// Percentage Chance to spawn rare loot in any crate | Default: 10%

	// Vehicles
	DMS_ArmedVehicles =					[							// List of armed vehicles that can spawn
											"Exile_Car_Offroad_Armed_Guerilla01"
										];
										
	DMS_MilitaryVehicles =				[							// List of military vehicles that can spawn
											"Exile_Car_Strider",
											"Exile_Car_Hunter",
											"Exile_Car_Ifrit"
										];

	DMS_TransportTrucks =				[							// List of transport trucks that can spawn
											"Exile_Car_Van_Guerilla01",
											"Exile_Car_Van_Black"
										];

	DMS_RefuelTrucks =					[							// List of refuel trucks that can spawn
											"Exile_Car_Van_Fuel_Black",
											"Exile_Car_Van_Fuel_White",
											"Exile_Car_Van_Fuel_Red",
											"Exile_Car_Van_Fuel_Guerilla01",
											"Exile_Car_Van_Fuel_Guerilla02",
											"Exile_Car_Van_Fuel_Guerilla03"
										];

	DMS_CivilianVehicles =				[							// List of civilian vehicles that can spawn
											"Exile_Car_SUV_Red",
											"Exile_Car_Hatchback_Rusty1",
											"Exile_Car_Hatchback_Rusty2",
											"Exile_Car_Hatchback_Sport_Red",
											"Exile_Car_SUV_Red",
											"Exile_Car_Offroad_Rusty2",
											"Exile_Bike_QuadBike_Fia"
										];
	
	DMS_TransportHelis =				[							// List of transport helis that can spawn
											"Exile_Chopper_Hummingbird_Green",
											"Exile_Chopper_Orca_BlackCustom",
											"Exile_Chopper_Mohawk_FIA",
											"Exile_Chopper_Huron_Black",
											"Exile_Chopper_Hellcat_Green",
											"Exile_Chopper_Taru_Transport_Black"
										];
/* Loot Settings */


// Debug Overwrites
if(DMS_DEBUG) then {
	DMS_TimeBetweenMissions			= [30,60];
	DMS_MissionTimeOut				= [240,300];
	diag_log format ["DMS_DEBUG CONFIG :: Overriding DMS_TimeBetweenMissions (%1) and DMS_MissionTimeOut (%2)",DMS_TimeBetweenMissions,DMS_MissionTimeOut];
};