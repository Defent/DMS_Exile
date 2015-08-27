/* GENERAL CONFIG */

	DMS_DEBUG					= false;		// enable debug
	blacklist =		// I'm not using it
	[
	];
/* END GENERAL CONFIG */


/*
	[_delay, _function, _params, _persistance] call ExileServer_system_thread_addTask;
*/

	DMS_CompletedMissionCleanup			= true;						// Cleanup mission-spawned buildings and AI bodies after some time
	DMS_CompletedMissionCleanup_Time	= 3600;						// How long until mission-spawned buildings and AI are cleaned up
	DMS_player_reset_timeout			= true;						// If a player is this close to a mission then it won't time-out
	DMS_player_reset_timeout_range		= true;						// If a player is this close to a mission then it won't time-out
	DMS_player_notification_types		= ["standardHintRequest"];	// Notification types. Supported values are: ["advancedHintRequest","dynamicTextRequest","standardHintRequest","systemChatRequest"]
	DMS_dynamicText_Size				= 0.55;						// Dynamic Text size for "dynamicTextRequest" notification type.
	DMS_dynamicText_Color				= "#FFCC00";				// Dynamic Text color for "dynamicTextRequest" notification type.

/* AI CONFIG */

	ai_clear_body 				= false;		// instantly clear bodies
	ai_clean_dead 				= true;			// clear bodies after certain amount of time
	ai_cleanup_time 			= 3600;			// time to clear bodies in seconds
	ai_clean_roadkill			= false; 		// clean bodies that are roadkills
	ai_roadkill_damageweapon	= 0;			// percentage of chance a roadkill will destroy weapon AI is carrying
	wai_bandit_side				= east;

	ai_bandit_combatmode		= "RED";		// combatmode of bandit AI
	ai_bandit_behaviour			= "COMBAT";		// behaviour of bandit AI

	ai_share_info				= true;			// AI share info on player position
	ai_share_distance			= 300;			// distance from killed AI for AI to share your rough position

	// https://community.bistudio.com/wiki/AI_Sub-skills#general
	ai_skill_extreme			= [["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Extreme
	ai_skill_hard				= [["aimingAccuracy",0.70],["aimingShake",0.70],["aimingSpeed",0.70],["spotDistance",0.70],["spotTime",0.80],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.70]]; 	// Hard
	ai_skill_medium				= [["aimingAccuracy",0.60],["aimingShake",0.60],["aimingSpeed",0.60],["spotDistance",0.60],["spotTime",0.60],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.60]];	// Medium
	ai_skill_easy				= [["aimingAccuracy",0.30],["aimingShake",0.50],["aimingSpeed",0.50],["spotDistance",0.50],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.50]];	// Easy
	ai_skill_random				= [ai_skill_extreme,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_easy];

	ai_static_useweapon			= true;	// Allows AI on static guns to have a loadout 	
	ai_static_weapons			= ["O_HMG_01_F","O_HMG_01_high_F"];	// static guns 

	ai_static_skills			= false;	// Allows you to set custom array for AI on static weapons. (true: On false: Off) 
	ai_static_array				= [["aimingAccuracy",0.20],["aimingShake",0.70],["aimingSpeed",0.75],["endurance",1.00],["spotDistance",0.70],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];
	
	ai_assault_wep				= ["arifle_Katiba_GL_F","arifle_MX_GL_Black_F","arifle_Mk20_GL_F","arifle_TRG21_GL_F","arifle_Katiba_F","arifle_MX_Black_F","arifle_TRG21_F","arifle_TRG20_F","arifle_Mk20_plain_F","arifle_Mk20_F"];	// Assault
	ai_assault_scope			= ["optic_Arco","optic_Hamr","optic_Aco","optic_Holosight","optic_MRCO","optic_DMS"];
	ai_assault_gear				= ["ItemGPS","Binocular"];
	ai_assault_skin				= ['U_O_CombatUniform_ocamo','U_O_PilotCoveralls','U_B_Wetsuit','U_BG_Guerilla3_1','U_BG_Guerilla2_3','U_BG_Guerilla2_2','U_BG_Guerilla1_1','U_BG_Guerrilla_6_1','U_IG_Guerilla3_2','U_B_SpecopsUniform_sgg','U_I_OfficerUniform','U_B_CTRG_3','U_I_G_resistanceLeader_F'];
	ai_assault_skin 			= ai_assault_skin + ["U_I_Protagonist_VR"];//Give the VR suit half as much of a chance to spawn as another
	ai_assault_backpack			= ["B_Bergen_rgr","B_Carryall_oli","B_Kitbag_mcamo","B_Carryall_cbr","B_FieldPack_oucamo","B_FieldPack_cbr","B_Bergen_blk"];
	ai_assault_vest				= ["V_PlateCarrierH_CTRG","V_PlateCarrierSpec_rgr","V_PlateCarrierGL_blk","V_PlateCarrierGL_mtp","V_PlateCarrierGL_rgr","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_mtp","V_PlateCarrierL_CTRG","V_TacVest_blk_POLICE","V_PlateCarrierIA2_dgtl"];
	ai_assault					= [ai_assault_wep,ai_assault_scope,ai_assault_gear,ai_assault_skin,ai_assault_backpack,ai_assault_vest];
	
	ai_machine_wep				= ["LMG_Zafir_F","LMG_Mk200_F","arifle_MX_SW_Black_F","MMG_01_hex_F"];	// Light machine guns
	ai_machine_scope			= ["optic_Arco","optic_Hamr","optic_Aco","optic_Holosight","optic_MRCO","optic_DMS"];
	ai_machine_gear				= ["ItemWatch","ItemMap","ItemCompass"];
	ai_machine_skin				= ai_assault_skin;//Use the same skins as assault :P
	ai_machine_backback			= ["B_Bergen_rgr","B_Carryall_oli","B_Kitbag_mcamo","B_Carryall_cbr","B_Bergen_blk"];
	ai_machine_vest				= ai_assault_vest + ["V_HarnessO_brn","V_HarnessO_gry"];
	ai_machine					= [ai_machine_wep,ai_machine_scope,ai_machine_gear,ai_machine_skin,ai_machine_backback,ai_machine_vest];
	
	ai_sniper_wep				= ["srifle_EBR_F","srifle_DMR_01_F","srifle_GM6_F","srifle_LRR_F","arifle_MXM_F","arifle_MXM_Black_F","srifle_DMR_02_F"];	// Sniper rifles
	ai_sniper_scope				= ["optic_SOS","optic_DMS","optic_LRPS"];
	ai_sniper_scope				= ai_sniper_scope + ai_sniper_scope + ["optic_Nightstalker","optic_tws"];//Approximately 1/3rd as much chance to spawn thermal sight
	ai_sniper_gear				= ["Rangefinder","ItemGPS"];
	ai_sniper_skin				= ["U_O_GhillieSuit","U_B_FullGhillie_ard","U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_GhillieSuit","U_I_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_GhillieSuit","U_O_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard"];
	ai_sniper_backpack			= ai_machine_backback;//Same backpacks as machinegunners
	ai_sniper_vest				= ai_machine_vest;//Same vests as machinegunners
	ai_sniper					= [ai_sniper_wep,ai_sniper_scope,ai_sniper_gear,ai_sniper_skin,ai_sniper_backpack,ai_sniper_vest];
	ai_headgear_list			= ["H_PilotHelmetHeli_I","H_PilotHelmetHeli_O","H_PilotHelmetFighter_I","H_PilotHelmetFighter_O","H_HelmetCrew_O","H_CrewHelmetHeli_I","H_HelmetSpecB_paint1","H_HelmetIA_camo","H_HelmetLeaderO_ocamo","H_HelmetLeaderO_oucamo"];

	ai_random					= [ai_assault,ai_assault,ai_assault,ai_sniper,ai_machine];	// random weapon 60% chance assault rifle,20% light machine gun,20% sniper rifle
	
	// Weapons accessories
	ai_wep_item					= ["acc_pointer_IR","acc_flashlight"];
	ai_wep_Suppressor			= ["muzzle_snds_H","muzzle_snds_L","muzzle_snds_M","muzzle_snds_B","muzzle_snds_H_MG","muzzle_snds_acp"];
	
	
	ai_pistols 					= ["hgun_PDW2000_F","hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F"];
	ai_wep_water 				= ["arifle_SDAR_F"];
	
	// AT/AA launchers
	ai_wep_launchers_AT			= [];
	ai_wep_launchers_AA			= [];
	
