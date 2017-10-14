/*
	Main DMS Config File

	Created by eraser1
	Several revisions and additions have been made by community members.


	A lot of these configs are influenced by WAI :P
	https://github.com/nerdalertdk/WICKED-AI
*/

// You dawg... heard you like configs... so here's some configs for your config.... so you can configure your configuration to make it easier to configure your configuration http://i.imgur.com/9eJjEEo.jpg


// If you don't want the AI to have marksman DLC weapons, then simply remove the line below, or comment it by putting // at the beginning of the line
#define GIVE_AI_MARKSMAN_DLC_WEAPONS 1

// If you don't want crates to spawn with marksman DLC weapons, simply remove the line below or comment it out.
#define USE_MARKSMAN_DLC_WEAPONS_IN_CRATES 1

// Uncomment this if you want Apex weapons on AI.
//#define GIVE_AI_APEX_WEAPONS 1

// Uncomment this if you want Apex gear on AI. Uniforms, Vests, Backpacks, Helmets,Scopes
//#define GIVE_AI_APEX_GEAR 1

// Uncomment this if you want Apex weapons in loot crates
//#define USE_APEX_WEAPONS_IN_CRATES 1

// Uncomment this if you want Apex vehicles to spawn for AI/missions
//#define USE_APEX_VEHICLES 1




DMS_Use_Map_Config = true;	// Whether or not to use config overwrites specific to the map.
/*
	If you are using a map other than a map listed in the "map_configs" folder, you should set this to false OR create a new file within the map_configs folder for the map so that you don't get a missing file error.
	To share your map-specific config, please create a merge request on GitHub and/or leave a message on the DMS thread in the Exile forums.
	For any questions regarding map-specific configs, please leave a reply in the DMS thread on the Exile forums.
*/

DMS_Enable_RankChange = false; // Whether or not to use Rank Changes. (Required 'true' if using Occupation)
/*
	I am sharing this upgrade to all. If you utilize GR8 Humanity (fully compatible) or a custom version of a ranking system(simple variable changes), this will allow your players to score +/- for Bandit and Hero kills as well as a custom Survivor Faction added to DMS as well. You can still utilize the HERO / BANDIT / SURVIVOR respect and poptab settings for gameplay :) ENJOY! DONKEYPUNCH.INFO!
*/

DMS_Add_AIKill2DB = false;  // Adds killstat for player in the database ;)

DMS_SpawnMissions_Scheduled = false;	// Whether or not to spawn missions in a scheduled environment. Setting to true may help with lag when certain missions spawn.
//Note, if you have the above to true, you need to set DMS_ai_freezeOnSpawn = false; and DMS_ai_share_info = true;

