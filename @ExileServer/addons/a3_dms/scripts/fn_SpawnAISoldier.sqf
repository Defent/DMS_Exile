/*
	DMS_fnc_SpawnAISoldier
	Created by eraser1
	Based off of WAI

	Usage:
	[
		_group,					// GROUP: Group the AI will belong to
		_pos,					// ARRAY (positionATL): Position of AI
		_class,					// STRING: Classname: "random","assault","MG", or "sniper".
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

	Returns AI Object
*/
// Enabling this ensures that any optic/bipod/accessory that isn't compatible with a weapon cannot be selected. (Doesn't apply to custom gear sets)
// Disabled for now because BIS loves to break things all the time.
//#define USE_EXTRA_CHECKING 1

private _customGearSet = [];

if !(params
[
	"_group",
	"_pos",
	"_class",
	"_difficulty",
	"_side",
	"_type"
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
	};
};

_difficulty =
	switch (toLower _difficulty) do
	{
		case "random":
		{
			selectRandom DMS_ai_skill_random;
		};

		case "randomdifficult":
		{
			selectRandom DMS_ai_skill_randomDifficult;
		};

		case "randomeasy":
		{
			selectRandom DMS_ai_skill_randomEasy;
		};

		case "randomintermediate":
		{
			selectRandom DMS_ai_skill_randomIntermediate;
		};

		default
		{
		    _difficulty;
		};
	};


//Create unit
private _unit = _group createUnit [DMS_AI_Classname, _pos, [], 0,"FORM"];
_unit allowFleeing 0;

// Remove existing gear
{_unit removeWeaponGlobal _x;} 	forEach (weapons _unit);
{_unit unlinkItem _x;} 			forEach (assignedItems _unit);
{_unit removeItem _x;} 			forEach (items _unit);
removeAllItemsWithMagazines 	_unit;
removeHeadgear 					_unit;
removeUniform 					_unit;
removeVest 						_unit;
removeBackpackGlobal 			_unit;


if (_class in DMS_ai_SupportedRandomClasses) then
{
	_class = selectRandom (missionNamespace getVariable [format["DMS_%1_AI",_class], DMS_random_AI]);
};

// Set random DMS unit names if you don't want Arma assigned (real names)
switch (DMS_AI_NamingType) do
{
	case 1:
	{
		_unit setName format["[DMS %1 %2 %3]",toUpper _side,_class,floor(random 1000)];
	};

	case 2:
	{
		_unit setName format["%1 %2", selectRandom DMS_AI_FirstNames, selectRandom DMS_AI_LastNames];
	};

	default {};		// Default ArmA names otherwise...
};


