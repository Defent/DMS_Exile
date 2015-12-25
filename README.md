# To the User:
####Read the instructions carefully. Before leaving any questions regarding DMS, please read through the [DMS "config.sqf"](https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/config.sqf); the majority of the questions we receive are answered (directly or indirectly) by the config.

####Disclaimer:
Defent's Mission System (DMS) is written from the ground up to be an efficient, easy to install, and vastly customizable mission system for the ArmA 3 [Exile Mod](http://www.exilemod.com/). You are welcome to port DMS or any of its functions for any other mod or (legal) purposes. Providing credit is appreciated.

However, creating such a mission system takes a lot of time and testing. We (the authors of DMS) are not perfect, and as a result, there may be bugs, glitches, and/or errors within DMS. We appreciate your co-operation in identifying and resolving such issues to improve DMS; however we are not liable for any issues resulting from the usage of DMS on/by your server. We are also not liable to help you in resolving any issues that may arise, although we will attempt to help you to some degree in most cases.


___


# Instructions
[Please search the DMS thread before asking any questions](http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=242)
DMS will work "out-of-the-box" for almost any map. You have to keep in mind that if the map is too small (such as Stratis), then you will need to reduce the [Mission spawn location settings](https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/config.sqf#L63-L77). Also, for especially hilly maps (such as Panthera), you will need to reduce the [Minimum surfaceNormal](https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/config.sqf#L76) (the config value is automatically adjusted for some maps. You can check the [map configs](https://github.com/Defent/DMS_Exile/tree/master/%40ExileServer/addons/a3_dms/map_configs) to see the adjusted config value overwrites).

## BattlEye Filters:
It is highly recommended that you add

```
!="(_this select 0) execVM \"\A3\Structures_F\Wrecks\Scripts\Wreck_Heli_Attack_01.sqf\""
```

at ***the END of the line that starts with "7 exec" in scripts.txt*** . [Here is the pastebin](http://pastebin.com/W8bH252U).

***AND:***

```
!="_v)} do {\n_posV = getPos _v;\n_smoke1 = \"#particlesource\" createVehicleLocal getpos _v;\n_smoke1 attachTo [_v,[0,0,0],\"engine_effe"
```
after "7 createVehicle"


## Installation:


1. Download the [a3_dms](https://github.com/Defent/DMS_Exile/tree/master/%40ExileServer/addons/a3_dms) folder
2. Edit the [config.sqf](https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/config.sqf) to your preferences.
3. Pack the a3_dms folder with a PBO tool ([PBO Manager](http://www.armaholic.com/page.php?id=16369), [Eliteness](https://dev.withsix.com/projects/mikero-pbodll/files), or [the Arma 3 Tools suite](http://store.steampowered.com/app/233800/))
4. Put the generated PBO in your ```@ExileServer\addons\``` directory. It should be alongside ```exile_server.pbo``` and ```exile_server_config.pbo```.


## infiSTAR:
* If you are using infiSTAR and want to keep ```_CGM = true;```, then set ```_UMW = true;```.
* Add ```'O_HMG_01_high_F'``` to "_VehicleWhiteList", as well as any other vehicles you add to DMS that are not whitelisted.


### Vilayer or other Game Server Providers Instructions:

If you are using Vilayer or some other GameServer hosting service, and/or the above steps did not work, then follow these instructions:

1. Create a new folder called @a3_dms in the root ArmA 3 folder.
2. Create a subfolder called "addons".
3. Place the "a3_dms.pbo" in the "addons" subfolder.
4. Edit your startup parameters/modline to include "@a3_dms". For example: ```-serverMod=@ExileServer;@a3_dms;```


### HEADLESS CLIENT:

**DMS does not currently support headless client. Do not attempt to use HC with DMS unless you know what you are doing.**

## Troubleshooting:
DMS won't spawn missions? Check RPT for config errors or make sure PBO is packed correctly by unpacking it and ensuring the folder structure is "\x\addons\a3_DMS\...".

If you can't figure it out, leave a post on [the DMS thread on exile forums](http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=242). **Make sure to include your RPT, config.sqf, as well as any changed files.**

___

# Credits:
### Authors:
- [Defent](https://github.com/Defent) from [NumenaDayZ](http://numenadayz.com/).
- [eraser1](https://github.com/eraser1) from [TrainwreckDayZ](http://www.trainwreckdayz.com/home).


### Thanks:
- [Zupa](https://github.com/Windmolders) for suggestions and coding help.
- [Nawuko](https://github.com/Nawuko) for catching a silly mistake :P
- [shaworth](https://github.com/shaworth) and [KawaiiPotato](https://github.com/KawaiiPotato) for making the README all nice and pretty :)
- [maca134](http://maca134.co.uk/portfolio/m3editor-arma-3-map-editor/) for M3Editor Stuff
- [Darth Rogue from SOA](http://soldiersofanarchy.net/) for the awesome base for the first DMS static mission :D
- [William from Refugees of the Fallen](http://refugeesofthefallen.enjin.com/) for the amazing slums static mission base and ideas :)
- [JamieKG from Eternal Gamer](http://eternal-gamer.com/) for testing and reporting issues.
- [Valthos from The Altis Project](https://www.thealtisproject.co.uk/) for testing and reporting issues.
- Everbody's feedback on [the DMS thread on exile forums](http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=242)

___

# Roadmap:
#### Continuous Optimization + Improvements.
* ~~Implement the ability to "freeze" and "unfreeze" AI when there are no players nearby to improve performance. This will be under testing with a few selected server owners/community members. If you would like to participate in testing, please send a PM to [eraser1 on Exile Forums](http://www.exilemod.com/profile/96-eraser1/).~~ _This feature is slated for a future date_

#### AI Heli Paratroopers/air support.

#### Convoy Mission:
* Regularly update marker position.
* Implement function(s) for AI pathing.

#### Underwater Missions

#### Dynamic/Ambient AI Spawning
* Spawn AI that are meant to "hunt" individual players.
* Air/Land AI Vehicle Patrols

#### Random community ideas:
* Spawning in a trader on mission completion ([Trillseeker82](http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=43932)).

#### Full Headless Client Support.

#### Client Features.
* Kill messages when a group member kills an AI.
* Custom mission announcement messages.

#### (Maybe) Implement a form of stat-tracking system
* It will store AI kills in the database (this would almost certainly require some extra work on the behalf of server owners).

___

# Changelog:
#### December 24, 2015 (1:45 PM CST-America):
* Fixed an issue where you couldn't take stuff out of a crate if you had "DMS_EnableBoxMoving" set to "false". Thanks to [Flowrider](http://www.exilemod.com/profile/31-flowrider85/) for the report.
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
	* Credit for the base goes to [William from Refugees of the Fallen](http://refugeesofthefallen.enjin.com/)
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
* Added support for 2 new optional parameters: _onMonitorStart and _onMonitorEnd, run before and after the Mission Monitor checks the mission, respectively, but AFTER "Mission Success State" is checked.
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
* You can now define a custom function for DMS_FillCrate. It will be passed params from _lootValues select 0. **I haven't tested this at all. Just keep that in mind ;)**
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
* "_customGearSet" should now actually work for "DMS_fnc_SpawnAISoldier", and the function title comment has been updated for the slightly tweaked syntax.


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
* Fixed a couple typos in "DMS_fnc_SpawnAISoldier". "_customGearSet" should work now (although I'm fairly certain nobody uses it since nobody ever complained :P )
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
