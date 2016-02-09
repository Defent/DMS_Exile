/*
	DMS_fnc_SpawnAISoldier
	Created by eraser1
	Based off of WAI

	Usage:
	[
		_group,					// GROUP: Group the AI will belong to
		_pos,					// ARRAY (positionATL): Position of AI
		_class,					// STRING: Classname: "random","assault","MG","sniper" or "unarmed". Use "custom" to use "_customGearSet"
		_difficulty,			// STRING: Difficulty: "random","static","hardcore","difficult","moderate", or "easy"
		_side, 					// STRING: "bandit" only by default
		_type,					// STRING: Type of AI: "soldier","static","vehicle","heli", etc.
		_customGearSet			// (OPTIONAL) ARRAY: Manually defined AI gear.
	] call DMS_fnc_SpawnAISoldier;

	Usage for _customGearSet:
	[
		_weapon,				// String | EG: "LMG_Zafir_F"
		_weaponAttachments,		// Array of strings | EG: ["optic_dms","bipod_03_F_blk"]
		_magazines,				// Array of arrays | EG: [["150Rnd_762x54_Box",2],["16Rnd_9x21_Mag",3],["Exile_Item_InstaDoc",3]]
		_pistol,				// String | EG: "hgun_Pistol_heavy_01_snds_F"
		_pistolAttachments,		// Array of strings | EG: ["optic_MRD","muzzle_snds_acp"]
		_assignedItems,			// Array of strings | EG: ["Rangefinder","ItemGPS","NVGoggles"]
		_launcher,				// String | EG: "launch_RPG32_F"
		_helmet,				// String | EG: "H_HelmetLeaderO_ocamo"
		_uniform,				// String | EG: "U_O_GhillieSuit"
		_vest,					// String | EG: "V_PlateCarrierGL_blk"
		_backpack				// String | EG: "B_Carryall_oli"
	]

	Returns AI Unit
*/

private ["_OK", "_useCustomGear", "_unarmed", "_class", "_type", "_unit", "_side", "_nighttime", "_weapon", "_muzzle", "_suppressor", "_pistols", "_pistol", "_customGearSet", "_helmet", "_uniform", "_vest", "_backpack", "_launcher", "_magazines", "_weaponAttachments", "_pistolAttachments", "_assignedItems", "_difficulty", "_skillArray"];


_useCustomGear = false;
_unarmed = false;

if !(params
[
	["_group",grpNull,[grpNull]],
	["_pos",[0,0,0],[[]],[3]],
	["_class","random",[""]],
	["_difficulty","random",[""]],
	["_side","bandit",[""]],
	["_type","soldier",[""]]
])
then
{
	diag_log format ["DMS ERROR :: DMS_SpawnAISoldier called with invalid parameters: %1",_this];
}
else
{
	if ((_class == "custom") && {(count _this)>6}) then
	{
		_customGearSet = _this select 6;
		_useCustomGear = true;
	};
};

_difficulty =
	switch (toLower _difficulty) do
	{
		case "random":
		{
			DMS_ai_skill_random call BIS_fnc_selectRandom;
		};

		case "randomdifficult":
		{
			DMS_ai_skill_randomDifficult call BIS_fnc_selectRandom;
		};

		case "randomeasy":
		{
			DMS_ai_skill_randomEasy call BIS_fnc_selectRandom;
		};

		case "randomintermediate":
		{
			DMS_ai_skill_randomIntermediate call BIS_fnc_selectRandom;
		};

		default
		{
		    _difficulty;
		};
	};


//Create unit
_unit = _group createUnit [DMS_AI_Classname, _pos, [], 0,"FORM"];
_unit allowFleeing 0;
[_unit] joinSilent _group;

// Remove existing gear
{_unit removeWeaponGlobal _x;} 	forEach (weapons _unit);
{_unit unlinkItem _x;} 			forEach (assignedItems _unit);
{_unit removeItem _x;} 			forEach (items _unit);
removeAllItemsWithMagazines 	_unit;
removeHeadgear 					_unit;
removeUniform 					_unit;
removeVest 						_unit;
removeBackpackGlobal 			_unit;

// Give default items
if !(DMS_ai_default_items isEqualTo []) then
{
	{
		// "Why doesn't linkItem work with any of these? Because fuck you, that's why" - BIS
		if (_x in ["Binocular","Rangefinder","Laserdesignator","Laserdesignator_02","Laserdesignator_03"]) then
		{
			_unit addWeapon _x;
		}
		else
		{
			_unit linkItem _x;
		};
	} forEach DMS_ai_default_items;
};


