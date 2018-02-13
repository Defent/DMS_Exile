![ArmA 1.80](https://img.shields.io/badge/Arma-1.80-blue.svg) ![Exile 1.0.3 "Lemon"](https://img.shields.io/badge/Exile-1.0.3%20Lemon-C72651.svg) ![DMS Version](https://img.shields.io/badge/DMS%20Version-2018--02--12-blue.svg)


# To the User:
#### Read the instructions carefully. Before leaving any questions regarding DMS, please read through the [DMS "config.sqf"](https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/config.sqf?ts=4); the majority of the questions we receive are answered (directly or indirectly) by the config.

#### Disclaimer:
Defent's Mission System (DMS) is written from the ground up to be an efficient, easy to install, and vastly customizable mission system for the ArmA 3 [Exile Mod](http://www.exilemod.com/).

However, creating such a mission system takes a lot of time and testing. We (the authors of DMS) are not perfect, and as a result, there may be bugs, glitches, and/or errors within DMS. We appreciate your co-operation in identifying and resolving such issues to improve DMS; however we are not liable for any issues resulting from the usage of DMS on/by your server. We are also not liable to help you in resolving any issues that may arise.

You are welcome to port DMS or any of its functions for any other mod or (legal) purposes. For more information read the License Overview below:

### License Overview:
This work is protected by [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](http://creativecommons.org/licenses/by-nc-sa/4.0/). By using, downloading, or copying any of the work contained, you agree to the license included.

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">DMS</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/Defent/DMS_Exile" property="cc:attributionName" rel="cc:attributionURL">Defent and eraser1</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/Defent/DMS_Exile" rel="dct:source">https://github.com/Defent/DMS_Exile</a>.

The following overview is a human-readable summary of (and not a substitute for) [the full license](http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode).

#### You are free to:

**Share** — copy and redistribute the material in any medium or format.

**Adapt** — remix, transform, and build upon the material.



#### Under the following terms:

**Attribution** — You must give **appropriate credit**, provide a link to the license, and **indicate if changes were made**. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

**NonCommercial** — You may not use the material for commercial purposes.

**ShareAlike** — If you remix, transform, or build upon the material, you must distribute your contributions under the **same license** as the original.

**No additional restrictions** — You may not apply legal terms or **technological measures** that legally restrict others from doing anything the license permits.



#### Notices:

You do not have to comply with the license for elements of the material in the public domain or where your use is permitted by an applicable **exception or limitation**.
No warranties are given. The license may not give you all of the permissions necessary for your intended use. For example, other rights such as **publicity, privacy, or moral rights** may limit how you use the material.


___


# Instructions
[Please search the DMS thread before asking any questions](http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=242)
DMS will work "out-of-the-box" for almost any map. You have to keep in mind that if the map is too small (such as Stratis), then you will need to reduce the [Mission spawn location settings](https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/config.sqf?ts=4). Also, for especially hilly maps (such as Panthera), you will need to reduce the [Minimum surfaceNormal](https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/config.sqf?ts=4) (the config value is automatically adjusted for some maps. You can check the [map configs](https://github.com/Defent/DMS_Exile/tree/master/%40ExileServer/addons/a3_dms/map_configs) to see the adjusted config value overwrites).

## BattlEye Filters:
It is highly recommended that you add

```
!="(_this select 0) execVM \"\A3\Structures_F\Wrecks\Scripts\Wreck_Heli_Attack_01.sqf\""
```

at ***the END of the line that starts with "7 exec" in scripts.txt*** (if it exists). [Here is the pastebin](http://pastebin.com/W8bH252U).

***AND:***

```
!="_v)} do {\n_posV = getPos _v;\n_smoke1 = \"#particlesource\" createVehicleLocal getpos _v;\n_smoke1 attachTo [_v,[0,0,0],\"engine_effe"
```
after "7 createVehicle"


## Installation:


1. Download the [a3_dms](https://github.com/Defent/DMS_Exile/tree/master/%40ExileServer/addons/a3_dms) folder
2. Edit the [config.sqf](https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/config.sqf?ts=4) to your preferences.
3. Pack the a3_dms folder with a PBO tool ([PBO Manager](http://www.armaholic.com/page.php?id=16369), [Eliteness](https://dev.withsix.com/projects/mikero-pbodll/files), or [the Arma 3 Tools suite](http://store.steampowered.com/app/233800/))
4. Put the generated PBO in your ```@ExileServer\addons\``` directory. It should be alongside ```exile_server.pbo``` and ```exile_server_config.pbo```.

<br>
## infiSTAR:
* If you want to enable "VehicleWhiteList_check", make sure to add ```'O_HMG_01_high_F'``` to ```_VehicleWhiteList```, as well as any other vehicles you add to DMS that are not whitelisted.

<br><br>
### Vilayer or other Game Server Providers Instructions:

If you are using Vilayer or some other GameServer hosting service, and/or the above steps did not work, then follow these instructions:

1. Create a new folder called @a3_dms in the root ArmA 3 folder.
2. Create a subfolder called "addons".
3. Place the "a3_dms.pbo" in the "addons" subfolder.
4. Edit your startup parameters/modline to include "@a3_dms". For example: ```-serverMod=@ExileServer;@a3_dms;```

<br><br>

## Troubleshooting:
If you're having any issues with DMS, check your RPT for errors and make sure PBO is packed correctly by unpacking it and ensuring the folder structure is "\x\addons\a3_DMS\...".

If you can't figure it out, leave a post on [the DMS thread on exile forums](http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=242). **Make sure to include your RPT, config.sqf, as well as any changed files. Please use [pastebin](http://pastebin.com/), spoilers, or something similar; DO NOT PASTE EVERYTHING DIRECTLY INTO THE POST (without putting it in a spoiler)**

<br><br>
### HEADLESS CLIENT:

**DMS does not currently support headless client. Do not attempt to use HC with DMS unless you know what you are doing.**

___
<br><br>

# Credits:
### Authors:
- [Defent](https://github.com/Defent) from [NumenaDayZ](http://numenadayz.com/).
- [eraser1](https://github.com/eraser1) from [TrainwreckDayZ](http://www.trainwreckdayz.com/home).
- [secondcoming](https://github.com/secondcoming) from [ExileYorkshire](http://exileyorkshire.co.uk/).


### Thanks:
- [Zupa](https://github.com/Windmolders) for suggestions and coding help.
- [Nawuko](https://github.com/Nawuko) for catching a silly mistake :P
- [shaworth](https://github.com/shaworth) and [KawaiiPotato](https://github.com/KawaiiPotato) for making the README all nice and pretty :)
- [maca134](http://maca134.co.uk/portfolio/m3editor-arma-3-map-editor/) for M3Editor Stuff
- [Darth Rogue from SOA](http://soldiersofanarchy.net/) for the awesome base for the first DMS static mission :D
- [William from Refugees of the Fallen](http://rtfgaming.com/) for the amazing slums static mission base and ideas :)
- [DONKEYPUNCH](https://github.com/donkeypunchepoch) for everything on the [February 17th 2016 commit](https://github.com/Defent/DMS_Exile/wiki/Changelog#february-17-2016-600-pm-cst-america) ;)
- [MGTDB](https://github.com/MGTDB) for the plethora of fixes, testing, and all-around doing our work for us :P
- Everybody's feedback on [the DMS thread on exile forums](http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=242)

#### Testers/Reporters:
- [William from Refugees of the Fallen](http://rtfgaming.com/)
- [JamieKG from Eternal Gamer](http://eternal-gamer.com/)
- [Valthos from The Altis Project](https://www.thealtisproject.co.uk/)
- [Flowrider from Optimum Gaming](http://www.optimum-multigaming.com/)
- [CEN from ATD Gaming](http://atdgaming.com/)

___
<br><br><br>

# Ideas:
### Zombies are NOT SUPPORTED by DMS, nor do we ever plan to support zombies within DMS.

#### Convoy Mission:
* Regularly update marker position.
* Implement function(s) for AI pathing.

#### Dynamic Underwater Missions

#### Dynamic/Ambient AI Spawning
* Spawn AI that are meant to "hunt" individual players.
* Air/Land AI Vehicle Patrols

#### Random community ideas:
* Spawning in a trader on mission completion ([Trillseeker82](http://www.exilemod.com/topic/61-dms-defents-mission-system/?do=findComment&comment=43932)).

#### Full Headless Client Support.
* AI will still be offloaded to clients (ideally); strictly DMS functions will be handled by the HC.


___
<br><br><br>

# Changelog:
https://github.com/Defent/DMS_Exile/wiki/Changelog
