# Instructions
See also: http://www.exilemod.com/forums/topic/dms-defents-mission-system/#post-10434 

## To install:
Put the pre-packed PBO in your ```@ExileServer\addons\``` directory. It should be alongside ```exile_server``` and ```exile_server_config```.

If you are using infiSTAR and want to keep ```_CGM = true;```, then set ```_UMW = true;```, and add ```DMS_MissionMarkerCircle```, ```DMS_MissionMarkerDot``` to ```_aLocalM```,
so your ```_aLocalM``` would look like:

```
    _aLocalM = ["DMS_MissionMarkerCircle","DMS_MissionMarkerDot"];
```


## Optional:


### To modify the config:
* Download the a3_dms folder
* Edit the config.sqf to your preferences.
* Pack the a3_dms folder with a PBO tool (**PBO Manager** or Arma 3 Tools suite)
* Follow the "To install:" steps useing the PBO you just created instead of the pre-packed one.


### ~~HEADLESS CLIENT:~~
![Warning](https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Achtung.svg/200px-Achtung.svg.png)

**Headless client is currently broken as of the 4th of September, do not use it as it WILL crash your server.**

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
- [shaworth](https://github.com/shaworth) for making the README all nice and pretty :)
- [Defent] for creating Defent's Mission System.
- [eraser1] for his constant codebase improvments.
