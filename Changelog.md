# DMS Changelog




### Main Branch
### July 11, 2016 (5:20 PM CST-America):
* **NEW CONFIG VALUE**

		DMS_ShowMarkerCircle
* DMS now uses the new marker icons added in Exile v1.0.0


### July 9, 2016 (8:40 PM CST-America):
* **NEW CONFIG VALUES**

		DMS_MixerNearBlacklist
		DMS_ContaminatedZoneNearBlacklist
		DMS_MixerMarkerTypes
		DMS_ContaminatedZoneMarkerTypes
* Pastebin for new config values: http://pastebin.com/QeNWRXgv
* Increased "DMS_MinThrottledDistance" (from 100m to 500m).
* Removed the Shovel from crate loot.
* Edited "DMS_SpawnZoneMarkerTypes" and "DMS_TraderZoneMarkerTypes" to look for the corresponding "Icons" instead of the "circle" marker type, since some people like to remove the circle.
* You can now define a minimum distance from "Contaminated Zones" and "Concrete Mixers" for (dynamic) missions.
* "DMS_ai_freezeOnSpawn" will be set to false if "DMS_ai_allowFreezing" is disabled.
* Fixed an issue where a vehicle wouldn't unlock when the crew was killed (locality issues).
* Slight optimization(s) (thanks for the tip infiSTAR).

### July 5, 2016 (8:15 PM CST-America):
* Fixed a typo in the "SpawnAIGroup" functions from the previous update

### July 5, 2016 (7:15 PM CST-America):
* Fixed a typo in the config (the second ```DMS_Survivor_Vehicle_MoneyGain``` should be ```DMS_Survivor_Vehicle_SpawnMoney```).
* Added Apex weapons, equipment, and vehicles to config (disabled by default).
* Reduced ```DMS_ai_share_info_distance``` default value drastically, from 300 meters to 25 (it was overpowered and unrealistic).
* "Armed Bandits" mission will select a random vehicle from "DMS_ArmedVehicles" instead of the armed offroad every time.
* Fixed a typo in the "nedbuilding1_mission".
* "DMS_fnc_AddWeapon" now uses "DMS_fnc_selectMagazine" to select a magazine instead of looking in the weapon config directly (the "DMS_fnc_selectMagazine" function does that).
* Reduced the "reveal amount" for both suppressed and non-suppressed weapons when "DMS_ai_share_info" is enabled.
* The "SpawnAIGroup" functions will now use "DMS_fnc_addWeapon" instead of the BIS variant to add launchers.
* Slight tweaks of function/mission comments and error logs.

### July 3, 2016 (8:15 PM CST-America):
* Player money will be saved on kill.

### July 3, 2016 (1:40 AM CST-America):
* Updated AI weapons to include new exile weapons.
* Updated box loot with latest food, drink, crafting materials, and building supplies.
* Added [red_ned's mission pack](http://www.exilemod.com/topic/12072-update31-dms-bandit-missions-either-new-or-reworked/).
* New underwater mission for Tanoa! Go ahead and try it out, give me any suggestions/tips/bug reports (OTHER THAN THE AI SWIMMING THROUGH ROCKS).
* Added support for custom gear sets in group reinforcments.
* Slight optimizations here and there.
* Static missions will now spawn unscheduled if configured to do so even after a delay has been applied (from a player being too close).

#### June 30, 2016 (2:30 AM CST-America):
* DMS will now update player respect in the database when a player kills an AI (and respect is awarded to the player).
* Optimizations related to "DMS_ai_share_info" (also, using a suppressor against AI might be better ;) )

#### June 29, 2016 (6:00 PM CST-America):
* Fixed a few issues (script errors, missions not broadcasting, group kill notifications not broadcasting).

#### June 29, 2016 (4:00 PM CST-America):
* **NEW CONFIG VALUES**

		DMS_ExileToasts_Title_Size
		DMS_ExileToasts_Title_Font
		DMS_ExileToasts_Message_Color
		DMS_ExileToasts_Message_Size
		DMS_ExileToasts_Message_Font
		DMS_Spawn_AI_With_Money
		DMS_AIMoney_PopulationMultiplier
		DMS_GiveMoneyToPlayer_OnAIKill
		DMS_GiveRespectToPlayer_OnAIKill
		DMS_Bandit_Soldier_SpawnMoney
		DMS_Bandit_Static_SpawnMoney
		DMS_Bandit_Vehicle_SpawnMoney
		DMS_Hero_Soldier_SpawnMoney
		DMS_Hero_Static_SpawnMoney
		DMS_Hero_Vehicle_SpawnMoney
		DMS_Survivor_Soldier_SpawnMoney
		DMS_Survivor_Static_SpawnMoney
		DMS_Survivor_Vehicle_MoneyGain
* Pastebin of new config values: http://pastebin.com/eXw93CkD
* **It is also recommended to update "DMS_PlayerNotificationTypes"!!!**
* Added support for new Exile "Toasts" notification. This is now the default (and only) DMS notification type.
* Complete overhaul and update of "DMS_fnc_PlayerAwardOnAIKill", it is now more efficient and updated to new Exile standards.