if (_customGearSet isEqualTo []) then
{
	// Make sure the "_class" is supported. This check is moved here to maintain backwards compatibility.
	if !(_class in DMS_ai_SupportedClasses) exitWith
	{
		diag_log format ["DMS ERROR :: DMS_SpawnAISoldier called with unsupported _class: %1 | _this: %2",_class,_this];
	};


	// Add Clothes first to make sure the unit can store everything...
	_unit addHeadgear 		(selectRandom (missionNamespace getVariable [format ["DMS_%1_helmets",_class],DMS_assault_helmets]));
	_unit forceAddUniform 	(selectRandom (missionNamespace getVariable [format ["DMS_%1_clothes",_class],DMS_assault_clothes]));
	_unit addVest 			(selectRandom (missionNamespace getVariable [format ["DMS_%1_vests",_class],DMS_assault_vests]));
	_unit addBackpackGlobal	(selectRandom (missionNamespace getVariable [format ["DMS_%1_backpacks",_class],DMS_assault_backpacks]));


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



	// Random items that can be added to the unit's inventory, such as food, meds, etc.
	private _randItemCount = missionNamespace getVariable [format ["DMS_%1_RandItemCount",_class],0];
	if (_randItemCount>0) then
	{
		private _randItems = missionNamespace getVariable [format ["DMS_%1_RandItems",_class],["Exile_Item_PlasticBottleFreshWater"]];
		for "_i" from 1 to _randItemCount do
		{
			_unit addItem (selectRandom _randItems);
		};
	};


	// Items (Loot stuff that goes in uniform/vest/backpack)
	{_unit addItem _x;} forEach (missionNamespace getVariable [format ["DMS_%1_items",_class],[]]);

	// Make AI effective at night
	private _nighttime = (sunOrMoon != 1);
	if (_nighttime) then
	{
		_unit linkItem "NVGoggles";
	};


	private _weapon = selectRandom (missionNamespace getVariable [format ["DMS_%1_weps",_class],DMS_assault_weps]);
	[_unit, _weapon, 6 + floor(random 3)] call DMS_fnc_AddWeapon;
	_unit selectWeapon _weapon;


#ifdef USE_EXTRA_CHECKING
	// "Guaranteed" method of finding/adding weapon attachments.
	if ((random 100) <= (missionNamespace getVariable [format["DMS_%1_optic_chance",_class],0])) then
	{
		private _optic = selectRandom
		(
			(missionNamespace getVariable [format ["DMS_%1_optics",_class],DMS_assault_optics]) arrayIntersect
			(getArray (configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "CowsSlot"))
		);

		if !(isNil "_optic") then
		{
			_unit addPrimaryWeaponItem _optic;
		};
	};

	if (_nighttime && {(random 100) <= DMS_ai_nighttime_accessory_chance}) then
	{
		private _accessory = selectRandom (getArray (configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "PointerSlot"));

		if !(isNil "_accessory") then
		{
			_unit addPrimaryWeaponItem _accessory;
		};
	};

	if ((random 100) <= (missionNamespace getVariable [format["DMS_%1_bipod_chance",_class],0])) then
	{
		private _bipod = selectRandom
		(
			DMS_AI_BipodList arrayIntersect
			(getArray (configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "UnderBarrelSlot"))
		);

		if !(isNil "_bipod") then
		{
			_unit addPrimaryWeaponItem _bipod;
		};
	};

#else
	// "Regular" method of finding/adding weapon attachments.
	if ((random 100) <= (missionNamespace getVariable [format["DMS_%1_optic_chance",_class],0])) then
	{
		_unit addPrimaryWeaponItem (selectRandom (missionNamespace getVariable [format ["DMS_%1_optics",_class],DMS_assault_optics]));
	};

	if (_nighttime && {(random 100) <= DMS_ai_nighttime_accessory_chance}) then
	{
		_unit addPrimaryWeaponItem (selectRandom ["acc_pointer_IR","acc_flashlight"]);
	};

	if ((random 100) <= (missionNamespace getVariable [format["DMS_%1_bipod_chance",_class],0])) then
	{
		_unit addPrimaryWeaponItem (selectRandom DMS_AI_BipodList);
	};

#endif


	if ((random 100) <= (missionNamespace getVariable [format["DMS_%1_suppressor_chance",_class],0])) then
	{
		private _suppressor = _weapon call DMS_fnc_FindSuppressor;
		if (_suppressor != "") then
		{
			_unit addPrimaryWeaponItem _suppressor;
		};
	};

	/*
	// In case spawn position is water
	if (DMS_ai_enable_water_equipment && {surfaceIsWater _pos}) then
	{
		removeHeadgear _unit;
		removeAllWeapons _unit;
		_unit forceAddUniform "U_O_Wetsuit";
		_unit addVest "V_RebreatherIA";
		_unit addGoggles "G_Diving";
		[_unit, "arifle_SDAR_F", 4 + floor(random 3), "20Rnd_556x45_UW_mag"] call DMS_fnc_AddWeapon;
	};
	*/

	private _pistols = missionNamespace getVariable [format ["DMS_%1_pistols",_class],[]];
	if !(_pistols isEqualTo []) then
	{
		private _pistol = selectRandom _pistols;
		[_unit, _pistol, 2 + floor(random 2)] call DMS_fnc_AddWeapon;
	};

	// Infinite Ammo. This will NOT work if AI unit is offloaded to client.
	// Removed because there isn't much need for this.
	// _unit addeventhandler ["Fired", {(vehicle (_this select 0)) setvehicleammo 1;}];
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
		_unit addBackpackGlobal _backpack;
	};

	if !(_launcher isEqualTo "") then
	{
		_unit addWeapon _launcher;
	};


	// Add pistol and attachments
	if !(_pistol isEqualTo "") then
	{
		_unit addWeapon _pistol;

		{
			_unit addHandgunItem _x;
		} forEach _pistolAttachments;
	};


	// Add gun and attachments
	if !(_weapon isEqualTo "") then
	{
		_unit addWeapon _weapon;

		{
			_unit addPrimaryWeaponItem _x;
		} forEach _weaponAttachments;

		_unit selectWeapon _weapon;
	};


	// Add magazines and items about half a second after spawning so that backpack inventory can be used reliably. Thanks to second_coming for reporting this issue.
	[
		0.5,
		{
			params
			[
				"_unit",
				"_magazines",
				"_assignedItems"
			];

			{
				if (_x isEqualType "") then
				{
					_x = [_x,1];
				};
				_unit addMagazines _x;
			} forEach _magazines;

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
		},
		[_unit,_magazines,_assignedItems],
		false,
		false
	] call ExileServer_system_thread_addTask;
};