if (_class == "unarmed") then
{
	_class = "assault";
	_unarmed = true;
}
else
{
	if (_class in DMS_ai_SupportedRandomClasses) then
	{
		_class = (missionNamespace getVariable [format["DMS_%1_AI",_class], DMS_random_AI]) call BIS_fnc_selectRandom;
	};
};

// Unit name
_unit setName format["[DMS %1 %2 Unit %3]",toUpper _side,_class,floor(random 1000)];

if (!_useCustomGear) then
{
	if !(_class in DMS_ai_SupportedClasses) exitWith
	{
		diag_log format ["DMS ERROR :: DMS_SpawnAISoldier called with unsupported _class: %1 | _this: %2",_class,_this];
		deleteVehicle _unit;
	};


	// Equipment (Stuff that goes in the toolbelt slots)
	{
		if (_x in ["Binocular","Rangefinder","Laserdesignator","Laserdesignator_02","Laserdesignator_03"]) then
		{
			_unit addWeapon _x;
		}
		else
		{
			_unit linkItem _x;
		};
	} forEach (missionNamespace getVariable [format ["DMS_%1_equipment",_class],[]]);


	// Items (Loot stuff that goes in uniform/vest/backpack)
	{_unit addItem _x;} forEach (missionNamespace getVariable [format ["DMS_%1_items",_class],[]]);


	// Clothes
	_unit addHeadgear 		((missionNamespace getVariable [format ["DMS_%1_helmets",_class],DMS_assault_helmets]) call BIS_fnc_selectRandom);
	_unit forceAddUniform 	((missionNamespace getVariable [format ["DMS_%1_clothes",_class],DMS_assault_clothes]) call BIS_fnc_selectRandom);
	_unit addVest 			((missionNamespace getVariable [format ["DMS_%1_vests",_class],DMS_assault_vests]) call BIS_fnc_selectRandom);
	_unit addBackpack 		((missionNamespace getVariable [format ["DMS_%1_backpacks",_class],DMS_assault_backpacks]) call BIS_fnc_selectRandom);

	// Make AI effective at night
	_nighttime = (sunOrMoon != 1);
	if (_nighttime) then
	{
		_unit linkItem "NVGoggles";
	};

	if (!_unarmed) then
	{
		_weapon = (missionNamespace getVariable [format ["DMS_%1_weps",_class],DMS_assault_weps]) call BIS_fnc_selectRandom;
		[_unit, _weapon, 6 + floor(random 3)] call BIS_fnc_addWeapon;
		_unit selectWeapon _weapon;


		if((random 100) <= (missionNamespace getVariable [format["DMS_%1_optic_chance",_class],0])) then
		{
			_unit addPrimaryWeaponItem ((missionNamespace getVariable [format ["DMS_%1_optics",_class],DMS_assault_optics]) call BIS_fnc_selectRandom);
		};

		if (_nighttime && {(random 100) <= DMS_ai_nighttime_accessory_chance}) then
		{
			_unit addPrimaryWeaponItem (["acc_pointer_IR","acc_flashlight"] call BIS_fnc_selectRandom);
		};

		if((random 100) <= (missionNamespace getVariable [format["DMS_%1_bipod_chance",_class],0])) then
		{
			_unit addPrimaryWeaponItem (DMS_ai_BipodList call BIS_fnc_selectRandom);
		};

		if((random 100) <= (missionNamespace getVariable [format["DMS_%1_suppressor_chance",_class],0])) then
		{
			_suppressor = _weapon call DMS_fnc_FindSuppressor;
			if(_suppressor != "") then
			{
				_unit addPrimaryWeaponItem _suppressor;
			};
		};

		// In case spawn position is water
		if (DMS_ai_enable_water_equipment && {surfaceIsWater _pos}) then
		{
			removeHeadgear _unit;
			removeAllWeapons _unit;
			_unit forceAddUniform "U_O_Wetsuit";
			_unit addVest "V_RebreatherIA";
			_unit addGoggles "G_Diving";
			[_unit, "arifle_SDAR_F", 4 + floor(random 3), "20Rnd_556x45_UW_mag"] call BIS_fnc_addWeapon;
		};

		_pistols = missionNamespace getVariable [format ["DMS_%1_pistols",_class],[]];
		if !(_pistols isEqualTo []) then
		{
			_pistol = _pistols call BIS_fnc_selectRandom;
			[_unit, _pistol, 2 + floor(random 2)] call BIS_fnc_addWeapon;
		};

		// Infinite Ammo
		// This will NOT work if AI unit is offloaded to client
		_unit addeventhandler ["Fired", {(vehicle (_this select 0)) setvehicleammo 1;}];
	};
}
else
{
	if !(_customGearSet params
	[
		["_weapon","",[""]],
		["_weaponAttachments",[],[[]]],
		["_magazines",[],[[]]],
		["_pistol","",[""]],
		["_pistolAttachments",[],[[]]],
		["_assignedItems",[],[[]]],
		["_launcher","",[""]],
		["_helmet","",[""]],
		["_uniform","",[""]],
		["_vest","",[""]],
		["_backpack","",[""]]
	])
	then
	{
		diag_log format ["DMS ERROR :: Calling DMS_SpawnAISoldier with invalid _customGearSet: %1 | _this: %2",_customGearSet,_this];
	};

	if (DMS_DEBUG) then
	{
		(format ["SpawnAISoldier :: Equipping unit %1 with _customGearSet: %2",_unit,_customGearSet]) call DMS_fnc_DebugLog;
	};

	// Clothes
	if !(_helmet isEqualTo "") then
	{
		_unit addHeadgear _helmet;
	};

	if !(_uniform isEqualTo "") then
	{
		_unit forceAddUniform _uniform;
	};

	if !(_vest isEqualTo "") then
	{
		_unit addVest _vest;
	};

	if !(_backpack isEqualTo "") then
	{
		_unit addBackpack _backpack;
	};

	if !(_launcher isEqualTo "") then
	{
		[_unit, _launcher, 0] call BIS_fnc_addWeapon;
	};


	// Add Magazines before weapon so that gun will be loaded
	{
		if (_x isEqualType "") then
		{
			_x = [_x,1];
		};
		_unit addMagazines _x;
	} forEach _magazines;

	// Add items
	{
		if (_x in ["Binocular","Rangefinder","Laserdesignator","Laserdesignator_02","Laserdesignator_03"]) then
		{
			_unit addWeapon _x;
		}
		else
		{
			_unit linkItem _x;
		};
	} forEach _assignedItems;


	// Add pistol and attachments
	if !(_pistol isEqualTo "") then
	{
		[_unit, _pistol, 0] call BIS_fnc_addWeapon;

		{
			_unit addHandgunItem _x;
		} forEach _pistolAttachments;
	};


	// Add gun and attachments
	if !(_weapon isEqualTo "") then
	{
		[_unit, _weapon, 0] call BIS_fnc_addWeapon;

		{
			_unit addPrimaryWeaponItem _x;
		} forEach _weaponAttachments;

		_unit selectWeapon _weapon;
	};
};

