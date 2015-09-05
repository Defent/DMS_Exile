# Instructions
See also: http://www.exilemod.com/forums/topic/dms-defents-mission-system/#post-10434 

## To install:
Put the pre-packed PBO in your ```@ExileServer\addons\``` directory. It should be alongside ```exile_server``` and ```exile_server_config```.

If you are using infiSTAR and want to keep ```_CGM = true;```, then set ```_UMW = true;```, and add ```DMS_MissionMarkerCircle```, ```DMS_MissionMarkerDot``` to ```_aLocalM```,
so your ```_aLocalM``` would look like:

```
    _aLocalM = ["DMS_MissionMarkerCircle","DMS_MissionMarkerDot"];
```
## IF YOU ARE UPDATING YOUR DMS FROM BEFORE THE 5th OF SEPTEMBER, PLEASE READ BELOW:
The crate loot system has undergone an improvement. You can now define loot values for different crates for the same mission, or none at all!
HOWEVER: This requires you to change the organization of the crate in the mission.

Previously, you _missionObjs was defined with the format:
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
- [shaworth](https://github.com/shaworth) and [KawaiiPotato](https://github.com/KawaiiPotato) for making the README all nice and pretty :)


## Changelog:
#### September 4, 2015 (11:20 PM CST-America):
* Improved crate handling by DMS. You can now spawn multiple crates with different loot, or simply no crates at all. (REQUIRES FILE CHANGES FOR EACH MISSION)
* Accounted for case sensitivity in switch-do statements for SpawnAISolder.
* Decreased default amount of money/respect gain on AI kills (Used to be 100 poptabs and 25 respect, it is now 50 poptabs and 10 respect)
* Define functions in config.cpp. This resulted in ALL FILES being changed to some degree.
* Fixed spawning Binocs and Rangefinders/Designators on AI.