/* END AI CONFIG */

/* WAI MISSIONS CONFIG */
	wai_mission_system			= true;				// use built in mission system

	wai_mission_markers			= [];
	wai_avoid_missions			= 2000;				// avoid spawning missions this close to other missions, these are defined in wai_mission_markers
	//wai_avoid_traders				= 0;			// avoid spawning missions this close to traders
	//wai_avoid_town				= 0;			// avoid spawning missions this close to towns, *** doesn't function with infiSTAR enabled ***
	//wai_avoid_road				= 0;			// avoid spawning missions this close to roads
	wai_near_water				= 500;			// avoid spawning missions this close to water
	
	wai_blacklist_players_range = 2000;				// distance to players
	wai_blacklist_range			= 2000;				// distance to base, traders, spawnpoint

	wai_mission_timer			= [600,900];		// time between missions 10-15 minutes
	wai_mission_timeout			= [900,1800]; 		// time each missions takes to despawn if inactive 15-30 minutes
	wai_timeout_bomb			= 1800;				// How long bomb missions is, when it times out it gos BOOM
	
	wai_clean_mission			= true;				// clean all mission buildings after a certain period
	wai_clean_mission_time		= 900;				// time after a mission is complete to clean mission buildings

	//wai_mission_fuel			= [5,60];			// fuel inside mission spawned vehicles [min%,max%]
	//wai_vehicle_damage		= [20,70];			// damages to spawn vehicles with [min%,max%]
	//wai_keep_vehicles			= true;				// save vehicles to database and keep them after restart
	//wai_lock_vehicles			= true;				// lock mission vehicles and add keys to random AI bodies (be careful with ai_clean_dead if this is true

	wai_crates_smoke			= true;				// pop smoke on crate when mission is finished during daytime
	wai_crates_flares			= true;				// pop flare on crate when mission is finished during nighttime
	
	wai_players_online			= 0; 				// number of players online before mission starts
	wai_server_fps				= 10; 				// missions only starts if server FPS is over wai_server_fps
	
	// Don't use might be buged 
	wai_kill_percent			= 0;				// percentage of AI players that must be killed at "crate" missions to be able to trigger completion

	wai_high_value				= true;				// enable the possibility of finding a high value item (defined below crate_items_high_value) inside a crate
	wai_high_value_chance		= 10;				// chance in percent you find above mentioned item

	wai_enable_minefield		= false;			// enable minefields to better defend missions
	wai_use_launchers			= false;			// add a rocket launcher to each spawned AI group
	wai_remove_launcher			= true;				// remove rocket launcher from AI on death

	// Missions
	wai_announce				= "text";			// Setting this to true will announce the missions to those that hold a radio only "radio", "global", "hint", "text"
	wai_bandit_limit			= 1;				// define how many bandit missions can run at once
	
	//Syntax ["MISSION NAME","CHANGE"] Change must equal 100 when put together 
	wai_bandit_missions			= [
								//	["nuke",2],
									["sniper_team",1],
									["rebel_base",1],
									["medi_camp",1],
								//	["ikea_convoy",30],
									["patrol",0],
									["armed_vehicle",0],
									["black_hawk_crash",0],
									["captured_mv22",0],
									["broken_down_ural",0],
									["presidents_mansion",0],
									["weapon_cache",1],
									
									["debug",0]
								];
	
	// Vehicle arrays
	armed_vehicle 				= ["Exile_Car_Offroad_Armed_Guerilla01"]; 
	armed_chopper 				= ["Exile_Chopper_Orca_BlackCustom"];
	refuel_trucks				= ["Exile_Car_Van_Fuel_Guerilla01"];
	
	civil_chopper 				= ["Exile_Chopper_Hummingbird_Green","Exile_Chopper_Orca_BlackCustom","Exile_Chopper_Mohawk_FIA","Exile_Chopper_Huron_Black","Exile_Chopper_Hellcat_Green","Exile_Chopper_Taru_Transport_Black"];
	military_unarmed 			= ["Exile_Car_Strider","Exile_Car_Hunter","Exile_Car_Ifrit"];
	cargo_trucks 				= ["Exile_Car_Van_Guerilla01","Exile_Car_Van_Black"];

	civil_vehicles 				= ["Exile_Car_Hatchback_Rusty1","Exile_Car_Hatchback_Rusty2","Exile_Car_Hatchback_Sport_Red","Exile_Car_SUV_Red","Exile_Car_Offroad_Rusty2","Exile_Bike_QuadBike_Fia"];
	boots						= [];
	
	wreck_water					= ["Land_UWreck_FishingBoat_F","Land_UWreck_Heli_Attack_02_F","Land_UWreck_MV22_F","Land_Wreck_Traw2_F","Land_Wreck_Traw_F"];
	wreck						= [];

	// Dynamic box array
	crates_large				= ["Box_NATO_AmmoVeh_F"]; 
	crates_medium				= ["C_supplyCrate_F"];  
	crates_small				= ["Box_NATO_WpsSpecial_F"];
	
	// weapons
	crate_weapons_buildables    = ["Exile_Melee_Axe"];//<--- TODO Setup Ikea Mission
	crate_tools					= ["Binocular","Rangefinder","ItemGPS","NVGoggles"];
	crate_tools_sniper			= ["Laserdesignator","Rangefinder","NVGoggles","ItemGPS"];
	
	//item
	crate_tools_buildable		= [];//<--- TODO Setup Ikea Mission
	
	crate_items					= ["Exile_Item_Catfood_Cooked","Exile_Item_SausageGravy_Cooked","Exile_Item_BBQSandwich_Cooked","Exile_Item_GloriousKnakworst","Exile_Item_PlasticBottleFreshWater","Exile_Item_PlasticBottleFreshWater","Exile_Item_Energydrink","Exile_Item_Beer","Exile_Item_Matches","Exile_Item_CookingPot","Exile_Item_DuctTape","Exile_Item_InstaDoc"];
	crate_items_high_value		= ["Exile_Item_SafeKit"];
	
	crate_items_food			= ["Exile_Item_Catfood_Cooked","Exile_Item_SausageGravy_Cooked","Exile_Item_BBQSandwich_Cooked","Exile_Item_PlasticBottleFreshWater","Exile_Item_PlasticBottleFreshWater","Exile_Item_Matches","Exile_Item_CookingPot"];
	crate_items_buildables		= [];//<--- TODO Setup Ikea Mission
	
	crate_items_vehicle_repair	= [];
	crate_items_medical			= ["Exile_Item_BBQSandwich_Cooked","Exile_Item_PlasticBottleFreshWater","Exile_Item_InstaDoc"];
	crate_items_sniper			= ["U_O_GhillieSuit",["Exile_Item_InstaDoc",2]];//<--- Not used
	crate_items_president		= ["Exile_Item_InstaDoc"];//<--- Not used

	crate_backpacks_all			= ai_assault_backpack;
	crate_backpacks_large		= ["B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo"];

	crate_random				= [crate_items,crate_items_food,crate_items_vehicle_repair,crate_items_medical];

/* END WAI MISSIONS CONFIG */

	// DEBUG SETTINGS
	if(DMS_DEBUG) then {
		wai_remove_launcher		= false;	
		wai_mission_timer		= [60,60];
		wai_mission_timeout		= [300,300];
		//wai_bandit_missions		= [["debug",100]];			
		//wai_bandit_missions		= [["nuke",100]];			
		//wai_bandit_missions		= [["treasure_hunt_water",100]];			
	};

/* STATIC MISSIONS CONFIG */

	static_missions				= false;		// use static mission file
	custom_per_world			= false;		// use a custom mission file per world