/* Mission System Settings */
	/*General settings for dynamic missions*/
	DMS_DynamicMission					= true;						// Enable/disable dynamic mission system.
	DMS_MaxBanditMissions				= 3;						// Maximum number of Bandit Missions running at the same time
	DMS_TimeToFirstMission				= [180,420];				// [Minimum,Maximum] time between first mission spawn. | DEFAULT: 3-7 minutes.
	DMS_TimeBetweenMissions				= [600,900];				// [Minimum,Maximum] time between missions (if mission limit is not reached) | DEFAULT: 10-15 mins
	DMS_MissionTimeout					= [900,1800]; 				// [Minimum,Maximum] time it will take for a mission to timeout | DEFAULT: 15-30 mins
	DMS_MissionTimeoutResetRange		= 1500;						// If a player is this close to a mission then it won't time-out. Set to 0 to disable this check.
	DMS_MissionTimeoutResetFrequency	= 180;						// How often (in seconds) to check for nearby players and reset the mission timeout.
	DMS_ResetMissionTimeoutOnKill		= true;						// Whether or not to reset the mission timeout when an AI is killed.
	/*General settings for dynamic missions*/

	/*General settings for static missions*/
	DMS_StaticMission					= true;						// Enable/disable static mission system.
	DMS_MaxStaticMissions				= 1;						// Maximum number of Static Missions running at the same time. It's recommended you set this to the same amount of static missions that you have in total. This config will be ignored by "DMS_StaticMissionsOnServerStart".
	DMS_TimeToFirstStaticMission		= [30,30];					// [Minimum,Maximum] time between first static mission spawn. | DEFAULT: 3-7 minutes.
	DMS_TimeBetweenStaticMissions		= [900,1800];				// [Minimum,Maximum] time between static missions (if static mission limit is not reached) | DEFAULT: 15-30 mins
	DMS_StaticMissionTimeOut			= [1800,3600]; 				// [Minimum,Maximum] time it will take for a static mission to timeout | DEFAULT: 30-60 mins
	DMS_StaticMissionTimeoutResetRange	= 1500;						// If a player is this close to a mission then it won't time-out. Set to 0 to disable this check.
	DMS_SMissionTimeoutResetFrequency	= 180;						// How often (in seconds) to check for nearby players and reset the mission timeout for static missions.
	DMS_ResetStaticMissionTimeoutOnKill	= true;						// Whether or not to reset the mission timeout when an AI is killed (for Static Missions).
	DMS_StaticMinPlayerDistance			= 1500;						// If a player is this close to a mission location, then it won't spawn the mission and will wait 60 seconds before attempting to spawn it.
	DMS_AllowStaticReinforcements		= true;						// Whether or not static missions will receive reinforcements. This will simply disable the calling of GroupReinforcementsMonitor;
	DMS_SpawnFlareOnReinforcements		= true;						// Whether or not to spawn a flare and noise when AI reinforcements have spawned.
	/*General settings for static missions*/

	DMS_playerNearRadius				= 100;						// How close a player has to be to a mission in order to satisfy the "playerNear" mission requirement (can be customized per mission).

	DMS_AI_KillPercent					= 100;						// The percent amount of AI that need to be killed for "killPercent" mission requirement (NOT IMPLEMENTED)

	/*Mission Marker settings*/
	DMS_ShowDifficultyColorLegend		= true;						// Whether or not to show a "color legend" at the bottom left of the map that shows which color corresponds to which difficulty. I know it's not very pretty, meh.
	DMS_ShowMarkerCircle				= false;					// Whether or not to show the colored "circle" around a mission marker.
	DMS_MarkerText_ShowMissionPrefix	= true;						// Whether or not to place a prefix before the mission marker text. Enable this if your players get confused by the marker names :P
	DMS_MarkerText_MissionPrefix		= "Mission:";				// The text displayed before the mission name in the mission marker.
	DMS_MarkerText_ShowAICount			= true;						// Whether or not to display the number of remaining AI in the marker name.
	DMS_MarkerText_ShowAICount_Static	= true;						// Whether or not to display the number of remaining AI in the marker name for STATIC missions.
	DMS_MarkerText_AIName				= "Units";					// What the AI will be called in the map marker. For example, the marker text can show: "Car Dealer (3 Units remaining)"
	DMS_MarkerPosRandomization			= false;					// Randomize the position of the circle marker of a mission
	DMS_MarkerPosRandomRadius			= [25,100];					// Minimum/Maximum distance that the circle marker position will be randomized | DEFAULT: 0 meters to 200 meters
	DMS_RandomMarkerBrush				= "Cross";					// See: https://community.bistudio.com/wiki/setMarkerBrush
	DMS_MissionMarkerWinDot				= true;						// Keep the mission marker dot with a "win" message after mission is over
	DMS_MissionMarkerLoseDot			= true;						// Keep the mission marker dot with a "lose" message after mission is over
	DMS_MissionMarkerWinDot_Type		= "mil_end";				// The marker type to show when a mission is completed. Refer to: https://community.bistudio.com/wiki/cfgMarkers
	DMS_MissionMarkerLoseDot_Type		= "KIA";					// The marker type to show when a mission fails. Refer to: https://community.bistudio.com/wiki/cfgMarkers
	DMS_MissionMarkerWinDotTime			= 30;						// How many seconds the "win" mission dot will remain on the map
	DMS_MissionMarkerLoseDotTime		= 30;						// How many seconds the "lose" mission dot will remain on the map
	DMS_MissionMarkerWinDotColor		= "ColorBlue";				// The color of the "win" marker dot
	DMS_MissionMarkerLoseDotColor		= "ColorRed";				// The color of the "lose" marker dot
	/*Mission Marker settings*/

	/*Mission Cleanup settings*/
	DMS_CompletedMissionCleanup			= true;						// Cleanup mission-spawned buildings and AI bodies after some time
	DMS_CompletedMissionCleanupTime		= 3600;						// Minimum time until mission-spawned buildings and AI are cleaned up
	DMS_CleanUp_PlayerNearLimit			= 20;						// Cleanup of an object is aborted if a player is this many meters close to the object
	DMS_AIVehCleanUpTime				= 300;						// Time until a destroyed AI vehicle is cleaned up.
	/*Mission Cleanup settings*/

	/*Mission spawn location settings*/
	DMS_UsePredefinedMissionLocations	= false;					// Whether or not to use a list of pre-defined mission locations instead before attempting to find a random (valid) position. The positions will still be checked for validity. If none of the provided positions are valid, a random one will be generated.
	DMS_PredefinedMissionLocations = 	[							// List of Preset/Predefined mission locations.
											/* List of positions:
											position1: [x_1,y_1,z_1],
											position2: [x_2,y_2,z_2],
											...
											positionN: [x_N,y_N,z_N]
											*/

										];

	DMS_PredefinedMissionLocations_WEIGHTED = 	[					// List of Preset/Predefined mission locations WITH WEIGHTED CHANCES. This will NOT override "DMS_PredefinedMissionLocations", and everything from "DMS_PredefinedMissionLocations" will behave as though it has 1 weight per position.
											/* List of arrays with position and weighted chance:
											[[x_1,y_1,z_1], chance_1],
											[[x_2,y_2,z_2], chance_2],
											...
											[[x_N,y_N,z_N], chance_N]
											*/

										];
	DMS_ThrottleBlacklists				= true;						// Whether or not to "throttle" the blacklist distance parameters in DMS_fnc_FindSafePos. This will reduce the values of the minimum
																		//distances for some of the below parameters if several attempts have been made, but a suitable position was not yet found. This
																		//should help with server performance drops when spawning a mission, as DMS_fnc_findSafePos is the most resource-intensive function.
	DMS_AttemptsUntilThrottle			= 15;						// How many attempts until the parameters are throttled.
	DMS_ThrottleCoefficient				= 0.9;						// How much the parameters are throttled. The parameters are multiplied by the coefficient, so 0.9 means 90% of whatever the parameter was.
	DMS_MinThrottledDistance			= 500;						// The minimum distance to which it will throttle. If the throttled value is less than this value, then this value is used instead.
	DMS_PlayerNearBlacklist				= 2000;						// Missions won't spawn in a position this many meters close to a player
	DMS_SpawnZoneNearBlacklist			= 2500;						// Missions won't spawn in a position this many meters close to a spawn zone
	DMS_TraderZoneNearBlacklist			= 2500;						// Missions won't spawn in a position this many meters close to a trader zone
	DMS_MissionNearBlacklist			= 2500;						// Missions won't spawn in a position this many meters close to another mission
	DMS_WaterNearBlacklist				= 500;						// Missions won't spawn in a position this many meters close to water
	DMS_TerritoryNearBlacklist			= 100;						// Missions won't spawn in a position this many meters close to a territory flag. This is a resource intensive check, don't set this value too high!
	DMS_MixerNearBlacklist				= 1000;						// Missions won't spawn in a position this many meters close to a concrete mixer
	DMS_ContaminatedZoneNearBlacklist	= 1000;						// Missions won't spawn in a position this many meters close to a contaminated zone
	DMS_MinSurfaceNormal				= 0.9;						// Missions won't spawn in a position where its surfaceNormal is less than this amount. The lower the value, the steeper the location. Greater values means flatter locations. Values can range from 0-1, with 0 being sideways, and 1 being perfectly flat. For reference: SurfaceNormal of about 0.7 is when you are forced to walk up a surface. If you want to convert surfaceNormal to degrees, use the arc-cosine of the surfaceNormal. 0.9 is about 25 degrees. Google "(arccos 0.9) in degrees"
	DMS_MinDistFromWestBorder			= 250;						// Missions won't spawn in a position this many meters close to the western map border.
	DMS_MinDistFromEastBorder			= 250;						// Missions won't spawn in a position this many meters close to the easter map border.
	DMS_MinDistFromSouthBorder			= 250;						// Missions won't spawn in a position this many meters close to the southern map border.
	DMS_MinDistFromNorthBorder			= 250;						// Missions won't spawn in a position this many meters close to the northern map border.
	DMS_SpawnZoneMarkerTypes =			[							// If you're using custom spawn zone markers, make sure you define them here. CASE SENSITIVE!!!
											"ExileSpawnZoneIcon"
										];
	DMS_TraderZoneMarkerTypes =			[							// If you're using custom trader markers, make sure you define them here. CASE SENSITIVE!!!
											"ExileTraderZoneIcon"
										];
	DMS_MixerMarkerTypes =				[							// If you're using custom concrete mixer map markers, make sure you define them here. CASE SENSITIVE!!!
											"ExileConcreteMixerZoneIcon"
										];
	DMS_ContaminatedZoneMarkerTypes =	[							// If you're using custom contaminated zone markers, make sure you define them here. CASE SENSITIVE!!!
											"ExileContaminatedZoneIcon"
										];
	/*Mission spawn location settings*/

	DMS_MinWaterDepth					= 20;						// Minimum depth of water that an underwater mission can spawn at.

	/*Crate/Box settings*/
	DMS_HideBox							= false;					// "Hide" the box from being visible by players until the mission is completed.
	DMS_EnableBoxMoving					= true;						// Whether or not to allow the box to move and/or be lifted by choppers.
	DMS_SpawnBoxSmoke					= true;						// Spawn a smoke grenade on mission box upon misson completion during daytime
	DMS_DefaultSmokeClassname 			= "SmokeShellPurple";		// Classname of the smoke you want to spawn.
	DMS_SpawnBoxIRGrenade				= true;						// Spawn an IR grenade on mission box upon misson completion during nighttime
	/*Crate/Box settings*/

	/*Mine settings*/
	DMS_SpawnMinefieldForEveryMission	= false;					// Whether or not to spawn a minefield for every dynamic mission.
	DMS_SpawnMinesAroundMissions		= true;						// Whether or not to spawn mines around AI missions that have them.
	DMS_despawnMines_onCompletion		= true;						// Despawn mines spawned around missions when the mission is completed
	DMS_MineInfo_easy					= [5,50];					// Mine info for "easy" missions. This will spawn 5 mines within a 50m radius.
	DMS_MineInfo_moderate				= [10,50];					// Mine info for "moderate" missions. This will spawn 10 mines within a 50m radius.
	DMS_MineInfo_difficult				= [15,75];					// Mine info for "difficult" missions. This will spawn 15 mines within a 75m radius.
	DMS_MineInfo_hardcore				= [25,100];					// Mine info for "hardcore" missions. This will spawn 25 mines within a 100m radius.
	DMS_SpawnMineWarningSigns			= true;						// Whether or not to spawn mine warning signs around a minefield.
	DMS_BulletProofMines				= true;						// Whether or not you want to make the mines bulletproof. Prevents players from being able to shoot the mines and creating explosions.
	/*Mine settings*/

	DMS_MinPlayerCount					= 0; 						// Minimum number of players until mission start
	DMS_MinServerFPS					= 5; 						// Minimum server FPS for missions to start

	/*Mission notification settings*/
	DMS_PlayerNotificationTypes =		[									// Notification types. Supported values are: ["dynamicTextRequest", "standardHintRequest", "systemChatRequest", "textTilesRequest", "ExileToasts"]. Details below.
											//"dynamicTextRequest",			// You should use either "dynamicTextRequest" or "textTilesRequest", and I think "textTilesRequest" looks better, but this is less performance-intensive.
											//"standardHintRequest",		// Hints are a bit wonky...
											//"textTilesRequest",			// Keep in mind you can only have 1 "text tile" message up at a time, so the message will disappear if the player gets a kill or something while the message is shown. This message type is also performance-intensive, so I advise against it.
											//"systemChatRequest",			// Always nice to show in chat so that players can scroll up to read the info if they need to.
											"ExileToasts"					// Default notification type since Exile 0.98, see (http://www.exilemod.com/devblog/new-ingame-notifications/)
										];

		/*Exile Toasts Notification Settings*/
	DMS_ExileToasts_Title_Size			= 22;						// Size for Client Exile Toasts  mission titles.
	DMS_ExileToasts_Title_Font			= "puristaMedium";			// Font for Client Exile Toasts  mission titles.
	DMS_ExileToasts_Message_Color		= "#FFFFFF";				// Exile Toasts color for "ExileToast" client notification type.
	DMS_ExileToasts_Message_Size		= 19;						// Exile Toasts size for "ExileToast" client notification type.
	DMS_ExileToasts_Message_Font		= "PuristaLight";			// Exile Toasts font for "ExileToast" client notification type.
		/*Exile Toasts Notification Settings*/

		/*Dynamic Text Notification Settings*/
	DMS_dynamicText_Duration			= 7;						// Number of seconds that the message will last on the screen.
	DMS_dynamicText_FadeTime			= 1.5;						// Number of seconds that the message will fade in/out (does not affect duration).
	DMS_dynamicText_Title_Size			= 1.2;						// Size for Client Dynamic Text mission titles.
	DMS_dynamicText_Title_Font			= "puristaMedium";			// Font for Client Dynamic Text mission titles.
	DMS_dynamicText_Message_Color		= "#FFFFFF";				// Dynamic Text color for "dynamicTextRequest" client notification type.
	DMS_dynamicText_Message_Size		= 0.65;						// Dynamic Text size for "dynamicTextRequest" client notification type.
	DMS_dynamicText_Message_Font		= "OrbitronMedium";			// Dynamic Text font for "dynamicTextRequest" client notification type.
		/*Dynamic Text Notification Settings*/

		/*Standard Hint Notification Settings*/
	DMS_standardHint_Title_Size			= 2;						// Size for Client Standard Hint mission titles.
	DMS_standardHint_Title_Font			= "puristaMedium";			// Font for Client Standard Hint mission titles.
	DMS_standardHint_Message_Color		= "#FFFFFF";				// Standard Hint color for "standardHintRequest" client notification type.
	DMS_standardHint_Message_Size		= 1;						// Standard Hint size for "standardHintRequest" client notification type.
	DMS_standardHint_Message_Font		= "OrbitronMedium";			// Standard Hint font for "standardHintRequest" client notification type.
		/*Standard Hint Notification Settings*/

		/*Text Tiles Notification Settings*/
	DMS_textTiles_Duration				= 7;						// Number of seconds that the message will last on the screen.
	DMS_textTiles_FadeTime				= 1.5;						// Number of seconds that the message will fade in/out (does not affect duration).
	DMS_textTiles_Title_Size			= 2.3;						// Size for Client Text Tiles mission titles.
	DMS_textTiles_Title_Font			= "puristaMedium";			// Font for Client Text Tiles mission titles.
	DMS_textTiles_Message_Color			= "#FFFFFF";				// Text Tiles color for "textTilesRequest" client notification type.
	DMS_textTiles_Message_Size			= 1.25;						// Text Tiles size for "textTilesRequest" client notification type.
	DMS_textTiles_Message_Font			= "OrbitronMedium";			// Text Tiles font for "textTilesRequest" client notification type.
		/*Text Tiles Notification Settings*/

	/*Mission notification settings*/

	DMS_RandomBanditMissionsOnStart		= 0;						// Number of (random) bandit missions to spawn when the server starts, just so players don't have to wait for missions to spawn.
	DMS_BanditMissionTypes =			[			//	List of missions with spawn chances. If they add up to 100%, they represent the percentage chance each one will spawn
											["bandits",3],
											["bauhaus",3],
											["beertransport",3],
											["behindenemylines",3],
											["blackhawkdown",3],
											["cardealer",3],
											["construction",3],
											["donthasslethehoff",3],
											["foodtransport",3],
											["guntransport",3],
											["humanitarian",3],
											["lost_battalion",3],
											["medical",3],
											["mercbase",2],
											["mercenaries",3],
											["nedbuilding1_mission",3],
											["nedcar_mission",4],
											["nedguns1_mission",3],
											["nedhatchback_mission",3],
											["nedhunter_mission",2],
											["nedifrit_mission",2],
											["nedlittlebird_mission",2],
											["nedmedical1_mission",3],
											["nedoffroad_mission",3],
											["nedresearch_mission",3],
											["nedsnipercamp_mission",3],
											["nedstrider_mission",2],
											["nedural_mission",3],
											["roguenavyseals",3],
											["thieves",3],
											["walmart",3]
										];


	DMS_StaticMissionTypes =			[								// List of STATIC missions with spawn chances.
											//["saltflats",1]		//<--Example (already imported by default on Altis in map configs)
											//["slums",1]			//<--Example (already imported by default on Altis in map configs)
											//["occupation",1]		//<--Example
											//["sectorB",1]			//<--Example for Taviana
										];

	DMS_SpecialMissions =				[								// List of special missions with restrictions. Each element must be defined as [mission<STRING>, minPlayers<SCALAR>, maxPlayers<SCALAR>, timesPerRestart<SCALAR>, _timeBetween<SCALAR>].
											//["specops",15,60,2,900]	//<-- Example for a mission named "specops.sqf" that must be placed in the "special" folder. It will only spawn when there are at least 15 players, less than 60 players, it will only spawn up to twice per restart, and at least 900 seconds must pass before another instance of the mission can spawn.
										];

	DMS_BasesToImportOnServerStart = 	[								// List of static bases to import on server startup (spawned post-init). This will reduce the amount of work the server has to do when it actually spawns static missions, and players won't be surprised when a base suddenly pops up. You can also include any other M3E-exported bases to spawn here.
											//"saltflatsbase",		//<--Example (already imported by default on Altis)
											//"slums_objects"		//<--Example (already imported by default on Altis)
										];

	DMS_BanditMissionsOnServerStart =	[
											//"construction"		//<-- Example
										];

	DMS_StaticMissionsOnServerStart =	[								// List of STATIC missions with spawn chances.
											//"saltflats"			//<--Example
											//"slums"				//<--Example
											//"occupation"			//<--Example
											//"sectorB"				//<--Example for Taviana
										];



	DMS_findSafePosBlacklist =			[								// This list defines areas where missions WILL NOT spawn. For position blacklist info refer to: http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=31190
											// There are examples in the altis map config (it blacklists the salt flats) and in the tavi/taviana map configs.

											//[[2350,4680],100]		// This random example blacklists any position within 100 meters of coordinates "[2350,4680]"
										];
