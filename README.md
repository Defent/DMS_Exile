# Instructions
See also: http://www.exilemod.com/forums/topic/dms-defents-mission-system/#post-10434 

## To install:
Put the pre-packed PBO in your ```@ExileServer\addons\``` directory. It should be alongside ```exile_server``` and ```exile_server_config```.

If you are using infiSTAR and want to keep ```_CGM = true;```, then set ```_UMW = true;```, and add ```DMS_MissionMarkerCircle```, ```DMS_MissionMarkerDot``` to ```_aLocalM```,
so your ```_aLocalM``` would look like:

```
    _aLocalM = ["DMS_MissionMarkerCircle","DMS_MissionMarkerDot"];
```

## OPTIONAL:
* Download the a3_dms folder
* Ddit the config.sqf to your preferences.
* Repack the a3_dms folder with a PBO tool
* Follow the "To install:" steps :D


## ~~HEADLESS CLIENT:~~
![Warning](https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Achtung.svg/200px-Achtung.svg.png)

DO NOT USE HEADLESS CLIENT. IT IS CURRENTLY BUGGED AS OF SEPTEMBER 4TH, 2015. 
IT WILL CRASH YOUR SERVER

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