#### June 27, 2016 (7:00 PM CST-America):
* DMS should now properly detect VEMF markers (it wasn't working before because of a minor typo).
* DMS will now detect (and avoid) ZCP missions if you're updated to the latest version of ZCP on the test branch.
* Fixed an issue where distance wasn't shown in kill messages to group members. Thanks to Stoll on the forums for pointing that out.
* DMS will no longer update player money and respect when an AI is killed. It isn't really necessary.
* Updated function headers for functions that now have a wiki entry, as well as some clarification and cleanup.


#### June 25, 2016 (5:00 PM CST-America):
* Updated almost all map configs in regards to "DMS_findSafePosBlacklist"; they should no longer overwrite main config settings.
* Optimized "fn_isValidPosition" with the "new" throw functionality (forgot to do it earlier lol).

#### June 24, 2016 (6:00 PM CST-America):
* **NEW CONFIG VALUES**

		DMS_AI_UseRealNames
		DMS_ai_allowFreezing
		DMS_ai_freeze_Only_DMS_AI
		DMS_ai_freezingDistance
		DMS_ai_unfreezingDistance
		DMS_ai_offloadOnUnfreeze
		DMS_ai_freezeCheckingDelay
		DMS_ai_freezeOnSpawn
		DMS_assault_RandItemCount
		DMS_assault_RandItems
		DMS_MG_RandItemCount
		DMS_MG_RandItems
		DMS_sniper_RandItemCount
		DMS_sniper_RandItems
* http://pastebin.com/bSk3bNrX <-- List of config values with default values and explanations. You can paste this directly into your config.sqf for easier updating
* Removed config value "DMS_MissionMarkerCount"
* New functions: DMS_fnc_ImportFromM3E_3DEN, DMS_fnc_ImportFromM3E_3DEN_Convert, DMS_fnc_ImportFromM3E_3DEN_Static, DMS_fnc_AddWeapon, DMS_fnc_FreezeManager, DMS_fnc_FreezeToggle, DMS_fnc_GetCenter, DMS_fnc_IsPosBlacklisted, DMS_fnc_SetRelPositions, DMS_fnc_SubArr.
* Lots and lots of optimizations
* Various fixes
* Renamed the "mercbase.sqf" mission title to "Mercenary Outpost" to avoid confusion with the salt flats mission.
* DMS will now log the DMS version to the client RPT on login.
* Config value "DMS_findSafePosBlacklist" now supports the ability to blacklist within a certain distance of a given position.
* Notifications from "textTilesRequest" and "dynamicTextRequest" should no longer "stack" on each other; if two missions spawn right after another, the second mission notification will be delayed at least until the first one completes.
* Removed the marker color check in "DMS_fnc_CreateMarker". Invalid marker colors are up to server owners to detect.
* "DMS_CLIENT" functions are now compiled in pre-init (broadcasting is still done in post-init).
* Functions that were previously defined in preinit with regular code brackets ("GetCenter", "SetRelPositions", and "SubArr") are now defined as DMS functions (instead of M3E functions before) and have their own files.
* "M3E" functions are still defined in DMS pre-init for compatibility with external code.
* You can now allow a set of random inventory items that are given to AI. Amount and item types can be set per-class.
* "DMS_StaticMissionsOnServerStart" will only be used if "DMS_StaticMission" is set to true. In other words, no static missions will be spawned on server start if you don't use static missions.
* DMS will now issue an error if you set "DMS_Use_Map_Config" for map without a config. Hopefully this resolves an issue where the server wouldn't start if you tried to load a map config from a file that didn't exist.
* Adjusted map config for chernarus: Missions should no longer spawn near map borders.
* Micro-optimizations for almost all DMS functions (using the new functionality of "private", which is faster than the previous). Also, some variables that weren't previously defined as private are now fixed.
* Removed legacy HC (headless client) support from "DMS_fnc_AILocalityManager".
* Major optimizations for DMS_fnc_FindSafePos
* Removed the useless ```_waterSpawn``` parameter from "FindSafePos" and "IsValidPosition". DMS is currently only used on land, a dedicated function for finding valid water spawns will come if/when needed.
* All of the "Import" functions now check for invalid exports.
* When using a "custom gear set", magazines and items are added about 0.5 seconds after the AI is spawned in order to account for an issue where the backpack isn't used (because it isn't added fast enough?). (Thanks to [second_coming](http://www.exilemod.com/profile/60-second_coming/) for the report)
* Removed a "Land_Wreck_Heli_Attack_01_F" from saltflats (it creates server threads)
* Adjusted logic in "AILocalityManager": the variable "DMS_LockLocality" on a group should now be considered even if "DMS_ai_offload_Only_DMS_AI" is set to false.
* You can now "freeze"/"un-freeze" AI! This has been a long-awaited feature for DMS. Using it will grant major performance benefits when you have lots of AI around the map that are inactive.
* "DMS_fnc_FindSuppressor" has been overhauled; it simply checks the configs for the provided weapon classname to return a random muzzle/suppressor classname. Consequently, the function is smaller, faster, and perfectly compatible with any weapon.


#### April 27, 2016 (6:45 PM CST-America):
* **NEW CONFIG VALUES**

		DMS_SpawnMissions_Scheduled
		DMS_AI_WP_Radius_heli
		DMS_AI_WP_Radius_heli
		DMS_RHeli_Height
		DMS_RHeli_MinDistFromDrop
		DMS_RHeli_MaxDistFromDrop
		DMS_RHeli_MinDistFromPlayers
		DMS_RareLootAmount
		DMS_ReinforcementHelis
* Several optimizations (mostly due to the new scripting commands introduced in 1.56)
* You can now spawn missions in scheduled environment.
* DMS Version is set in the "config.cpp", and grabbed in pre-init.
* You can now define how much rare loot to spawn.
* Limit # of attempts in "DMS_fnc_FindSafePos" to 5000.
* New function: DMS_fnc_FindSafePos_InRange; Uses "DMS_fnc_FindSafePos" and edits some variables to return a "safe" position within a certain area.
* New function: DMS_fnc_GetEmptySeats; Returns all empty seats in a vehicle. Not used by DMS, I thought I needed it and I realized I didn't afterwards.
* New function: DMS_fnc_HeliParatroopers_Monitor; Monitors helis/aircraft spawned for paratroopers.
* New function: DMS_fnc_SpawnHeliReinforcement; Spawns a heli/aircraft with paratroopers for reinforcement.
* New group reinforcement type: "heli_troopers".
* You can now choose whether or not to destroy or simply unlock a used AI vehicle (with a random percentage chance).
* You can now use "setVariable" to define individually on an AI vehicle its "DMS_DestructionChance". EG: ```_vehicle setVariable ["DMS_DestructionChance",100];``` to always destroy a vehicle when its crew is dead.
* "DMS_DestructionChance" values are defaulted to "DMS_AI_destroyStaticWeapon_chance" or "DMS_AI_destroyVehicleChance" for static or regular vehicles, respectively.
* Fixed an issue where static weapons would always be destroyed, ignoring other configs. Thanks to [second_coming](http://www.exilemod.com/profile/60-second_coming/)!
* Disable simulation on objects imported from M3Editor. (Thanks to [second_coming](http://www.exilemod.com/profile/60-second_coming/) for the tip).
* Fixed an issue where AI units would be shown in static missions if configured to do so for dynamic missions (at least at first).


#### February 19, 2016 (5:45 PM CST-America):
* Fixed a minor typo with a variable (part of the new Humanity support by DonkeyPunch).


#### February 17, 2016 (6:00 PM CST-America):
* **NEW CONFIG VALUES:**

		DMS_Enable_RankChange
		DMS_Add_AIKill2DB
		DMS_Show_Kill_Rank_Notification
		DMS_Bandit_Soldier_RankGain
		DMS_Bandit_Static_RankGain
		DMS_Bandit_Vehicle_RankGain
		DMS_Hero_Soldier_MoneyGain
		DMS_Hero_Soldier_RepGain
		DMS_Hero_Soldier_RankGain
		DMS_Hero_Static_MoneyGain
		DMS_Hero_Static_RepGain
		DMS_Hero_Static_RankGain
		DMS_Hero_Vehicle_MoneyGain
		DMS_Hero_Vehicle_RepGain
		DMS_Hero_Vehicle_RankGain
		DMS_Survivor_Soldier_MoneyGain
		DMS_Survivor_Soldier_RepGain
		DMS_Survivor_Soldier_RankGain
		DMS_Survivor_Static_MoneyGain
		DMS_Survivor_Static_RepGain
		DMS_Survivor_Static_RankGain
		DMS_Survivor_Vehicle_MoneyGain
		DMS_Survivor_Vehicle_RepGain
		DMS_Survivor_Vehicle_RankGain
		DMS_Bandit_Soldier_RoadkillRank
		DMS_Bandit_Static_RoadkillRank
		DMS_Bandit_Vehicle_RoadkillRank
		DMS_Hero_Soldier_RoadkillMoney
		DMS_Hero_Soldier_RoadkillRep
		DMS_Hero_Soldier_RoadkillRank
		DMS_Hero_Static_RoadkillMoney
		DMS_Hero_Static_RoadkillRep
		DMS_Hero_Static_RoadkillRank
		DMS_Hero_Vehicle_RoadkillMoney
		DMS_Hero_Vehicle_RoadkillRep
		DMS_Hero_Vehicle_RoadkillRank
		DMS_Survivor_Soldier_RoadkillMoney
		DMS_Survivor_Soldier_RoadkillRep
		DMS_Survivor_Soldier_RoadkillRank
		DMS_Survivor_Static_RoadkillMoney
		DMS_Survivor_Static_RoadkillRep
		DMS_Survivor_Static_RoadkillRank
		DMS_Survivor_Vehicle_RoadkillMoney
		DMS_Survivor_Vehicle_RoadkillRep
		DMS_Survivor_Vehicle_RoadkillRank
		DMS_heroSide
		DMS_survivorSide
* **There's a lot of new config values in this update, I know it would be a pain to merge them. Check [this pastebin](http://pastebin.com/5s9erDA6) that you can simply paste into your config.sqf to keep yourself up to date.**
* As you can see by the influx of new config values, DMS now supports AI sides other than "bandit".
* All AI types/sides can also take advantage of a humanity/scoring system.
* You can also save kills in the database.
* This update courtesy of [DONKEYPUNCH](https://github.com/donkeypunchepoch) :)


#### February 14, 2016 (1:45 PM CST-America):
* **NEW CONFIG VALUES:**

		DMS_MissionTimeoutResetFrequency
		DMS_SMissionTimeoutResetFrequency
		DMS_SpawnZoneMarkerTypes
		DMS_TraderZoneMarkerTypes
		DMS_BanditMissionsOnServerStart
		DMS_StaticMissionsOnServerStart
		DMS_Show_Party_Kill_Notification
		DMS_ai_offload_notifyClient
		DMS_ai_skill_randomDifficult
		DMS_ai_skill_randomEasy
		DMS_ai_skill_randomIntermediate
		DMS_MinimumMagCount
		DMS_MaximumMagCount
		DMS_BoxFood
		DMS_BoxDrinks
		DMS_BoxMeds
		DMS_BoxBaseParts
		DMS_BoxCraftingMaterials
		DMS_BoxTools
		DMS_CarThievesVehicles
* **UPDATING THE MISSIONS "bauhaus" AND "construction" ARE HIGHLY RECOMMENDED.**
* Created a couple new config examples.
* DMS will now use its own "PUID" for spawning persistent vehicles (instead of mine).
* Added "Taviana" to default map configs.
* You can now spawn missions on server start. Make sure to add them to the mission types beforehand.
* Fixed default values for reinforcements on saltflats and slums static Altis missions.
* ```_onSuccessScripts``` and ```_onFailScripts``` now use a new structure: it should be ```[[param,code],[param,code]]``` instead of ```[code,code]```.
* DMS now uses ```remoteExecCall``` instead of Exile client broadcast functions for "systemChatRequest" and "standardHintRequest".
* You can now customize the magazine range for guns in a crate. The "fillCrate" function is far from perfect, and I am working on improving it. Ideas are appreciated.
* Adjusted the logic to spawning AI reinforcements; the locations will be shuffled before the AI are spawned, and every location will be used at least once if there are more AI than reinforcement locations.
* You can now define custom markers for Trader/Spawn zones. Keep in mind that they are case-sensitive.
* ```_onMonitorStart``` will now run BEFORE success state is checked. As a result, I added a new "completion type" in "fn_MissionSuccessState" so that you can force mission completion via array manipulations.
* "fn_OnKilled" now gets AI side and type using "getVariable" instead of having to include them in the "addMPEventHandler". If you are using the function for custom purposes, you will need to edit your usage.
* You can now choose whether or not an AI produces different respect or tabs when roadkilled individually.
* You can now allow party members to be notified in chat when a party member kills an AI. It includes AI type+side, distance, and the amount of poptabs/respect received.
* You can now notify clients when AI have been offloaded to them.
* You now have greater control over AI difficulty; you can now manually define "random" presets to include/exclude special difficulty types.
* New function: "DMS_fnc_SetGroupBehavior_Separate" - You can pass an array of units and define their behavior without affecting the rest of the group.
* "DMS_fnc_SpawnAIVehicle" is overhauled: instead of only spawning a driver and a gunner, the function uses "allTurrets" to completely fill the crew of a vehicle.
* "DMS_fnc_SpawnAIVehicle" no longer sets the crew's behavior to "aware".
* Optimized "DMS_fnc_TargetsKilled".
* "DMS_explode_onRoadkill" now spawns the mine ON the player that ran the AI over, so damage to the vehicle is guaranteed no matter how fast the vehicle was going.
* Added some of the latest Exile items and tools.
* Loot configs for Survival Supplies and Construction Supplies have been split up and made more modular so they're easier to configure.
* The "bauhaus" mission is now actually guaranteed to spawn construction supplies.
* The "construction" mission spawns a greater variety and quantity of building supplies (and the supplies aren't hardcoded).
* Moved static and dynamic mission variable initialization to pre-init.
* Missions are now compiled in pre-init to limit overhead in runtime.
* You can now ```setVariable "DMS_CrateGodMode"``` and ```"DMS_CrateEnableRope"``` on a crate to control the respective settings.
* Fixed a typo that caused a script error in static mission monitor and prevented group reinforcements from spawning.
* You can now ```setVariable "DMS_AI_CustomOnKilledFnc"``` (a string) to execute a function on death. The dead unit is passed.





#### December 24, 2015 (1:45 PM CST-America):
* Fixed an issue where you couldn't take stuff out of a crate if you had "DMS_EnableBoxMoving" set to "false". Thanks to [Flowrider from Optimum Gaming](http://www.optimum-multigaming.com/) for the report.
* Fixed a couple script errors caused by a hasty adjustment in the last update.



#### December 24, 2015 (4:30 PM CST-America | Special Vishpala edition ;D ):
* **NEW CONFIG VALUE: DMS_MissionMarkerCount**
* "dynamicTextRequest" is now enabled by default instead of "textTilesRequest" because of performance issues.
* DMS should now be compatible with more/less than two markers as long as you change "DMS_MissionMarkerCount", without having to change multiple files :P



#### December 24, 2015 (1:45 PM CST-America):
* **NEW CONFIG VALUES:**

		DMS_SpawnFlareOnReinforcements
		DMS_MissionMarkerWinDot_Type
		DMS_MissionMarkerLoseDot_Type
		DMS_EnableBoxMoving
		DMS_BasesToImportOnServerStart
		DMS_AI_Classname
		DMS_AI_AimCoef_easy
		DMS_AI_AimCoef_moderate
		DMS_AI_AimCoef_difficult
		DMS_AI_AimCoef_hardcore
		DMS_AI_EnableStamina_easy
		DMS_AI_EnableStamina_moderate
		DMS_AI_EnableStamina_difficult
		DMS_AI_EnableStamina_hardcore
		DMS_AI_destroyStaticWeapon
		DMS_AI_destroyStaticWeapon_chance
		DMS_ai_SupportedRandomClasses
		DMS_random_non_assault_AI
		DMS_random_non_MG_AI
		DMS_random_non_sniper_AI
* Please check out the new config values in config.sqf to see what they do :)
* Fixed issue with "thieves" mission (and DMS-spawned persistent vehicles in general). Big thank you to [JamieKG from Eternal Gamer](http://eternal-gamer.com/) and Torndeco.
* **New static mission: "slums"**
	* Credit for the base goes to [William from Refugees of the Fallen](http://rtfgaming.com/)
	* Spawns 2 crates at 2 different locations from a list of 5 locations.
	* No AI vehicles, only infantry (introduces Close Quarters Combat)
	* Added to Altis by default.
* Static bases can now be imported on server startup instead of mission spawns. Enabled by default for saltflats and slums.
* Increased "DMS_MissionTimeoutResetRange" from 1000 to 1500.
* Removed the Navid from config (MG AI and box weapons).
* Edited panthera3_config to reduce SpawnZoneNear and TraderZoneNear blacklists.
* Edited "blackhawkdown" and "donthasslethehoff" missions to use a slightly different heli wreck classname.
* Increased marker circle diameter for saltflats mission to 750 meters.
* Moved "DMS_Version" variable assignment to pre-init.
* Moved Map Center and Map Radius assignments to post-init.
* Added support for 2 new optional parameters: ```_onMonitorStart``` and ```_onMonitorEnd```, run before and after the Mission Monitor checks the mission, respectively, but AFTER "Mission Success State" is checked.
* Mines should now be deleted when a mission fails.
* Script optimizations for almost all functions using new command(s) introduced in ArmA v1.54, as well as improved technique(s).
* "ExileServer_system_garbageCollector_deleteObject" is now used to actually delete items by DMS_fnc_CleanUp.
* AI and vehicle cleanup should now be completely handled by Exile.
* Added support for mARMA logging.
* **You can now disable the movement/lifting of loot crates after the mission is complete using "DMS_EnableBoxMoving".**
* Added some debug code to DMS_fnc_FindSafePos and DMS_fnc_IsValidPosition (commented out by default)
* New group reinforcement type "increasing_difficulty".
* DMS_fnc_IsNearWater now checks for invalid parameter(s).
* DMS_fnc_PlayerAwardOnAIKill now checks for roadkill values AFTER unit-defined respect/tabs.
* You can now define different marker types for mission completion/failure using "DMS_MissionMarkerWinDot_Type" and "DMS_MissionMarkerLoseDot_Type" respectively.
* "DMS_fnc_SetGroupBehavior" can now take a unit as parameter as well. It will also now return true if behavior was changed, false otherwise.
* "DMS_fnc_SpawnAIGroup" and "DMS_fnc_SpawnAIGroup_MultiPos" now supports the definition of custom gear sets.
* Improved function documentation for "DMS_fnc_SpawnAIGroup", "DMS_fnc_SpawnAIGroup_MultiPos", and "DMS_fnc_SpawnAISoldier".
* "DMS_fnc_SpawnAISoldier" now supports multiple different random AI class presets. This means that you can define a certain "random" class preset, but have it select from a specially defined list that excludes classes that you don't want.
* Added default values to certain "missionNameSpace getVariable"s in DMS_fnc_SpawnAISoldier to prevent script errors in the event of invalid definitions.
* Slight logic tweak/fix to DMS_fnc_TargetsKilled (it shouldn't throw errors when there aren't any).



#### November 18, 2015 (7:45 PM CST-America):
* **Tweaks to saltflats static mission:**
	* AI Vehicle is spawned AFTER the base is spawned (hopefully limits/prevents it from spawning inside something).
	* Before spawning a new crate, any crate (with the same classname) that potentially exists from a previous mission is deleted first.


#### November 14, 2015 (8:30 PM CST-America):
* **NEW CONFIG VALUES:**

		DMS_AllowStaticReinforcements
		DMS_MarkerText_ShowAICount_Static
		DMS_PredefinedMissionLocations_WEIGHTED
		DMS_AIKill_DistanceBonusMinDistance
		DMS_AIKill_DistanceBonusCoefficient
* You can now manually disable Static Mission AI reinforcements using "DMS_AllowStaticReinforcements"
* You can now choose whether or not to show AI count for map markers for both Static and Dynamic missions separately.
* DMS will now check to see if the config.sqf didn't load properly, and for the presence of RyanZombies.
* You can now make predefined locations weighted.
* Some optimization + code clarity.
* Added ```taviana_config.sqf``` (identical to ```tavi_config.sqf```) for the latest version of Taviana.
* **saltflats mission**:
	* The AI will now initially spawn randomly across the compound. This should help with the issue of some AI spawning outside of the compound.
	* Added more static guns: 4 around the flagpole (5 meters north, south, east, and west). One on top of the tower in each corner, and another on the top of the concrete water tower.
* When an AI group is offloaded to a client and he gets out of range AND no other viable client is found, the AI locality should now revert to the server (it used to just stay with the original client).
* Added extra measures to prevent the creation of 2 markers with the same name.
* fn_FillCrate.sqf:
	* Fixed the issue where DMS would complain about incorrect parameters when using custom code to generate loot.
	* DMS now has debug logging to tell you exactly what it spawns in the crate when using a crate case or custom code.
* "DMS_PredefinedMissionLocations" itself will now be shuffled when finding a position. This should make the generated positions even more random.
* Added new Group Reinforcement Types: "armed_vehicle_replace" and "static_gunner"
* Potentially resolved the issue with launchers not being deleted from AI bodies when they're killed sometimes.
* **fn_PlayerAwardOnAIKill.sqf**: Created a separate function to handle poptabs/respect of a player when he/she kills an AI.
	* Added a "distance bonus" for respect when killing AI.
	* Added logging for player rewards on AI kills.
* DMS now lets Exile's body cleanup handle dead AIs.
* Fixed the issue where DMS would spawn static missions even when "DMS_StaticMission" is set to false.
* fn_SetAILocality.sqf now returns true/false if it does/doesn't find an owner.
* New function "fn_SpawnAIGroup_MultiPos.sqf". Almost identical to SpawnAIGroup, except it spawns each AI along a list of locations.
* **Removed the pre-packed PBO. Too many people were having issues with their PBO tool removing the prefix and repacking it would result in DMS not working.**


#### October 30, 2015 (9:30 PM CST-America):
* **NEW CONFIG VALUES:**

		|DMS_MaxStaticMissions|
		|DMS_TimeToFirstStaticMission|
		|DMS_TimeBetweenStaticMissions|
		|DMS_StaticMissionTimeOut|
		|DMS_StaticMissionTimeoutResetRange|
		|DMS_StaticMinPlayerDistance|
		|DMS_UsePredefinedMissionLocations|
		|DMS_PredefinedMissionLocations|
		|DMS_MinDistFromWestBorder|
		|DMS_MinDistFromEastBorder|
		|DMS_MinDistFromSouthBorder|
		|DMS_MinDistFromNorthBorder|
		|DMS_StaticMissionTypes|
* Added new value "DMS_Version".
* **"DMS_fnc_SpawnAIStatic" is now "DMS_fnc_SpawnAIStaticMG"; donthasslethehoff, mercbase, and testmission have been updated with the new names**
* DMS will now check to make sure that marker colors passed to fn_CreateMarker are valid marker colors.
* You can now control how far away from each border a mission will spawn (each border is separate: west, east, south, north). All "supported" maps have config values adjusted in "map_configs".
* New salt flats base by [Darth Rogue from SOA](http://soldiersofanarchy.net/).
* **IMPLEMENTED STATIC MISSIONS (initial version). "saltflats" is currently the only static mission for Altis ONLY. However, it shouldn't be too difficult to export it to other maps (once positions have been adjusted).**
* Fixed a couple of outdated/inaccurate function documentation comments.
* **FINALLY REMOVED THE Default Value "-1" PARAMS RPT SPAM. I FOUND IT. YESSSSS**
* Fixed fn_CleanUp producing debug logs even with debug disabled.
* Fixed the CleanUp list not Cleaning Up after itself (hah!).
* Added diag_tickTime and DMS_Version to debug logs.
* You can now define a custom function for DMS_FillCrate. It will be passed params from ```_lootValues select 0```. **I haven't tested this at all. Just keep that in mind ;)**
* You can now manually define mission spawning locations into an array, and that array will be used to find a location. Each location will still be checked for validity, and if no valid positions are found from the list, a random one is then generated using the normal method. **I didn't test this part at all either :P**
* fn_FindSafePos should be even more efficient now, and even more controllable.
* Quite a few new functions; most notably: fn_GroupReinforcementsManager
* fn_GroupReinforcementsManager is used by static missions to provide reinforcements for AI once they fall below a certain threshold (and/or any other parameters you provide). Make sure to check out the function documentation and give any suggestions for new reinforcement types!
* New function "DMS_fnc_ImportFromM3E_Static" will simply import a base from the provided file (under static). No conversion to relative position or anything. Simply spawning, positioning, and disabling simulation.
* Removed the check for being outside map edges from fn_isValidPosition.
* "hardcore" AI will now be even more difficult ;)


#### October 17, 2015 (2:30 PM CST-America):
* **NEW CONFIG VALUES**:

		|DMS_TimeToFirstMission|
		|DMS_ShowDifficultyColorLegend|
		|DMS_TerritoryNearBlacklist|
		|DMS_MinSurfaceNormal|	(Used to be DMS_MaxSurfaceNormal, simply renamed)
		|DMS_ai_launchers_per_group|
* **UPDATING ALL OF YOUR MISSION FILES IS HIGHLY RECOMMENDED UNLESS YOU KNOW WHAT YOU'RE DOING**
* RENAMED "DMS_MaxSurfaceNormal" to "DMS_MinSurfaceNormal". I must have been very tired when I named it...
* DMS_MinSurfaceNormal is now 0.9 by default, but will be 0.95 for Altis and Bornholm (since they're relatively large/flat maps). Esseker is still 0.85. If you want to convert DMS_MinSurfaceNormal to degrees, you would take the arc-cosine of the surfaceNormal, and that will give you the degrees from horizontal. For example, arccos(0.9) is about 25 degrees. Google: "arccos(0.9) in degrees"
* Tweaked and rebalanced "DMS_BanditMissionTypes". Most of the spawn chances are the same, they're just reduced in order to prevent the creation of arrays that are far larger than they need to be.
* You can now manually define how long it takes for the first mission to spawn after a restart.
* DMS will now by default create markers on the bottom left of the map to show which colors correspond to which difficulty. It isn't very pretty, but it gets the point across.
* DMS will now manually calculate the center of the map and its radius, if it isn't preconfigured by DMS.
* You can now specify the vehicles to spawn for missions: "bandits", "cardealer", "construction", "donthasslethehoff", and "thieves".
* You can now specify the spawning location of any mission (and whether or not to use an alternative location if the provided location is invalid). This will allow for easy integration of DMS into admin tools.
* Added support for scripts to be executed on mission completion or mission failure (this will allow you to have "multi-part" missions, where you would simply spawn the next part of the mission if the previous is completed).
* Restructured DMS_DEBUG from the previous patch in favor of a more "optimized" method.
* DMS_fnc_findSafePos is completely overhauled; DMS no longer uses "BIS_fnc_findSafePos". It also now throttles minSurfaceNormal on repeated failure. You can now determine whether or not the mission should spawn on water (however, I don't suggest you use this function for water spawns yet).
* You can also now define a minimum distance from other territories for missions.
* DMS_fnc_IsValidPosition will now check for water depth if the provided position is meant to be checked as a "water spawn". It will now also check for nearby missions from A3XAI or VEMF (untested).
* DMS_fnc_IsValidPosition now checks whether or not the position is outside of the map borders.
* DMS_fnc_SelectOffsetPos will now return the 3rd element of the provided position as-is.
* You can now have multiple AI within a group with a launcher.
* AI now have a 5-second godmode after spawning.
* You can now spawn a crate using ASL pos. DMS_fnc_SpawnCrate will also make sure that the provided classname is valid.
* Just like SpawnCrate, "DMS_fnc_SpawnNonPersistentVehicle" and "DMS_fnc_SpawnPersistentVehicle" will now make sure that the provided classname is valid.
* "DMS_fnc_SpawnPersistentVehicle" now supports ASL spawning.
* Added support for [Rod Serling's](https://github.com/Rod-Serling) AVS.
* General optimization.


#### October 9, 2015 (8:30 PM CST-America):
* **NEW CONFIG VALUE: DMS_Use_Map_Config**
* You can now overwrite "main config values" with map-specific config values located in the new "map_configs" folder. This should allow you to use one DMS PBO if you have multiple servers with different maps. Included examples for Altis, Bornholm, Esseker, and Tavi (Taviana).
* Because of the above implementation, DMS by default will not include the salt flats blacklist for findSafePos. In addition, it is preconfigured to the hilly terrains in Esseker and Taviana, as well as reducing all of the blacklist distances due to the smaller map size in Esseker.
* Created new function "DMS_fnc_DebugLog". All DMS files (that produced debug logs) have been changed, including mission files. However, updating them is not important (and completely pointless if you don't even use DMS_DEBUG).
* Fixed a few locations where it said "sized" instead of "seized". Thanks to [icomrade](https://github.com/icomrade) for pointing them out.
* DMS now utilizes the "ARMA_LOG" DLL (if it exists) by infiSTAR to produce debug logs (if enabled). All debug logs now also include server uptime (in seconds) and server FPS.
* The FSM no longer produces debug logs.
* AI Locality manager will now run every minute.
* Debug logs for "DMS_fnc_MissionsMonitor" will only output the mission name and the position, instead of all of the parameters.
* "DMS_fnc_IsNearWater" will now check the provided position itself for water.
* "DMS_fnc_IsValidPosition" will now do a surfaceNormal check within a 5 meter radius of the provided position as well.
* ```_customGearSet``` should now actually work for "DMS_fnc_SpawnAISoldier", and the function title comment has been updated for the slightly tweaked syntax.


#### October 8, 2015 (7:15 PM CST-America):
* **NEW CONFIG VALUES**:

		|DMS_Show_Kill_Poptabs_Notification|
		|DMS_Show_Kill_Respect_Notification|
		|DMS_dynamicText_Duration|
		|DMS_dynamicText_FadeTime|
		|DMS_dynamicText_Title_Size|
		|DMS_dynamicText_Title_Font|
		|DMS_dynamicText_Message_Color|
		|DMS_dynamicText_Message_Size|
		|DMS_dynamicText_Message_Font|
		|DMS_standardHint_Title_Size|
		|DMS_standardHint_Title_Font|
		|DMS_standardHint_Message_Color|
		|DMS_standardHint_Message_Size|
		|DMS_standardHint_Message_Font|
		|DMS_textTiles_Duration|
		|DMS_textTiles_FadeTime|
		|DMS_textTiles_Title_Size|
		|DMS_textTiles_Title_Font|
		|DMS_textTiles_Message_Color|
		|DMS_textTiles_Message_Size|
		|DMS_textTiles_Message_Font|
* "DMS_PlayerNotificationTypes" has been adjusted to include "systemChatRequest" and the brand new "textTilesRequest". **NOTE:** Due to the way "text tiles" work, a player can only have one on his screen at a time. As a result, if another text tile is created while the mission message is up, the message will immediately disappear to display the new text tile. Currently, the "Frag Messages" (the ones that say "Player Kill 	+100") use text tiles. I don't think it should be a major issue (especially if you use "systemChatRequest", so the player can just scroll up), but if I get reports of it being stupid, I will default to "dynamicTextRequest", which should also look pretty damn nice.
* These changes should make it much easier for people to use DMS notification functions for other purposes.
* Fixed AI waypoints - the AI should now properly circle the objective at the proper radius.
* Tweaked "DMS_AI_WP_Radius_moderate" and "DMS_AI_WP_Radius_difficult" (reduced the radii). Due to the AI pathing fix.
* Fixed a couple typos in "DMS_fnc_SpawnAISoldier". ```_customGearSet``` should work now (although I'm fairly certain nobody uses it since nobody ever complained :P )
* Improved "DMS_fnc_SpawnNonPersistentVehicle"; Vehicles should no longer spawn jumbled up in most cases (like cardealer). Also, it's updated to the latest Exile methods to ensure that vehicles have no nightvision/thermal if configured to do so in Exile configs. Also added the "MPKilled" EH used by Exile for non-persistent (persistent vehicles already had it).
* You can now choose whether or not you want to display the poptabs or respect kill messages when killing an AI with "DMS_Show_Kill_Poptabs_Notification" and "DMS_Show_Kill_Respect_Notification". Both are enabled by default.
* Fixed typos in the "OnKilled" EH (didn't really affect anything)
* Fixed cases when "currentMuzzle" would return a number. Thanks to [azmodii](https://github.com/azmodii) for the report.
* Optimized the "AI share info" function in "OnKilled"
* Fixed mines facing the wrong direction. Thanks to [boLekc](https://github.com/boLekc) for the report.


#### October 4, 2015 (10:30 PM CST-America):
* **NEW CONFIG VALUES**:

		|DMS_MarkerText_ShowMissionPrefix|
		|DMS_MarkerText_MissionPrefix|
		|DMS_MarkerText_ShowAICount|
		|DMS_MarkerText_AIName|
* New function: DMS_fnc_SpawnPersistentVehicle. It will spawn inaccessible vehicles by default and convert VALID pincode inputs to the proper format.
* New mission: "Car Thieves" (thieves.sqf). It uses the new DMS_fnc_SpawnPersistentVehicle. When the mission is completed successfully, the code is displayed in the completion message.
* You can now add a "prefix" to the marker text of each mission.
* You can now display the number of remaining AI in the marker text (it should update about every 15 seconds).
* Rearranged the missions in the config to look prettier. Don't judge.
* Added the "Zamak", "Tempest", and "HEMMT" to "DMS_TransportTrucks" array. Removed "Exile_Car_Van_Black"
* "dynamicTextRequest" messages will now appear at the top of the screen, so it shouldn't distract/block stuff in focus.
* Optimized "DMS_fnc_MissionsMonitor" slightly... it should only extend the mission (and check for nearby players, which is a bit resource intensive) when the mission is actually potentially going to despawn.
* Fixed some spelling, improved some grammar (will require mission updates, it's really minor though).


#### October 3, 2015 (10:30 PM CST-America):
* **You must update all of your mission files; the mission message system as well as the calling parameters for DMS_fnc_FindSafePos have been overhauled and will be incompatible with previous versions.**
* NEW CONFIG VALUES:

		|DMS_ThrottleBlacklists|
		|DMS_AttemptsUntilThrottle|
		|DMS_ThrottleCoefficient|
		|DMS_MinThrottledDistance|
* Decreased "DMS_TraderZoneNearBlacklist","DMS_MissionNearBlacklist","DMS_WaterNearBlacklist"
* Changed "DMS_dynamicText_Color" to "#FFFFFF" (white)
* Replaced weapon classes in "DMS_CrateCase_Sniper" to the base classes; all attachments should now spawn in the box separately.
* New function DMS_fnc_IsValidPosition (uses logic that was previously from "DMS_fnc_FindSafePos").
* You can now manually define every individual parameter for DMS_fnc_findSafePos per-mission, instead of using global parameters.
* AI will now be offloaded to an HC even with "DMS_ai_offload_to_client" set to false.
* All of the previously "supported" values for "DMS_PlayerNotificationTypes" are now PROPERLY supported. DMS_PlayerNotificationTypes is now set to default "dynamicTextRequest" and "systemChatRequest".
* Tweaked "cardealer" mission, the cars should no longer spawn inside of each other.



#### September 30, 2015 (9:30 PM CST-America):
* NEW CONFIG VALUE: DMS_SpawnMinefieldForEveryMission
* You can now force-spawn an AT mine minefield on every mission with the above config. These mines will only blow up on Tanks, APCs, and MRAPs (Ifrits, Hunters, Striders).
* ALL MISSIONS HAVE BEEN EDITED TO MATCH THE NEW STANDARD FOR DMS_fnc_AddMissionToMonitor. **If you have made any custom missions or modified any of the current mission scripts, make sure you merge your changes**!
* Adjusted the placement of the armed car in "bandits" mission. It should no longer spawn right on the crate.
* Marker and message names for the "foodtransport" mission have been adjusted.
* Added the AI vehicle to the "mercbase" mission.
* Removed some RPT spam...
* Standardize ATL for DMS_fnc_importFromM3E_Convert
* When revealing a player to AI, the reveal amount will be reduced if the player has a suppressor.
* DMS_fnc_SetGroupBehavior will now remove all previous waypoints from the AI group.
* Improved logging message for DMS_fnc_SpawnMinefield. Also, the mine warning signs should be on a random offset (instead of always spawning at 0, 90, 180, and 270 degrees)
* Removed obsolete DMS_DEBUG overrides in config. "DMS_fnc_SpawnBanditMission" called from console works great.


#### September 25, 2015 (11:30 PM CST-America):
* Improved DMS_fnc_FindSafePos when checking for nearby missions - it should now use the proper mission location (if it was given correctly in the parameters for DMS_fnc_CreateMarker) instead of the marker position, which could be offset. Thanks to [Rod Serling](https://github.com/Rod-Serling) for complaining about this "issue" :P


#### September 25, 2015 (7:30 PM CST-America):
* NEW CONFIG VALUES:

		|DMS_SpawnMineWarningSigns|
		|DMS_BulletProofMines|
* You can now manually define the rare loot chance per crate.
* You can now define the mine amount and radius directly from the call for DMS_fnc_SpawnMinefield.
* You can now define the classname of the mine to be spawned in the minefield.
* Mines can now be configured to be bulletproof (AT mines by default will explode when shot).


#### September 25, 2015 (1:30 AM CST-America):
* NEW CONFIG VALUES:

		|DMS_SpawnMinesAroundMissions|
		|DMS_despawnMines_onCompletion|
		|DMS_MineInfo_easy|
		|DMS_MineInfo_moderate|
		|DMS_MineInfo_difficult|
		|DMS_MineInfo_hardcore|
		|DMS_explode_onRoadkill|
* You can now spawn randomly generated minefields around missions! Numberof mines and radius is dependent on difficulty.
* Also, you can now spawn an explosion on an AI when it is roadkilled, causing a wheel or two of the roadkilling vehicle to break.
* Commented out the spawning of static-relative conversion of base objects in test mission.
* Included example of how to spawn the minefield in the test mission.
* Reduced some of the RPT spam.
* Smoke/IR grenades will only spawn on proper crates - you can now safely use DMS_fnc_FillCrate with non-crate objects but still have smoke available.


#### September 21, 2015 (11:30 PM CST-America):
* NEW CONFIG VALUES:

		|DMS_Diff_RepOrTabs_on_roadkill|
		|DMS_Bandit_Soldier_RoadkillMoney|
		|DMS_Bandit_Soldier_RoadkillRep|
		|DMS_Bandit_Static_RoadkillMoney|
		|DMS_Bandit_Static_RoadkillRep|
		|DMS_Bandit_Vehicle_RoadkillMoney|
		|DMS_Bandit_Vehicle_RoadkillRep|
* Removed config value: "DMS_credit_roadkill"
* You can now REDUCE a player's respect/poptabs when the player roadkills an AI. The default values are -10 poptabs and -5 respect (hardly noticeable, but I didn't want it to be extreme).
* Alternatively, you can simply reduce the amount of poptabs gained by giving each corresponding config a positive value less than the regular. Set the value to 0 if you don't want to credit the poptabs/respect.
* The player will get an appropriately colored message if he/she LOSES poptabs (as opposed to gaining them).
* The player also gets a little more information regarding the type of AI he/she has killed.


#### September 20, 2015 (11:30 PM CST-America):
* CONFIG VALUES: Changed "DMS_MissionTypes" to "DMS_BanditMissionTypes"
* Renamed some variables to "future-proof" them
* Placed all current missions under "bandit" subfolder to for easier future integration.
* Created function "DMS_fnc_SpawnBanditMission" to handle bandit mission spawning (makes it easier to spawn missions via admin console).
* Attached vehicle eventhandlers to DMS-spawned non-persistent vehicles.
* Fixed the "lock" option appearing on DMS-spawned vehicles.


#### September 20, 2015 (3:30 PM CST-America):
* NEW CONFIG VALUE: "DMS_MaxSurfaceNormal"
* The above config value now determines the maximum incline that a mission can spawn on. Default value is 0.95, which should be sufficiently flat.
* Added some grouping explanations in mission config settings.
* Added check for A3XAI for the lovely ["Face"/"dayzai"](https://github.com/dayzai)
* Added ability for people to use a static export from M3Editor. DMS will then calculate the relative position, and spawn it at the mission. Example provided in testmission.sqf.
* Fixed an issue with DMS_fnc_TargetsKilled always returning false.


#### September 20, 2015 (12:30 AM CST-America):
* NEW CONFIG VALUE: "DMS_ai_offload_Only_DMS_AI"
* You can use "DMS_ai_offload_Only_DMS_AI" to offload only AI spawned by DMS. This should resolve any issues with other mission systems from DMS.
* Increased "DMS_playerNearRadius" from 75 meters to 100 meters.
* You can now define "absolute" mission conditions. If this mission condition is met, it immediately counts the mission as completed. Add "true" after the completion argument to turn it into an "absolute" win condition.
* Added compatibility with RS_VLS by [Rod Serling](https://github.com/Rod-Serling).


#### September 18, 2015 (6:30 PM CST-America):
* NEW CONFIG VALUE: "DMS_HideBox".
* Loot vehicles cannot be lifted, pushed, or damaged until the mission is completed successfully. Then the vehicle will be added to the Exile simulation monitor.
* AI in vehicles will be automatically ejected on death.
* Another potential fix for launchers not despawning off of AI sometimes.
* When an AI gunner from an armed ground vehicle is killed, the driver will be switched to the gunner seat after 5-10 seconds. This prevents the driver from driving around aimlessly and trolling.
* The above feature should now also work on AI that have been offloaded now (doing so was a major, major pain in the ass, and is the reason why there was no update yesterday).


#### September 16, 2015 (10:30 PM CST-America):
* NEW CONFIG VALUES: DMS_MaxAIDistance and DMS_AIDistanceCheckFrequency
* You can now use the above config values to kill AI that flee from their spawn position. Only "Soldier" AI will be killed.
* Removed "O_HMG_01_F" from AI Static Weapons. AI were pretty useless on it... unless the AI were facing the right direction.
* Reduced AI count and removed the "playerNear" parameter from testmission for easier testing.
* NEW: When an AI vehicle gunner is killed, and the driver is still alive, after a little delay, the driver is then switched to the gunner seat. You should no longer have AI vehicles with a dead gunner that's driving around aimlessly :) There is a 5-8 second delay to simulate reaction time. Then the driver is ejected, then after 1.5 seconds the AI is then forced into the  gunner seat.
* NOTE: The above feature only works when the AI is still local (not offloaded). If the AI is offloaded, the AI is simply ejected and becomes a foot soldier.
* AI assigned vehicles are destroyed when the crew is empty. Simulation is also disabled on them.
* Reduced some of the "params" RPT spam, from DMS_fnc_SetGroupBehavior.
* Tweaked AI Vehicle spawning logic. The AI are initially assigned to a temporary group and then behavior is set, then they join the assigned group to prevent overriding behavior of other ground units.
* Non-persistent vehicles should now be fit properly to the terrain.


#### September 14, 2015 (11:00 PM CST-America):
* NEW CONFIG VALUES: DMS_AIVehCleanUpTime, DMS_MinWaterDepth, DMS_Bandit_Vehicle_MoneyGain, DMS_Bandit_Vehicle_RepGain.
* Changed default value of DMS_Bandit_Static_MoneyGain to 75, DMS_Bandit_Static_RepGain to 15.
* NEW FUNCTION: DMS_fnc_SpawnAIVehicle.
* You can now spawn AI in vehicles.
* Improved cleanup method for AI in static guns.
* Working on improving OnKilled EH for AI in vehicles.
* FindSafePos should no longer check for parameters if the corresponding blacklist radius is set to 0.


#### September 13, 2015 (11:45 PM CST-America):
* Updated parameter type for "DMS_dynamicText_Size", as well as commented out description for "dynamicTextRequest". Will try to work on functionality for it soon.
* Improved cleaning of AI units. There may still be issues, specifically with launchers. If there are, please let me know, and test it. The more info I have, the quicker it can be fixed :)


#### September 13, 2015 (1:00 AM CST-America):
* New config value: ```DMS_AI_WP_Radius_base``` . Tiny waypoint radius for "base defence".
* New mission: "mercbase". Known issue: Stuff gets messed up when the mission spawns on a steep slope. Blame BIS for breaking "BIS_fnc_findSafePos" :P
* Added Taviana map safe pos params. (thanks JamieKG!)
* New functions: "DMS_fnc_CalcPos" and "DMS_fnc_ImportFromM3E".
* You can now import bases from Maca's awesome M3 Editor! Simply create the file under the "objects" folder, then call "DMS_fnc_ImportFromM3E"! Refer to the new "mercbase" mission as an example.
* "DMS_fnc_ImportFromM3E" supports static position (make sure you pass [0,0,0] as the second parameter), relative position, as well as bank/pitch. In addition, you get parameter parsing, just like any other DMS function, so if you're messing around with stuff and make a mistake, it will tell you ;)
* You can now specify which gun that an static AI spawns with.


#### September 12, 2015 (1:30 AM CST-America):
* Added Esseker map safe pos params. (thanks Flowrider!)


#### September 11, 2015 (8:30 PM CST-America):
* NEW CONFIG VALUES: ```DMS_GodmodeCrates``` and ```DMS_CrateCase_Sniper```. DMS_GodmodeCrates is pretty self-explanatory :P
* NEW FEATURE FOR "DMS_fnc_FillCrate": You can now define "crate cases" in the config (such as "DMS_CrateCase_Sniper"). Passing the "crate case" name (such as "Sniper") will make the crate spawn with the exact gear defined in the config. Refer to the testmission.sqf (line 80) and "DMS_CrateCase_Sniper" config for an example.
* Spawned vehicles will now be LOCKED and INVINCIBLE until the mission is completed.
* Spawned vehicles spawn with 100% fuel.
* "Fixed" some cases where killing from a mounted gun would reset your money/respect (maybe).
* Fixed some spelling errors and incorrect names in some of the mission messages/markers.
* Fixed DMS_fnc_FindSafePos for Bornholm. If you have any issues with custom maps, please let us know.
* Fixed backpack spawning on the ground behind an AI unit that was supposed to get a launcher.


#### September 10, 2015 (6:00 PM CST-America):
* NEW CONFIG VALUES: ```DMS_MarkerPosRandomization```, ```DMS_MarkerPosRandomRadius```, and ```DMS_RandomMarkerBrush```
* With the above configs, you can randomize the marker positions in a random position around the actual mission center.
* You can also "force" DMS_fnc_CreateMarker to randomize (or not randomize) the marker position with optional boolean parameter of index 3.
* Changed the default (non-randomized) circle marker "brush". It should be a solid circle.
* Created new functions ```DMS_fnc_SelectOffsetPos``` and ```DMS_fnc_SelectRandomVal```
* Adjusted a couple functions to use them.
* Fixed ```DMS_fnc_IsNearWater```.


#### September 9, 2015 (10:00 PM CST-America):
* Added static AI! The "donthasslethehoff" mission has them included by default. :D
* New config values: ```DMS_Bandit_Static_MoneyGain``` and ```DMS_Bandit_Static_RepGain```.
* Future-proofed ```DMS_fnc_OnKilled```. As a result, "DMS_BanditMoneyGainOnKill" is now ```DMS_Bandit_Soldier_MoneyGain```, and "DMS_BanditRepGainOnKill" is now ```DMS_Bandit_Soldier_RepGain```.
* Added config value ```DMS_ai_disable_ramming_damage```. Check the comment for more info :)
* Removed config value "DMS_ai_static_skills"
* Randomized vehicle spawn position for "cardealer" mission.
* NOTE: If you use custom ```DMS_fnc_SpawnAISoldier``` calls, you will have to update your calling parameters! Make sure you add "Soldier" at the end of the array, or before ```_customGearSet``` if you're using it!
* Added ```_launcher``` option for ```_customGearSet``` in ```DMS_fnc_SpawnAISoldier```. NOTE: This changes the order of the gearset parameters for the AI. ```_launcher``` is between ```_items``` and ```_helmet```! Use empty string ```""``` if you don't want any launcher on the AI unit.


#### September 8, 2015 (11:00 PM CST-America):
* AI Bodies should now be properly cleaned when run over (if configured to do so with ```DMS_remove_roadkill``` and ```DMS_remove_roadkill_chance```).
* Added config option ```DMS_credit_roadkill```. If set to true, players will get poptabs/respect for running over AI. Default: false.
* Fixed giving poptabs/respect for killing AI from vehicles. Passengers and mounted gunners should properly receive poptabs/respect when they kill AI.
* Launchers should now be reliably removed from AI bodies that have them.


#### September 7, 2015 (7:00 PM CST-America):
* AI bodies should now be cleared if configured to do so with "DMS_clear_AI_body" and "DMS_clear_AI_body_chance".


#### September 5, 2015 (1:00 AM CST-America):
* Created new function "DMS_fnc_IsPlayerNearby" to replace "ExileServer_util_position_isPlayerNearby".
* Fix IR Strobes spawning inside the crate and not appearing.


#### September 4, 2015 (11:20 PM CST-America):
* Improved crate handling by DMS. You can now spawn multiple crates with different loot, or simply no crates at all. (REQUIRES FILE CHANGES FOR EACH MISSION)
* Accounted for case sensitivity in switch-do statements for SpawnAISolder.
* Decreased default amount of money/respect gain on AI kills (Used to be 100 poptabs and 25 respect, it is now 50 poptabs and 10 respect)
* Define functions in config.cpp. This resulted in ALL FILES being changed to some degree.
* Fixed spawning Binocs and Rangefinders/Designators on AI.



## Previous Test Branch Changes:

### "May 6, 2016" Test Branch
#### June 16, 2016 (1:55 PM CST-America) **Release Candidate 1.5**:
* New function: DMS_fnc_AddWeapon. More efficient version of BIS_fnc_AddWeapon, and removed almost all error-checking.
* DMS will now log the DMS version to the client RPT on login.
* Fixed a couple issues in fn_SpawnAISoldier.sqf.
* Updated Tanoa config, missions should now be (somewhat) less likely to spawn in the center valley of the main island.

#### June 16, 2016 (1:55 PM CST-America) **Release Candidate 1.3**:
* Renamed the "mercbase.sqf" mission title to "Mercenary Outpost" to avoid confusion with the salt flats mission.
* Fixed an issue with fn_SpawnMineField.sqf (thanks to CEN for providing important info)


#### June 12, 2016 (3:15 AM CST-America) **Release Candidate 1.2**:
* Removed the marker color check in "DMS_fnc_CreateMarker". Invalid marker colors are up to server owners to detect.
* Micro-optimized "DMS_fnc_IsPosBlacklisted" for the rectangular blacklist case; also rearranged the statements to be clearer and easier to understand.


#### June 7, 2016 (11:15 PM CST-America) **Release Candidate 1.1**:
* Slight optimization of SpawnAIGroup functions (if you have launchers enabled).

#### June 6, 2016 (10:45 PM CST-America) **Release Candidate 1**:
* New function: DMS_fnc_IsPosBlacklisted (optimized replacement for "BIS_fnc_IsPosBlacklisted")
* Config value "DMS_findSafePosBlacklist" now supports the ability to blacklist within a certain distance of a given position.
* "DMS_CLIENT" functions are now compiled in pre-init (broadcasting is still done in post-init).
* Notifications from "textTilesRequest" and "dynamicTextRequest" should no longer "stack" on each other; if two missions spawn right after another, the second mission notification will be delayed at least until the first one completes.
* More Micro-optimizations on most functions; parameters passed to DMS functions will no longer be checked to see if they are the right type, etc. It was determined that they didn't really provide any benefit, as most errors either don't trigger the "params" error, or the error is simply reiterated elsewhere.
* Removed config value "DMS_MissionMarkerCount"
* "DMS_fnc_FindSuppressor" has been overhauled; it simply checks the configs for the provided weapon classname to return a random muzzle/suppressor classname. Consequently, the function is smaller, faster, and perfectly compatible with any weapon.
* The "freeze manager" will now unfreeze AI if needed regardless of setting "DMS_ai_allowFreezing" to false.

#### May 22, 2016 (3:15 PM CST-America):
* **NEW CONFIG VALUES:**
		DMS_ai_freezeOnSpawn
* Added the ability to freeze AI groups immediately upon spawn.
* Units spawned to a group that has been frozen should now also be frozen.
* Fixed an issue where "FindSuppressor" would return a boolean instead of empty string.
* Fixed an issue with undefined variable when "DMS_ai_offloadOnUnfreeze" was set to true.
* Added debug message when a group is frozen.
* Created a new function "DMS_fnc_FreezeToggle" that actually handles freezing/unfreezing.
* DMS will now apply a variable "DMS_isGroupFrozen" to groups that are frozen.

#### May 22, 2016 (12:00 AM CST-America):
* **NEW CONFIG VALUES:**
		DMS_ai_allowFreezing
		DMS_ai_freeze_Only_DMS_AI
		DMS_ai_freezingDistance
		DMS_ai_unfreezingDistance
		DMS_ai_offloadOnUnfreeze
		DMS_ai_freezeCheckingDelay
* Removed a "Land_Wreck_Heli_Attack_01_F" from saltflats (it creates server threads)
* Adjusted logic in "AILocalityManager": the variable "DMS_LockLocality" on a group should now be considered even if "DMS_ai_offload_Only_DMS_AI" is set to false.
* You can now "freeze"/"un-freeze" AI! This has been a long-awaited feature for DMS. Using it should grant major performance benefits when you have lots of AI around the map that are inactive.

#### May 16, 2016 (11:00 AM CST-America):
* Fixed an error in fn_SpawnAIGroup (and MultiPos variant)

#### May 16, 2016 (11:00 AM CST-America):
* Occupation will now print debug logs only if DMS_DEBUG is enabled.
* Fixed an error with fn_FindSafePos.

#### May 15, 2016 (2:00 PM CST-America):
* **NEW CONFIG VALUES:**

		DMS_AI_UseRealNames
* More Micro-optimizations.
* Fixed a lot of various errors from the last test branch update.
* Integrated Exile Occupation by second coming :)


#### May 6, 2016 (10:45 PM CST-America):
* **NEW CONFIG VALUES:**

		DMS_assault_RandItemCount
		DMS_assault_RandItems
		DMS_MG_RandItemCount
		DMS_MG_RandItems
		DMS_sniper_RandItemCount
		DMS_sniper_RandItems
* New functions: DMS_fnc_ImportFromM3E_3DEN, DMS_fnc_ImportFromM3E_3DEN_Convert, DMS_fnc_ImportFromM3E_3DEN_Static.
* Functions that were previously defined in preinit with regular code brackets ("GetCenter", "SetRelPositions", and "SubArr") are now defined as DMS functions (instead of M3E functions before) and have their own files.
* "M3E" functions are still defined in DMS pre-init for compatibility with external code.
* You can now allow a set of random inventory items that are given to AI. Amount and item types can be set per-class.
* "DMS_StaticMissionsOnServerStart" will only be used if "DMS_StaticMission" is set to true. In other words, no static missions will be spawned on server start if you don't use static missions.
* DMS will now issue an error if you set "DMS_Use_Map_Config" for map without a config. Hopefully this resolves an issue where the server wouldn't start if you tried to load a map config from a file that didn't exist.
* Adjusted map config for chernarus: Missions should no longer spawn near map borders.
* Micro-optimizations for almost all DMS functions (using the new functionality of "private", which is faster than the previous). Also, some variables that weren't previously defined as private are now fixed.
* Removed legacy HC (headless client) support from "DMS_fnc_AILocalityManager".
* Major optimizations for DMS_fnc_FindSafePos
* Removed the useless ```_waterSpawn``` parameter from "FindSafePos" and "IsValidPosition". DMS is currently only used on land, a dedicated function for finding valid water spawns will come if/when needed.
* All of the "Import" functions now check for invalid exports.
* When using a "custom gear set", magazines and items are added about 0.5 seconds after the AI is spawned in order to account for an issue where the backpack isn't used (because it isn't added fast enough?). (Thanks to [second_coming](http://www.exilemod.com/profile/60-second_coming/) for the report)
* NOTE: I didn't test any of this stuff, and there's LOTS of code changes. Do not be surprised if everything is broke! :p

### "March 1, 2016" Test Branch
#### List Of new Config values:

		DMS_SpawnMissions_Scheduled
		DMS_AI_WP_Radius_heli
		DMS_AI_WP_Radius_heli
		DMS_RHeli_Height
		DMS_RHeli_MinDistFromDrop
		DMS_RHeli_MaxDistFromDrop
		DMS_RHeli_MinDistFromPlayers
		DMS_RareLootAmount
		DMS_ReinforcementHelis

#### April 20, 2016 (5:45 PM CST-America, RC):
* The new "DMS_fnc_FindSafePos_InRange" function will ignore the config "DMS_UsePredefinedMissionLocations".
* Disable simulation on objects imported from M3Editor. (Thanks to [second_coming](http://www.exilemod.com/profile/60-second_coming/) for the tip)

#### April 15, 2016 (8:45 PM CST-America, RC):
* Fixed an issue where static weapons would always be destroyed, ignoring other configs. Thanks to [second_coming](http://www.exilemod.com/profile/60-second_coming/)!

#### April 15, 2016 (9:30 AM CST-America, RC):
* Fixed script error in OnKilled EH when handling a used AI vehicle.

#### April 14, 2016 (9:20 PM CST-America, RC):
* Fix script error with saltflats.
* "DMS_fnc_AddMissionToMonitor" will no longer convert given AI parameters to a list of objects, so you can now add other units to the mission (within the same group) without much issue.
* Micro-optimizations here and there.
* Fixed an issue with DMS_fnc_GetAllUnits such that it would return an empty list if given a list of AI objects.
* You can now set the maximum limit of paratrooper reinforcements.
* The pilot of the reinforcement heli should now fly away properly if configured to do so.
* Updated group reinforcement manager for compatibility with latest syntax for paratrooper reinforcements (NOTE: UNTESTED).


#### March 31, 2016 (6:00 PM CST-America):
* You can now use "setVariable" to define individually on an AI vehicle its "DMS_DestructionChance". EG: ```_vehicle setVariable ["DMS_DestructionChance",100];``` to always destroy a vehicle when its crew is dead.
* "DMS_DestructionChance" values are defaulted to "DMS_AI_destroyStaticWeapon_chance" or "DMS_AI_destroyVehicleChance" for static or regular vehicles, respectively.
* Optimization + code cleanup for "DMS_fnc_SpawnHeliReinforcement".

#### March 25, 2016 (6:00 PM CST-America):
* **NEW CONFIG VALUES:**

		DMS_AI_WP_Radius_heli
		DMS_AI_WP_Radius_heli
		DMS_RHeli_Height
		DMS_RHeli_MinDistFromDrop
		DMS_RHeli_MaxDistFromDrop
		DMS_RHeli_MinDistFromPlayers
		DMS_RareLootAmount
		DMS_ReinforcementHelis
* DMS Version is set in the "config.cpp", and grabbed in pre-init.
* You can now define how much rare loot to spawn.
* Limit # of attempts in "DMS_fnc_FindSafePos" to 5000.
* New function: DMS_fnc_FindSafePos_InRange; Uses "DMS_fnc_FindSafePos" and edits some variables to return a "safe" position within a certain area.
* New function: DMS_fnc_GetEmptySeats; Returns all empty seats in a vehicle. Not used by DMS, I thought I needed it and I realized I didn't afterwards.
* New function: DMS_fnc_HeliParatroopers_Monitor; Monitors helis/aircraft spawned for paratroopers. **NOT YET COMPLETE**
* New function: DMS_fnc_SpawnHeliReinforcement; Spawns a heli/aircraft with paratroopers for reinforcement. **NOT YET COMPLETE**
* New group reinforcement type: "heli_troopers". Changes most likely to come.
* You can now choose whether or not to destroy or simply unlock a used AI vehicle (with a random percentage chance).
* Slight optimizations here and there (more to come).

#### March 1, 2016 (12:30 AM CST-America):
* Initial Test Branch commit
* **NEW CONFIG VALUE:** DMS_SpawnMissions_Scheduled
* Several optimizations (mostly due to the new scripting commands introduced in 1.56)
* You can now spawn missions in scheduled environment.

### End "March 1, 2016" Test Branch