/* Mission System Settings */


/* AI Settings */
	DMS_AI_Classname					= "O_Soldier_unarmed_F";				// Since some of you wanted this...

	DMS_AI_NamingType					= 0;						// This specifies the "naming scheme" for the AI. 0 corresponds with the default ArmA names; 1 means you want a DMS name (eg: [DMS BANDIT SOLDIER 123]); 2 means you want to generate a name from a list of first and last names (DMS_AI_FirstNames, DMS_AI_LastNames).
	DMS_AI_FirstNames =					[							// List of "first names" that an AI can have. Only used when DMS_AI_NamingType = 2.
											"Adam",
											"Benjamin",
											"Charles",
											"David",
											"Eric"
											// etc.
										];
	DMS_AI_LastNames =					[							// List of "last names" that an AI can have. Only used when DMS_AI_NamingType = 2.
											"Smith",
											"Johnson",
											"Williams",
											"Jones",
											"Brown"
											// etc.
										];

	DMS_Show_Kill_Poptabs_Notification	= true;						// Whether or not to show the poptabs gained/lost message on the player's screen when killing an AI. (It will still change the player's money, it just won't show the "Money Received" notification)
	DMS_Show_Kill_Respect_Notification	= true;						// Whether or not to show the "Frag Message" on the player's screen when killing an AI. (It will still change the player's respect, it just won't show the "AI Killed" frag message)
	DMS_Show_Kill_Rank_Notification		= true;
	DMS_Show_Party_Kill_Notification	= true;						// Whether or not to show in chat when a party member kills an AI.

	DMS_Spawn_AI_With_Money				= true;						// Whether or not to spawn AI with money that can be looted from the body.
	DMS_AIMoney_PopulationMultiplier	= 5;						// This determines how much EXTRA money an AI will have on his body. For example, setting this to 5 and having a server population of 30 means the AI will have an extra 150 poptabs on the body. Set to 0 to disable.

	DMS_GiveMoneyToPlayer_OnAIKill		= true;						// Whether or not to give money directly to players when they kill AI (old method of giving money).
	DMS_GiveRespectToPlayer_OnAIKill	= true;						// Whether or not to give respect to players when they kill AI.

	DMS_Bandit_Soldier_MoneyGain		= 50;						// The amount of Poptabs gained for killing a bandit soldier
	DMS_Bandit_Soldier_RepGain			= 10;						// The amount of Respect gained for killing a bandit soldier
	DMS_Bandit_Soldier_RankGain			= 15;
	DMS_Bandit_Soldier_SpawnMoney		= 50;						// The amount of Poptabs carried by a bandit soldier

	DMS_Bandit_Static_MoneyGain			= 75;						// The amount of Poptabs gained for killing a bandit static gunner
	DMS_Bandit_Static_RepGain			= 15;						// The amount of Respect gained for killing a bandit static gunner
	DMS_Bandit_Static_RankGain			= 30;
	DMS_Bandit_Static_SpawnMoney		= 75;						// The amount of Poptabs carried by a bandit static gunner

	DMS_Bandit_Vehicle_MoneyGain		= 100;						// The amount of Poptabs gained for killing a bandit vehicle crew member
	DMS_Bandit_Vehicle_RepGain			= 25;						// The amount of Respect gained for killing a bandit vehicle crew member
	DMS_Bandit_Vehicle_RankGain			= 50;
	DMS_Bandit_Vehicle_SpawnMoney		= 100;						// The amount of Poptabs carried by a bandit vehicle crew member

