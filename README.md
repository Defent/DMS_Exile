# To the User:
####Read through the instructions carefully. Before leaving any questions regarding DMS, please read through the [DMS "config.sqf"](https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/config.sqf) ; the majority of the questions we receive are answered (directly or indirectly) by the config.

####Disclaimer:
Defent's Mission System (DMS) is written from the ground up to be an efficient, easy to install, and vastly customizable mission system for the ArmA 3 [Exile Mod](http://www.exilemod.com/). You are perfectly welcome to port DMS or any of its functions for any other mod or (legal) purposes; and leaving credits is appreciated.

However, creating such a mission system takes a lot of time and testing. We (the authors of DMS) are not perfect, and as a result, there may be bugs, glitches, and/or errors within DMS. We appreciate your co-operation in identifying and resolving such issues to improve DMS; however we are not liable for any issues resulting from the usage of DMS on/by your server. We are also not liable to help you in resolving any issues that may arise, although we will attempt to help you to some degree in most cases.


___


# Instructions
See also: http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=242

## To install:
Put the pre-packed PBO in your ```@ExileServer\addons\``` directory. It should be alongside ```exile_server``` and ```exile_server_config```.

If you are using Vilayer or some other GameServer hosting service, and/or the above step did not work, then create a new folder called @a3_dms in the root ArmA 3 folder, create a subfolder called "addons", and place the "a3_dms.pbo" in the "addons" subfolder. Then, edit your startup parameters/modline to include "@a3_dms". For example: ```-serverMod=@ExileServer;@a3_dms;```

## infiSTAR:
If you are using infiSTAR and want to keep ```_CGM = true;```, then set ```_UMW = true;``` (the latest version of infiSTAR already has DMS markers whitelisted in ```_aLocalM```).

## Optional:


### To modify the config:
1. Download the a3_dms folder
2. Edit the config.sqf to your preferences.
3. Pack the a3_dms folder with a PBO tool (**PBO Manager**, Eliteness, or Arma 3 Tools suite)
4. Follow the ["To install:" steps](https://github.com/Defent/DMS_Exile#to-install) using the PBO you just created instead of the pre-packed one.


### HEADLESS CLIENT:

**The way DMS utilizes HC is unfavorable for large maps. As a result, we are dropping HC support for DMS until it is completed, then we will create proper Headless Client support.**

People have reported Headless Client working properly in ArmA v1.52

Add this code to the TOP of your initPlayerLocal.sqf

```
if (!hasInterface && !isServer) then
{
	1 spawn
	{
		waitUntil {player==player};
		DMS_HC_Object = player;
		publicVariableServer "DMS_HC_Object";
	};
};
```

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
- Everbody's feedback on [the DMS thread on exile forums](http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=242)
- Finally, the entire ExileMod team, without them, you wouldn't have us. Show them some love!

___

# Changelog:
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