// Give default items
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




// Soldier killed event handler
_unit addMPEventHandler ["MPKilled",'if (isServer) then {_this call DMS_fnc_OnKilled;};'];



// Remove ramming damage from players.
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


// Tweak difficulty stuff.
{
	_unit setSkill _x;
} forEach (missionNamespace getVariable [format["DMS_ai_skill_%1",_difficulty],[]]);

if (_difficulty == "hardcore") then
{
	// Make him a little bit harder ;)
	{
		_unit disableAI _x;
	} forEach ["SUPPRESSION", "AIMINGERROR"];
};

if (_difficulty == "easy") then
{
	// Disable visibility raycasts for "easy" AI.
	_unit disableAI "CHECKVISIBLE";
};

_unit setCustomAimCoef (missionNamespace getVariable [format["DMS_AI_AimCoef_%1",_difficulty], 0.7]);
_unit enableStamina (missionNamespace getVariable [format["DMS_AI_EnableStamina_%1",_difficulty], true]);



if (_type=="Soldier") then
{
	_unit setVariable ["DMS_AISpawnPos",_pos];
	_unit setVariable ["DMS_LastAIDistanceCheck",time];
};

// Just use "Soldier" type for everything else.
if (_type == "Paratroopers") then
{
	_type = "Soldier";
	_unit addBackpackGlobal "B_Parachute";
};


// Set info variables
_unit setVariable ["DMS_AISpawnTime", time];
_unit setVariable ["DMS_AI_Side", _side];
_unit setVariable ["DMS_AI_Type", _type];

// Set money/respect variables
_unit setVariable
[
	"DMS_AI_Money",
	missionNamespace getVariable [format ["DMS_%1_%2_MoneyGain",_side,_type],0]
];
_unit setVariable
[
	"DMS_AI_Respect",
	missionNamespace getVariable [format ["DMS_%1_%2_RepGain",_side,_type],0]
];


private _AIMoney =
	if (DMS_Spawn_AI_With_Money) then
	{
		private _base_money_amount = missionNamespace getVariable [format["DMS_%1_%2_SpawnMoney",_side,_type], 0];
		private _population_bonus = DMS_AIMoney_PopulationMultiplier * (if (isNil '_playerCount') then {count allPlayers} else {_playerCount});
		_base_money_amount + _population_bonus
	}
	else
	{
		0
	};

_unit setVariable
[
	"ExileMoney",
	_AIMoney,
	true
];


if (DMS_DEBUG) then
{
	(format ["SpawnAISoldier :: Spawned a %1 %2 %6 AI at %3 with %4 difficulty carrying %7 poptabs to group %5",_class,_side,_pos,_difficulty,_group,_type,_AIMoney]) call DMS_fnc_DebugLog;
};


[_unit] joinSilent _group;


_unit