/* DonkeyPunchDMS Custom Settings for Hero AI*/
	DMS_Hero_Soldier_MoneyGain			= 100;						// The amount of Poptabs gained for killing a hero soldier
	DMS_Hero_Soldier_RepGain			= 20;						// The amount of Respect gained for killing a hero soldier
	DMS_Hero_Soldier_RankGain			= -30;
	DMS_Hero_Soldier_SpawnMoney			= 100;						// The amount of Poptabs carried by a hero soldier

	DMS_Hero_Static_MoneyGain			= 120;						// The amount of Poptabs gained for killing a hero static gunner
	DMS_Hero_Static_RepGain				= 30;						// The amount of Respect gained for killing a hero static gunner
	DMS_Hero_Static_RankGain			= -60;
	DMS_Hero_Static_SpawnMoney			= 120;						// The amount of Poptabs carried by a hero static gunner

	DMS_Hero_Vehicle_MoneyGain			= 200;						// The amount of Poptabs gained for killing a hero vehicle crew member
	DMS_Hero_Vehicle_RepGain			= 50;						// The amount of Respect gained for killing a hero vehicle crew member
	DMS_Hero_Vehicle_RankGain			= -100;
	DMS_Hero_Vehicle_SpawnMoney			= 200;						// The amount of Poptabs carried by a hero vehicle crew member
/* DonkeyPunchDMS Custom Settings for Survivor AI*/
	DMS_Survivor_Soldier_MoneyGain		= -100;						// The amount of Poptabs gained for killing a Survivor soldier
	DMS_Survivor_Soldier_RepGain		= -100;						// The amount of Respect gained for killing a Survivor soldier
	DMS_Survivor_Soldier_RankGain		= -250;
	DMS_Survivor_Soldier_SpawnMoney		= 0;						// The amount of Poptabs carried by a Survivor soldier

	DMS_Survivor_Static_MoneyGain		= -100;						// The amount of Poptabs gained for killing a Survivor static gunner
	DMS_Survivor_Static_RepGain			= -100;						// The amount of Respect gained for killing a Survivor static gunner
	DMS_Survivor_Static_RankGain		= -400;
	DMS_Survivor_Static_SpawnMoney		= 0;						// The amount of Poptabs carried by a Survivor static gunner

	DMS_Survivor_Vehicle_MoneyGain		= -500;						// The amount of Poptabs gained for killing a Survivor vehicle crew member
	DMS_Survivor_Vehicle_RepGain		= -100;						// The amount of Respect gained for killing a Survivor vehicle crew member
	DMS_Survivor_Vehicle_RankGain		= -600;
	DMS_Survivor_Vehicle_SpawnMoney		= 0;						// The amount of Poptabs carried by a Survivor vehicle crew member

	DMS_AIKill_DistanceBonusMinDistance	= 100;						// Minimum distance from the player to the AI to apply the distance bonus.
	DMS_AIKill_DistanceBonusCoefficient	= 0.05;						// If the distance from the player to the killed unit is more than "DMS_AIKill_DistanceBonusMinDistance" meters then the player gets a respect bonus equivalent to the distance multiplied by this coefficient. For example, killing an AI from 400 meters will give 100 extra respect (when the coefficient is 0.25). Set to 0 to disable the bonus. This bonus will not be applied if there isn't a regular AI kill bonus.

	DMS_Diff_RepOrTabs_on_roadkill 		= true;						// Whether or not you want to use different values for giving respect/poptabs when you run an AI over. Default values are NEGATIVE. This means player will LOSE respect or poptabs.
	DMS_Bandit_Soldier_RoadkillMoney	= -10;						// The amount of Poptabs gained/lost for running over a bandit soldier
	DMS_Bandit_Soldier_RoadkillRep		= -5;						// The amount of Respect gained/lost for running over a bandit soldier
	DMS_Bandit_Soldier_RoadkillRank		= 20;
	DMS_Bandit_Static_RoadkillMoney		= -10;						// The amount of Poptabs gained/lost for running over a bandit static gunner
	DMS_Bandit_Static_RoadkillRep		= -5;						// The amount of Respect gained/lost for running over a bandit static gunner
	DMS_Bandit_Static_RoadkillRank		= 30;
	DMS_Bandit_Vehicle_RoadkillMoney	= -10;						// The amount of Poptabs gained/lost for running over a bandit vehicle crew member
	DMS_Bandit_Vehicle_RoadkillRep		= -5;						// The amount of Respect gained/lost for running over a bandit vehicle crew member
	DMS_Bandit_Vehicle_RoadkillRank		= 50;
/* DonkeyPunchDMS Custom RoadKill Settings for Hero AI*/
	DMS_Hero_Soldier_RoadkillMoney		= 20;						// The amount of Poptabs gained/lost for running over a hero soldier
	DMS_Hero_Soldier_RoadkillRep		= 10;						// The amount of Respect gained/lost for running over a hero soldier
	DMS_Hero_Soldier_RoadkillRank		= -40;
	DMS_Hero_Static_RoadkillMoney		= 20;						// The amount of Poptabs gained/lost for running over a hero static gunner
	DMS_Hero_Static_RoadkillRep			= 10;						// The amount of Respect gained/lost for running over a hero static gunner
	DMS_Hero_Static_RoadkillRank		= -60;
	DMS_Hero_Vehicle_RoadkillMoney		= 20;						// The amount of Poptabs gained/lost for running over a hero vehicle crew member
	DMS_Hero_Vehicle_RoadkillRep		= 10;						// The amount of Respect gained/lost for running over a hero vehicle crew member
	DMS_Hero_Vehicle_RoadkillRank		= -100;
/* DonkeyPunchDMS Custom Roadkill Settings for Survivor AI*/
	DMS_Survivor_Soldier_RoadkillMoney	= -200;						// The amount of Poptabs gained/lost for running over a Survivor soldier
	DMS_Survivor_Soldier_RoadkillRep	= -200;						// The amount of Respect gained/lost for running over a Survivor soldier
	DMS_Survivor_Soldier_RoadkillRank	= -200;
	DMS_Survivor_Static_RoadkillMoney	= -200;						// The amount of Poptabs gained/lost for running over a Survivor static gunner
	DMS_Survivor_Static_RoadkillRep		= -200;						// The amount of Respect gained/lost for running over a Survivor static gunner
	DMS_Survivor_Static_RoadkillRank	= -200;
	DMS_Survivor_Vehicle_RoadkillMoney	= -500;						// The amount of Poptabs gained/lost for running over a Survivor vehicle crew member
	DMS_Survivor_Vehicle_RoadkillRep	= -100;						// The amount of Respect gained/lost for running over a Survivor vehicle crew member
	DMS_Survivor_Vehicle_RoadkillRank	= -100;

	DMS_banditSide						= EAST;						// The side (team) that AI Bandits will spawn on