{
	_unit setSkill _x;
} forEach (missionNamespace getVariable [format["DMS_ai_skill_%1",_difficulty],[]]);


// Soldier killed event handler
_unit addMPEventHandler ["MPKilled",'if (isServer) then {_this call DMS_fnc_OnKilled;};'];

// Remove ramming damage from players. Also remove any damage within 5 seconds of spawning.
// Will not work if unit is not local (offloaded)
if (DMS_ai_disable_ramming_damage) then
{
	_unit addEventHandler ["HandleDamage",
	{
		_dmg = _this select 2;
		_source = _this select 3;
		_projectile = _this select 4;

		if ((_projectile isEqualTo "") && {isPlayer _source}) then
		{
			_dmg = 0;
		};

		_dmg
	}];
};


{
	_unit enableAI _x;
} forEach ["TARGET", "AUTOTARGET", "MOVE", "ANIM", "FSM"];

if (_difficulty=="hardcore") then
{
	// Make him a little bit harder ;)
	{
		_unit disableAI _x;
	} forEach ["SUPPRESSION", "AIMINGERROR"];
};

_unit setCustomAimCoef (missionNamespace getVariable [format["DMS_AI_AimCoef_%1",_difficulty], 0.7]);
_unit enableStamina (missionNamespace getVariable [format["DMS_AI_EnableStamina_%1",_difficulty], true]);


_unit setVariable ["DMS_AISpawnTime", time];
_unit setVariable ["DMS_AI_Side", _side];
_unit setVariable ["DMS_AI_Type", _type];

if (_type=="Soldier") then
{
	_unit setVariable ["DMS_AISpawnPos",_pos];
	_unit setVariable ["DMS_LastAIDistanceCheck",time];
};

if (DMS_DEBUG) then
{
	(format ["SpawnAISoldier :: Spawned a %1 %2 %6 AI at %3 with %4 difficulty to group %5",_class,_side,_pos,_difficulty,_group,_type]) call DMS_fnc_DebugLog;
};



_unit
