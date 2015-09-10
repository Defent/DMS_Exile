# Instructions
See also: http://www.exilemod.com/forum/topic/61-dms-defents-mission-system/

## To install:
Put the pre-packed PBO in your ```@ExileServer\addons\``` directory. It should be alongside ```exile_server``` and ```exile_server_config```.

### NOTE: It is heavily suggested that you use [The Unofficial Exile v0.9.19 SP3](http://www.exilemod.com/forums/topic/exile-server-0-9-19-rse-sp3-unofficial-download-here/) with DMS, as it will resolve several issues.

If you are using infiSTAR and want to keep ```_CGM = true;```, then set ```_UMW = true;```, and add ```DMS_MissionMarkerCircle```, ```DMS_MissionMarkerDot``` to ```_aLocalM```,
so your ```_aLocalM``` would look like:

```
    _aLocalM = ["DMS_MissionMarkerCircle","DMS_MissionMarkerDot"];
```
## IF YOU ARE UPDATING YOUR DMS FROM BEFORE THE 5th OF SEPTEMBER, PLEASE READ BELOW:
The crate loot system has undergone an improvement. You can now define loot values for different crates for the same mission, or none at all!
HOWEVER: This requires you to change the organization of the crate in the mission.

Previously, _missionObjs was defined with the format:
```
[
	[_cleanupObj1,_cleanupObj2,...,_cleanupObjX],
	[_crate,_vehicle1,_vehicle2,...,_vehicleX],
	_crate_loot_values
]
```


Now you must define it as:
```
[
	[_cleanupObj1,_cleanupObj2,...,_cleanupObjX],
	[_vehicle1,_vehicle2,...,_vehicleX],
	[
		[_crate1,_crate_loot_values1],
		[_crate2,_crate_loot_values2]
	]
]
```

Please refer to the current default missions if you are unsure. The Bauhaus truck mission shows an example of spawning 2 crates.

## Optional:


### To modify the config:
* Download the a3_dms folder
* Edit the config.sqf to your preferences.
* Pack the a3_dms folder with a PBO tool (**PBO Manager**, Eliteness, or Arma 3 Tools suite)
* Follow the "To install:" steps using the PBO you just created instead of the pre-packed one.


### ~~HEADLESS CLIENT:~~
![Warning](https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Achtung.svg/200px-Achtung.svg.png)

**Headless Client is currently broken in ArmA as of the 4th of September, do not use it as it WILL crash your server.**

~~Add this code to the TOP of your initPlayerLocal.sqf~~ 

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
#### Thanks:
- [Defent](https://github.com/Defent) for creating Defent's Mission System.
- [eraser1](https://github.com/eraser1) for his constant codebase improvments.
- [Zupa](https://github.com/Windmolders) for suggestions and coding help.
- [Nawuko](https://github.com/Nawuko) for catching a silly mistake :P
- [shaworth](https://github.com/shaworth) and [KawaiiPotato](https://github.com/KawaiiPotato) for making the README all nice and pretty :)
- Everbody's feedback on [the DMS thread on exile forums](http://www.exilemod.com/forums/topic/dms-defents-mission-system/#post-10353)


## Changelog:
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