/* DonkeyPunchDMS Custom Side Factions */
	DMS_heroSide						= WEST;						// The side (team) that AI Heros will spawn on
	DMS_survivorSide					= CIV;						// The side (team) that AI Survivor will spawn on

	DMS_clear_AI_body					= false;					// Clear AI body as soon as they die
	DMS_clear_AI_body_chance			= 50;						// Percentage chance that AI bodies will be cleared when they die
	DMS_ai_disable_ramming_damage 		= true;						// Disables damage due to ramming into AI. !!!NOTE: THIS WILL NOT BE RELIABLE WITH "DMS_ai_offload_to_client"!!!
	DMS_remove_roadkill					= true; 					// Remove gear from AI bodies that are roadkilled
	DMS_remove_roadkill_chance			= 50;						// Percentage chance that roadkilled AI bodies will be deleted
	DMS_explode_onRoadkill				= true;						// Whether or not to spawn an explosion when an AI gets run over. It will likely take out the 2 front wheels. Should help mitigate the ineffective AI vs. striders issue ;)
	DMS_RemoveNVG						= false;					// Remove NVGs from AI bodies

	DMS_MaxAIDistance					= 500;						// The maximum distance an AI unit can be from a mission before he is killed. Helps with AI running away and forcing the mission to keep running. Set to 0 if you don't want it.
	DMS_AIDistanceCheckFrequency		= 60;						// How often to check within DMS_fnc_TargetsKilled whether or not the AI is out of the maximum radius. Lower values increase frequency and increase server load, greater values decrease frequency and may cause longer delays for "runaway" AI.

	DMS_ai_offload_to_client			= true;						// Offload spawned AI groups to random clients. Helps with server performance.
	DMS_ai_offload_Only_DMS_AI			= true;						// Don't set this to false unless you know what you're doing.
	DMS_ai_offload_notifyClient			= false;					// Notify the client when AI has been offloaded to the client.

	DMS_ai_allowFreezing				= true;						// Whether or not to "freeze" AI that are a certain distance away from players (and therefore inactive).
	DMS_ai_freeze_Only_DMS_AI			= false;					// Whether or not to "freeze" AI that are not spawned by DMS.
	DMS_ai_freezingDistance				= 3500;						// If there are no players within this distance of the leader of an AI group, then the AI group will be "frozen".
	DMS_ai_unfreezingDistance			= 3500;						// If there are players within this distance of the leader of an AI group, then the AI group will be "un-frozen".
	DMS_ai_offloadOnUnfreeze			= true;						// Whether or not to offload AI to clients once they have been "un-frozen". NOTE: This config will be ignored if "DMS_ai_offload_to_client" is set to false.
	DMS_ai_freezeCheckingDelay			= 15;						// How often (in seconds) DMS will check whether to freeze/un-freeze AI.
	DMS_ai_freezeOnSpawn				= true;						// Whether or not to freeze an AI group when initially spawned.

	DMS_ai_share_info					= false;					// Share info about killer
	DMS_ai_share_info_distance			= 25;						// The distance killer's info will be shared to other AI

	DMS_ai_nighttime_accessory_chance	= 75;						// Percentage chance that AI will have a flashlight or laser pointer on their guns if spawned during nighttime
	DMS_ai_enable_water_equipment		= true;						// Enable/disable overriding default weapons of an AI if it spawns on/in water

	// https://community.bistudio.com/wiki/AI_Sub-skills#general
	DMS_ai_skill_static					= [["aimingAccuracy",0.20],["aimingShake",0.70],["aimingSpeed",0.75],["spotDistance",0.70],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];	// Static AI Skills
	DMS_ai_skill_easy					= [["aimingAccuracy",0.30],["aimingShake",0.50],["aimingSpeed",0.50],["spotDistance",0.50],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.50]];	// Easy
	DMS_ai_skill_moderate				= [["aimingAccuracy",0.60],["aimingShake",0.60],["aimingSpeed",0.60],["spotDistance",0.60],["spotTime",0.60],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.60]];	// Moderate
	DMS_ai_skill_difficult				= [["aimingAccuracy",0.70],["aimingShake",0.70],["aimingSpeed",0.70],["spotDistance",0.70],["spotTime",0.80],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.70]]; 	// Difficult
	DMS_ai_skill_hardcore				= [["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Hardcore
	DMS_ai_skill_random					= ["hardcore","difficult","difficult","difficult","moderate","moderate","moderate","moderate","easy","easy"];	// Skill frequencies for "random" AI skills | Default: 10% hardcore, 30% difficult, 40% moderate, and 20% easy
	DMS_ai_skill_randomDifficult		= ["hardcore","hardcore","difficult","difficult","difficult"];	// 60% chance for "difficult", 40% chance for "hardcore" AI.
	DMS_ai_skill_randomEasy				= ["moderate","moderate","easy","easy","easy"];					// 60% chance for "easy", 40% chance for "moderate" AI.
	DMS_ai_skill_randomIntermediate		= ["difficult","difficult","moderate","moderate","moderate"];	// 60% chance for "moderate", 40% chance for "difficult" AI.
	DMS_AI_WP_Radius_easy				= 20;						// Waypoint radius for "easy" AI.
	DMS_AI_WP_Radius_moderate			= 30;						// Waypoint radius for "moderate" AI.
	DMS_AI_WP_Radius_difficult			= 50;						// Waypoint radius for "difficult" AI.
	DMS_AI_WP_Radius_hardcore			= 75;						// Waypoint radius for "hardcore" AI.
	DMS_AI_AimCoef_easy					= 0.9;						// "Custom Aim Coefficient" (weapon sway multiplier) for "easy" AI
	DMS_AI_AimCoef_moderate				= 0.65;						// "Custom Aim Coefficient" (weapon sway multiplier) for "moderate" AI
	DMS_AI_AimCoef_difficult			= 0.4;						// "Custom Aim Coefficient" (weapon sway multiplier) for "difficult" AI
	DMS_AI_AimCoef_hardcore				= 0.05;						// "Custom Aim Coefficient" (weapon sway multiplier) for "hardcore" AI
	DMS_AI_EnableStamina_easy			= true;						// Whether or not to keep the stamina system for "easy" AI.
	DMS_AI_EnableStamina_moderate		= true;						// Whether or not to keep the stamina system for "moderate" AI.
	DMS_AI_EnableStamina_difficult		= false;					// Whether or not to keep the stamina system for "difficult" AI.
	DMS_AI_EnableStamina_hardcore		= false;					// Whether or not to keep the stamina system for "hardcore" AI.
	DMS_AI_WP_Radius_base				= 5;						// Waypoint radius for AI in bases.
	DMS_AI_WP_Radius_heli				= 500;						// Waypoint radius for AI in helis.

	DMS_AI_destroyVehicleChance			= 75;						// Percent chance that an AI vehicle will be destroyed after the AI have been killed. Set to 100 for always, or 0 for never.

	DMS_AI_destroyStaticWeapon			= true;						// Whether or not to destroy static HMGs after AI death.
	DMS_AI_destroyStaticWeapon_chance	= 95;						// Percent chance that a static weapon will be destroyed (only applied if "DMS_AI_destroyStaticWeapon" is true)

	DMS_static_weapons =				[							// Static weapons for AI
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
											#ifdef GIVE_AI_APEX_WEAPONS
											"arifle_AK12_F",
											"arifle_ARX_ghex_F",
											"arifle_CTAR_blk_F",
											"arifle_SPAR_01_khk_F",
											"arifle_SPAR_03_khk_F",
											#endif
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
											"Exile_Weapon_AK107",
											"Exile_Weapon_AK107_GL",
											"Exile_Weapon_AK74_GL",
											"Exile_Weapon_AK47",
											"Exile_Weapon_AKS_Gold"
										];
	DMS_assault_pistols =				[							// Pistols for Assault Class (Set to empty array if you don't want to give them any pistols)
											"hgun_ACPC2_F",
											"hgun_Rook40_F",
											"hgun_P07_F",
											"hgun_Pistol_heavy_01_F",
											"hgun_Pistol_heavy_02_F",
											"Exile_Weapon_Colt1911",
											"Exile_Weapon_Makarov",
											"Exile_Weapon_Taurus",
											"Exile_Weapon_TaurusGold"
										];
	DMS_assault_optics =				[							// Optics for Assault Class
											#ifdef GIVE_AI_APEX_GEAR
											"optic_ERCO_khk_F",
											"optic_Holosight_blk_F",
											#endif
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
	DMS_assault_RandItemCount =			2;							// How many random items to add to the AI's inventory.
	DMS_assault_RandItems =				[							// The random items that will be added to the AI's inventory.
											"Exile_Item_Catfood_Cooked",
											"Exile_Item_Surstromming_Cooked",
											"Exile_Item_PowerDrink",
											"Exile_Item_EnergyDrink",
											"Exile_Item_Vishpirin",
											"Exile_Item_Bandage"
										];
	DMS_assault_helmets	=				[							// Helmets for Assault Class
											#ifdef GIVE_AI_APEX_GEAR
											"H_HelmetB_TI_tna_F",
											"H_HelmetB_Enh_tna_F",
											"H_HelmetSpecO_ghex_F",
											"H_HelmetCrew_O_ghex_F",
											#endif
											"H_HelmetSpecB_paint1",
											"H_HelmetIA_camo",
											"H_HelmetLeaderO_ocamo",
											"H_HelmetLeaderO_oucamo"
										];
	DMS_assault_clothes	=				[							// Uniforms for Assault Class
											#ifdef GIVE_AI_APEX_GEAR
											"U_B_T_Soldier_F",
											"U_B_T_Soldier_SL_F",
											"U_B_CTRG_Soldier_F",
											"U_O_V_Soldier_Viper_F",
											"U_I_C_Soldier_Bandit_2_F",
											"U_I_C_Soldier_Camo_F",
											"U_B_CTRG_Soldier_urb_1_F",
											#endif
											"U_O_CombatUniform_ocamo",
											"U_O_PilotCoveralls",
											//"U_B_Wetsuit",
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
											#ifdef GIVE_AI_APEX_GEAR
											"V_TacChestrig_grn_F",
											"V_PlateCarrier2_tna_F",
											"V_PlateCarrierSpec_tna_F",
											"V_PlateCarrierGL_tna_F",
											"V_TacVest_gen_F",
											"V_PlateCarrier1_rgr_noflag_F",
											#endif
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
											#ifdef GIVE_AI_APEX_GEAR
											"B_Bergen_tna_F",
											"B_FieldPack_ghex_F",
											"B_ViperLightHarness_khk_F",
											#endif
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
											#ifdef GIVE_AI_MARKSMAN_DLC_WEAPONS
											"MMG_01_hex_F",
											"MMG_02_black_F",
											#endif

											#ifdef GIVE_AI_APEX_WEAPONS
											"LMG_03_F",
											#endif
											"LMG_Zafir_F",
											"LMG_Mk200_F",
											"arifle_MX_SW_Black_F",
											"Exile_Weapon_RPK",
											"Exile_Weapon_PKP"
										];
	DMS_MG_pistols =				[							// Pistols for Assault Class (Set to empty array if you don't want to give them any pistols)
											"hgun_ACPC2_F",
											"hgun_Rook40_F",
											"hgun_P07_F",
											"hgun_Pistol_heavy_01_F",
											"hgun_Pistol_heavy_02_F",
											"Exile_Weapon_Colt1911",
											"Exile_Weapon_Makarov",
											"Exile_Weapon_Taurus",
											"Exile_Weapon_TaurusGold"
										];
	DMS_MG_optics =						[							//	Optics for MG Class
											#ifdef GIVE_AI_APEX_GEAR
											"optic_ERCO_khk_F",
											"optic_DMS_ghex_F",
											"optic_Arco_blk_F",
											#endif
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
	DMS_MG_RandItemCount =				3;							// How many random items to add to the AI's inventory.
	DMS_MG_RandItems =					[							// The random items that will be added to the AI's inventory.
											"Exile_Item_EMRE",
											"Exile_Item_Surstromming_Cooked",
											"Exile_Item_PowerDrink",
											"Exile_Item_PlasticBottleCoffee",
											"Exile_Item_Vishpirin",
											"Exile_Item_Instadoc"
										];
	DMS_MG_helmets =					[							// Helmets for MG Class
											#ifdef GIVE_AI_APEX_GEAR
											"H_HelmetB_TI_tna_F",
											"H_HelmetB_Enh_tna_F",
											"H_HelmetSpecO_ghex_F",
											"H_HelmetLeaderO_ghex_F",
											"H_HelmetCrew_O_ghex_F",
											#endif
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
											#ifdef GIVE_AI_APEX_GEAR
											"U_B_T_Soldier_F",
											"U_B_T_Soldier_SL_F",
											"U_B_CTRG_Soldier_F",
											"U_O_V_Soldier_Viper_F",
											"U_I_C_Soldier_Bandit_2_F",
											"U_I_C_Soldier_Camo_F",
											"U_B_CTRG_Soldier_urb_1_F",
											#endif
											"U_O_CombatUniform_ocamo",
											"U_O_PilotCoveralls",
											//"U_B_Wetsuit",
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
											#ifdef GIVE_AI_APEX_GEAR
											"V_TacChestrig_grn_F",
											"V_PlateCarrier2_tna_F",
											"V_PlateCarrierSpec_tna_F",
											"V_PlateCarrierGL_tna_F",
											"V_TacVest_gen_F",
											"V_PlateCarrier1_rgr_noflag_F",
											#endif
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
											#ifdef GIVE_AI_APEX_GEAR
											"B_Bergen_tna_F",
											"B_Carryall_ghex_F",
											"B_ViperHarness_ghex_F",
											"B_ViperLightHarness_ghex_F",
											#endif
											"B_Bergen_rgr",
											"B_Carryall_oli",
											"B_Kitbag_mcamo",
											"B_Carryall_cbr",
											"B_Bergen_blk"
										];

	//Sniper Class
	DMS_sniper_weps =					[							// Sniper Rifles
											"srifle_EBR_F",
											"srifle_GM6_F",
											"srifle_LRR_F",
											"arifle_MXM_Black_F",
											"srifle_DMR_01_F",
											#ifdef GIVE_AI_MARKSMAN_DLC_WEAPONS
											"srifle_DMR_02_F",
											"srifle_DMR_03_woodland_F",
											//"srifle_DMR_04_F",			// Does anybody like the ASP-1? :p
											"srifle_DMR_05_blk_F",
											"srifle_DMR_06_olive_F",
											#endif

											#ifdef GIVE_AI_APEX_WEAPONS
											"srifle_DMR_07_ghex_F",
											#endif
											"Exile_Weapon_DMR",
											"Exile_Weapon_SVD",
											"Exile_Weapon_VSSVintorez"
										];
	DMS_sniper_pistols =				[							// Pistols for Assault Class (Set to empty array if you don't want to give them any pistols)
											#ifdef GIVE_AI_APEX_WEAPONS
											"hgun_Pistol_01_F",
											#endif
											"hgun_ACPC2_F",
											"hgun_Rook40_F",
											"hgun_P07_F",
											"hgun_Pistol_heavy_01_F",
											"hgun_Pistol_heavy_02_F",
											"Exile_Weapon_Colt1911",
											"Exile_Weapon_Makarov",
											"Exile_Weapon_Taurus",
											"Exile_Weapon_TaurusGold"
										];
	DMS_sniper_optics =					[							// Optics for Sniper Class
											#ifdef GIVE_AI_APEX_GEAR
											"optic_SOS_khk_F",
											"optic_DMS_ghex_F",
											"optic_LRPS_tna_F",
											#endif

											#ifdef GIVE_AI_MARKSMAN_DLC_WEAPONS
											"optic_AMS_khk",
											#endif
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
	DMS_sniper_RandItemCount =			3;							// How many random items to add to the AI's inventory.
	DMS_sniper_RandItems =				[							// The random items that will be added to the AI's inventory.
											"Exile_Item_EMRE",
											"Exile_Item_PlasticBottleCoffee",
											"Exile_Item_CanOpener",
											"Exile_Item_Instadoc",
											"Exile_Item_DuctTape"
										];
	DMS_sniper_helmets =				[							// Helmets for Sniper Class
											#ifdef GIVE_AI_APEX_GEAR
											//"H_HelmetO_ViperSP_ghex_F",			// Special helmet with in-built NVGs and thermal :o
											"H_HelmetB_Enh_tna_F",
											"H_HelmetSpecO_ghex_F",
											"H_HelmetLeaderO_ghex_F",
											#endif
											"H_HelmetSpecB_paint1",
											"H_HelmetIA_camo",
											"H_HelmetLeaderO_ocamo",
											"H_HelmetLeaderO_oucamo"
										];
	DMS_sniper_clothes =				[							// Uniforms for Sniper Class
											#ifdef GIVE_AI_APEX_GEAR
											"U_B_T_Sniper_F",
											"U_B_T_FullGhillie_tna_F",				// Invisible to thermal? 0_o
											"U_O_T_Sniper_F",
											"U_O_T_FullGhillie_tna_F",
											#endif
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
											#ifdef GIVE_AI_APEX_GEAR
											"V_PlateCarrier2_tna_F",
											"V_PlateCarrierSpec_tna_F",
											"V_PlateCarrierGL_tna_F",
											"V_PlateCarrier2_rgr_noflag_F",
											#endif
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
											#ifdef GIVE_AI_APEX_GEAR
											"B_Bergen_tna_F",
											"B_Bergen_hex_F",
											"B_Carryall_ghex_F",
											"B_ViperHarness_ghex_F",
											"B_ViperHarness_blk_F",
											"B_ViperLightHarness_ghex_F",
											"B_ViperLightHarness_khk_F",
											#endif
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

	DMS_ai_SupportedRandomClasses = 	[							// Allowed "random" AI presets here if you want to create different random presets.
											"random",
											"random_non_assault",
											"random_non_MG",
											"random_non_sniper"
										];

	DMS_random_AI =						[							// Random AI preset that contains all default classes | DEFAULT: 60% Assault, 20% MG, 20% Sniper
											"assault",
											"assault",
											"assault",
											"MG",
											"sniper"
										];

	DMS_random_non_assault_AI =			[							// Random AI preset that excludes the "assault" class
											"MG",
											"MG",
											"sniper"
										];

	DMS_random_non_MG_AI =				[							// Random AI preset that excludes the "MG" class
											"assault",
											"assault",
											"sniper"
										];

	DMS_random_non_sniper_AI =			[							// Random AI preset that excludes the "sniper" class
											"assault",
											"assault",
											"MG"
										];

	DMS_ai_use_launchers				= true;						// Enable/disable spawning an AI in a group with a launcher
	DMS_ai_launchers_per_group			= 2;						// How many units per AI group can get a launcher.
	DMS_ai_use_launchers_chance			= 50;						// Percentage chance to actually spawn the launcher (per-unit). With "DMS_ai_launchers_per_group" set to 2, and "DMS_ai_use_launchers_chance" set to 50, there will be an average of 1 launcher per group.
	DMS_AI_launcher_ammo_count			= 2;						// How many rockets an AI will get with its launcher
	DMS_ai_remove_launchers				= true;						// Remove rocket launchers on AI death

	DMS_AI_wep_launchers_AT =			[							// AT Launchers
											#ifdef GIVE_AI_APEX_WEAPONS
											"launch_RPG7_F",
											#endif
											"launch_NLAW_F",
											"launch_RPG32_F",
											"launch_B_Titan_short_F"
										];
	DMS_AI_wep_launchers_AA =			[							// AA Launchers
											"launch_B_Titan_F"
										];

	DMS_RHeli_Height					= 500;						// Altitude of the heli when flying to drop point.
	DMS_RHeli_MinDistFromDrop			= 500;						// Minimum distance for the reinforcement heli to spawn from drop point.
	DMS_RHeli_MaxDistFromDrop			= 5000;						// Maximum distance for the reinforcement heli to spawn from drop point.
	DMS_RHeli_MinDistFromPlayers		= 1000;						// Minimum distance for the reinforcement heli to spawn from players.

/* AI Settings */


/* Loot Settings */
	DMS_GodmodeCrates 					= true;						// Whether or not crates will have godmode after being filled with loot.
	DMS_MinimumMagCount					= 3;						// Minimum number of magazines for weapons.
	DMS_MaximumMagCount					= 5;						// Maximum number of magazines for weapons.
	DMS_CrateCase_Sniper =				[							// If you pass "Sniper" in _lootValues, then it will spawn these weapons/items/backpacks
											[
												["Rangefinder",1],
												["srifle_GM6_F",1],
												["srifle_LRR_F",1],
												["srifle_EBR_F",1],
												["hgun_Pistol_heavy_01_F",1],
												["hgun_PDW2000_F",1]
											],
											[
												["ItemGPS",1],
												["U_B_FullGhillie_ard",1],
												["U_I_FullGhillie_lsh",1],
												["U_O_FullGhillie_sard",1],
												["U_O_GhillieSuit",1],
												["V_PlateCarrierGL_blk",1],
												["V_HarnessO_brn",1],
												["Exile_Item_InstaDoc",3],
												["Exile_Item_Surstromming_Cooked",5],
												["Exile_Item_PlasticBottleFreshWater",5],
												["optic_DMS",1],
												["acc_pointer_IR",1],
												["muzzle_snds_B",1],
												["optic_LRPS",1],
												["optic_MRD",1],
												["muzzle_snds_acp",1],
												["optic_Holosight_smg",1],
												["muzzle_snds_L",1],
												["5Rnd_127x108_APDS_Mag",3],
												["7Rnd_408_Mag",3],
												["20Rnd_762x51_Mag",5],
												["11Rnd_45ACP_Mag",3],
												["30Rnd_9x21_Mag",3]
											],
											[
												["B_Carryall_cbr",1],
												["B_Kitbag_mcamo",1]
											]
										];
	DMS_BoxWeapons =					[							// List of weapons that can spawn in a crate
											#ifdef USE_MARKSMAN_DLC_WEAPONS_IN_CRATES
											"srifle_DMR_02_F",
											"srifle_DMR_03_woodland_F",
											//"srifle_DMR_04_F",			// ASP-1 Kir
											"srifle_DMR_05_blk_F",
											"srifle_DMR_06_olive_F",
											"MMG_01_hex_F",
											"MMG_02_black_F",
											#endif

											#ifdef USE_APEX_WEAPONS_IN_CRATES
											"arifle_AK12_F",
											"arifle_ARX_ghex_F",
											"arifle_CTAR_blk_F",
											"arifle_SPAR_01_khk_F",
											"arifle_SPAR_03_khk_F",
											//"srifle_DMR_07_ghex_F",				// Oh great, a 6.5mm 20 round sniper rifle... because everybody wanted a nerfed MXM :p
											"LMG_03_F",
											#endif
											"Exile_Melee_Axe",
											"Exile_Melee_SledgeHammer",
											//"Exile_Melee_Shovel",					// Not really interesting for players...
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
											"Exile_Weapon_AK107",
											"Exile_Weapon_AK107_GL",
											"Exile_Weapon_AK74_GL",
											"Exile_Weapon_AK47",
											"Exile_Weapon_AKS_Gold",
											"LMG_Zafir_F",
											"LMG_Mk200_F",
											"arifle_MX_SW_Black_F",
											"Exile_Weapon_RPK",
											"Exile_Weapon_PK",
											"Exile_Weapon_PKP",
											"srifle_EBR_F",
											"srifle_DMR_01_F",
											"srifle_GM6_F",
											"srifle_LRR_F",
											"arifle_MXM_Black_F",
											"Exile_Weapon_DMR",
											"Exile_Weapon_SVD",
											"Exile_Weapon_VSSVintorez",
											"Exile_Weapon_CZ550",
											"Exile_Weapon_SVDCamo"
										];
	DMS_BoxFood =						[							// List of food that can spawn in a crate.
											"Exile_Item_GloriousKnakworst_Cooked",
											"Exile_Item_Surstromming_Cooked",
											"Exile_Item_SausageGravy_Cooked",
											"Exile_Item_ChristmasTinner_Cooked",
											"Exile_Item_BBQSandwich_Cooked",
											"Exile_Item_Catfood_Cooked",
											"Exile_Item_DogFood_Cooked",
											"Exile_Item_EMRE",
											"Exile_Item_BeefParts",
											"Exile_Item_Noodles",
											"Exile_Item_SeedAstics",
											"Exile_Item_Raisins",
											"Exile_Item_Moobar",
											"Exile_Item_InstantCoffee"
										];
	DMS_BoxDrinks =						[
											"Exile_Item_PlasticBottleCoffee",
											"Exile_Item_PowerDrink",
											"Exile_Item_PlasticBottleFreshWater",
											"Exile_Item_EnergyDrink",
											"Exile_Item_MountainDupe",
											"Exile_Item_ChocolateMilk"
										];
	DMS_BoxMeds =						[
											"Exile_Item_InstaDoc",
											"Exile_Item_Vishpirin",
											"Exile_Item_Bandage"
										];
	DMS_BoxSurvivalSupplies	=			[							//List of survival supplies (food/drink/meds) that can spawn in a crate. "DMS_BoxFood", "DMS_BoxDrinks", and "DMS_BoxMeds" is automatically added to this list.
											"Exile_Item_Matches",
											"Exile_Item_CookingPot",
											"Exile_Melee_Axe",
											"Exile_Item_CanOpener"
										] + DMS_BoxFood + DMS_BoxDrinks + DMS_BoxMeds;
	DMS_Box_BaseParts_Wood =			[							// List of wooden base parts.
											"Exile_Item_WoodWallKit",
											"Exile_Item_WoodWallHalfKit",
											"Exile_Item_WoodWindowKit",
											"Exile_Item_WoodDoorKit",
											"Exile_Item_WoodDoorwayKit",
											"Exile_Item_WoodGateKit",
											"Exile_Item_WoodFloorKit",
											"Exile_Item_WoodFloorPortKit",
											"Exile_Item_WoodStairsKit"
										];
	DMS_Box_BaseParts_Concrete =		[							// List of concrete base parts
											"Exile_Item_ConcreteWallKit",
											"Exile_Item_ConcreteWindowKit",
											"Exile_Item_ConcreteDoorKit",
											"Exile_Item_ConcreteDoorwayKit",
											"Exile_Item_ConcreteGateKit",
											"Exile_Item_ConcreteFloorKit",
											"Exile_Item_ConcreteFloorPortKit",
											"Exile_Item_ConcreteStairsKit"
										];
	DMS_BoxBaseParts =					[							// List of all base parts to spawn. Weighted towards wood base parts.
											"Exile_Item_FortificationUpgrade",
											"Exile_Item_FortificationUpgrade",
											"Exile_Item_SandBagsKit_Long",
											"Exile_Item_SandBagsKit_Long",
											"Exile_Item_SandBagsKit_Corner",
											"Exile_Item_SandBagsKit_Corner",
											"Exile_Item_HBarrier5Kit"
										] + DMS_Box_BaseParts_Wood + DMS_Box_BaseParts_Wood + DMS_Box_BaseParts_Wood + DMS_Box_BaseParts_Concrete;
	DMS_BoxCraftingMaterials =			[
											"Exile_Item_Cement",
											"Exile_Item_Sand",
											"Exile_Item_Sand",
											"Exile_Item_WaterCanisterDirtyWater",
											"Exile_Item_MetalBoard",
											"Exile_Item_MetalPole",
											"Exile_Item_MetalPole",
											"Exile_Item_JunkMetal",
											"Exile_Item_JunkMetal",
											"Exile_Item_JunkMetal",
											"Exile_Item_WoodPlank",
											"Exile_Item_WoodPlank",
											"Exile_Item_WoodPlank",
											"Exile_Item_WoodPlank"
										];
	DMS_BoxTools =						[
											"Exile_Item_Grinder",
											"Exile_Item_Handsaw",
											"Exile_Item_CanOpener",
											"Exile_Item_Pliers",
											"Exile_Item_Screwdriver",
											"Exile_Item_Foolbox"
										];
	DMS_BoxBuildingSupplies	=			[							// List of building supplies that can spawn in a crate ("DMS_BoxBaseParts", "DMS_BoxCraftingMaterials", and "DMS_BoxTools" are automatically added to this list. "DMS_BoxCraftingMaterials" is added twice for weight.)
											"Exile_Item_DuctTape",
											"Exile_Item_PortableGeneratorKit"
										] + DMS_BoxBaseParts + DMS_BoxCraftingMaterials + DMS_BoxCraftingMaterials + DMS_BoxTools;
	DMS_BoxOptics =						[							// List of optics that can spawn in a crate
											"optic_Arco",
											"optic_Hamr",
											"optic_Aco",
											"optic_Holosight",
											"optic_MRCO",
											"optic_SOS",
											"optic_DMS",
											"optic_LRPS",
											"optic_Nightstalker"			// Nightstalker scope lost thermal in Exile v0.9.4
										];
	DMS_BoxBackpacks =					[							//List of backpacks that can spawn in a crate
											"B_Bergen_rgr",
											"B_Carryall_oli",
											"B_Kitbag_mcamo",
											"B_Carryall_cbr",
											"B_FieldPack_oucamo",
											"B_FieldPack_cbr",
											"B_Bergen_blk"
										];
	DMS_BoxItems						= DMS_BoxSurvivalSupplies+DMS_BoxBuildingSupplies+DMS_BoxOptics;	// Random "items" can spawn optics, survival supplies, or building supplies

	DMS_Box_BreachingCharges =			[							// List of breaching charges (weighted). Not used (yet).
											"BreachingChargeBigMomma",
											"BreachingChargeMetal",
											"BreachingChargeMetal",
											"BreachingChargeWood",
											"BreachingChargeWood",
											"BreachingChargeWood"
										];

	DMS_RareLoot						= true;						// Potential chance to spawn rare loot in any crate.
	DMS_RareLootAmount					= 1;						// How many rare loot items to add.
	DMS_RareLootList =					[							// List of rare loot to spawn
											"Exile_Item_SafeKit",
											"Exile_Item_CodeLock"
										];
	DMS_RareLootChance					= 10;						// Percentage Chance to spawn rare loot in any crate | Default: 10%

	// Vehicles
	DMS_ArmedVehicles =					[							// List of armed vehicles that can spawn
											#ifdef USE_APEX_VEHICLES
											"B_T_LSV_01_armed_F",
											"O_T_LSV_02_armed_F",
											#endif
											"Exile_Car_Offroad_Armed_Guerilla01"
										];

	DMS_MilitaryVehicles =				[							// List of (unarmed) military vehicles that can spawn
											#ifdef USE_APEX_VEHICLES
											"B_T_LSV_01_unarmed_F",
											"O_T_LSV_02_unarmed_F",
											#endif
											"Exile_Car_Strider",
											"Exile_Car_Hunter",
											"Exile_Car_Ifrit"
										];

	DMS_TransportTrucks =				[							// List of transport trucks that can spawn
											"Exile_Car_Van_Guerilla01",
											"Exile_Car_Zamak",
											"Exile_Car_Tempest",
											"Exile_Car_HEMMT",
											"Exile_Car_Ural_Open_Military",
											"Exile_Car_Ural_Covered_Military"
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
											#ifdef USE_APEX_VEHICLES
											"C_Offroad_02_unarmed_F",
											"I_C_Van_01_transport_F",
											#endif
											"Exile_Car_SUV_Red",
											"Exile_Car_Hatchback_Rusty1",
											"Exile_Car_Hatchback_Rusty2",
											"Exile_Car_Hatchback_Sport_Red",
											"Exile_Car_SUV_Red",
											"Exile_Car_Offroad_Rusty2",
											"Exile_Bike_QuadBike_Fia"
										];

	DMS_TransportHelis =				[							// List of transport helis that can spawn
											#ifdef USE_APEX_VEHICLES
											"B_T_VTOL_01_infantry_F",
											"O_T_VTOL_02_infantry_F",
											#endif
											"Exile_Chopper_Hummingbird_Green",
											"Exile_Chopper_Orca_BlackCustom",
											"Exile_Chopper_Mohawk_FIA",
											"Exile_Chopper_Huron_Black",
											"Exile_Chopper_Hellcat_Green",
											"Exile_Chopper_Taru_Transport_Black"
										];

	DMS_ReinforcementHelis =			[							// List of helis that can spawn for AI paratrooper reinforcements.
											//"B_Heli_Transport_01_camo_F"		// Ghosthawk: You'll have to whitelist this in infistar if you want to use it.
										] + DMS_TransportHelis;

	DMS_CarThievesVehicles =			[							// List of vehicles that can spawn in the "car thieves" mission. By default, it's just "DMS_MilitaryVehicles" and "DMS_TransportTrucks".
											//"Exile_Car_Offroad_Armed_Guerilla01"
										] + DMS_MilitaryVehicles + DMS_TransportTrucks;
/* Loot Settings */


DMS_ConfigLoaded = true;
