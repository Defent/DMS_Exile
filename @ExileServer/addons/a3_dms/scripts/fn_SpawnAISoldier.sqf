/*
	DMS_fnc_SpawnAISoldier
	Created by eraser1
	Based off of WAI

	Usage:
	[
		_group,					// Group the AI will belong to
		_pos,					// Position of AI
		_class,					// Classname: "random","assault","MG","sniper" or "unarmed"
		_difficulty,			// Difficulty: "random","static","hardcore","difficult","moderate", or "easy"
		_side, 					// "bandit","hero", etc.
		_type,					// Type of AI: "soldier","static","vehicle","heli", etc.
		_customGearSet			// OPTIONAL: Manually defined AI gear.
	] call DMS_fnc_SpawnAIGroup;

	Usage for _customGearSet:
	[
		_weapon,				// String | EG: "LMG_Zafir_F"
		_weaponAttachments,		// Array of strings | EG: ["optic_dms","bipod_03_F_blk"]
		_magazines,				// Array of arrays | EG: [["150Rnd_762x54_Box",2],["16Rnd_9x21_Mag",3]]
		_pistol,				// String | EG: "hgun_Pistol_heavy_01_snds_F"
		_pistolAttachments,		// Array of strings | EG: ["optic_MRD","muzzle_snds_acp"]
		_items,					// Array of strings | EG: ["Rangefinder","ItemGPS","Exile_Item_InstaDoc"]
		_launcher,				// String | EG: "launch_RPG32_F"
		_helmet,				// String | EG: "H_HelmetLeaderO_ocamo"
		_uniform,				// String | EG: "U_O_GhillieSuit"
		_vest,					// String | EG: "V_PlateCarrierGL_blk"
		_backpack				// String | EG: "B_Carryall_oli"
	]

	Returns AI Unit
*/

private ["_OK", "_useCustomGear", "_unarmed", "_class", "_customGear", "_type", "_unit", "_side", "_nighttime", "_weapon", "_muzzle", "_suppressor", "_pistols", "_pistol", "_customGearSet", "_helmet", "_uniform", "_vest", "_backpack", "_launcher", "_magazines", "_weaponAttachments", "_pistolAttachments", "_items", "_difficulty", "_skillArray"];

_OK = params
[
	["_group",grpNull,[grpNull]],
	["_pos",[0,0,0],[[]],[3]],
	["_class","random",[""]],
	["_difficulty","random",[""]],
	["_side","bandit",[""]],
	["_type","soldier",[""]]
];

_useCustomGear = false;
_unarmed = false;

if (!_OK) then
{
	diag_log format ["DMS ERROR :: DMS_SpawnAISoldier called with invalid parameters: %1",_this];
}
else
{
	if ((_class == "custom") && {((count _this)>6)}) then
	{
		_customGear = _this select 5;
		_useCustomGear = true;
	};
};

if(_difficulty == "random") then
{
	_difficulty = DMS_ai_skill_random call BIS_fnc_selectRandom;
};

//Create unit
_unit = _group createUnit ["O_recon_F", _pos, [], 0,"FORM"];
_unit allowFleeing 0;
[_unit] joinSilent _group;

// Remove existing gear
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit; 
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

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


switch (toLower _class) do
{
	case "random" :  {_class = DMS_random_AI call BIS_fnc_selectRandom;};
	case "unarmed" : {_class = "assault";_unarmed = true;};
};

// Unit name
_unit setName format["[DMS_%3Unit_%1%2]",_class,floor(random 1000),toUpper _side];

if (!_useCustomGear) then
{
	if !(_class in DMS_ai_SupportedClasses) exitWith
	{
		diag_log format ["DMS ERROR :: DMS_SpawnAISoldier called with unsupported _class: %1 | _this: %2",_class,_this];
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
	_unit addHeadgear 		((missionNamespace getVariable [format ["DMS_%1_helmets",_class],[]]) call BIS_fnc_selectRandom);
	_unit forceAddUniform 	((missionNamespace getVariable [format ["DMS_%1_clothes",_class],[]]) call BIS_fnc_selectRandom);
	_unit addVest 			((missionNamespace getVariable [format ["DMS_%1_vests",_class],[]]) call BIS_fnc_selectRandom);
	_unit addBackpack 		((missionNamespace getVariable [format ["DMS_%1_backpacks",_class],[]]) call BIS_fnc_selectRandom);

	// Make AI effective at night
	_nighttime = (sunOrMoon != 1);
	if (_nighttime) then
	{
		_unit linkItem "NVGoggles";
	};

	if (!_unarmed) then
	{
		_weapon = (missionNamespace getVariable [format ["DMS_%1_weps",_class],[]]) call BIS_fnc_selectRandom;
		[_unit, _weapon, 6 + floor(random 3)] call BIS_fnc_addWeapon;
		_unit selectWeapon _weapon;
		
		
		if((random 100) <= (missionNamespace getVariable [format["DMS_%1_optic_chance",_class],0])) then
		{
			_unit addPrimaryWeaponItem ((missionNamespace getVariable [format ["DMS_%1_optics",_class],[]]) call BIS_fnc_selectRandom);
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
	_OK = _customGearSet params
	[
		["_weapon","",[""]],
		["_weaponAttachments",[],[[]]],
		["_magazines",[],[[]]],
		["_pistol","",[""]],
		["_pistolAttachments",[],[[]]],
		["_items",[],[[]]],
		["_launcher","",[""]],
		["_helmet","",[""]],
		["_uniform","",[""]],
		["_vest","",[""]],
		["_backpack","",[""]]
	];

	if (!_OK) then
	{
		diag_log format ["DMS ERROR :: Calling DMS_SpawnAISoldier with invalid _customGearSet: %1 | _this: %2",_customGearSet,_this];
	};

	if (DMS_DEBUG) then
	{
		diag_log format ["DMS_DEBUG SpawnAISoldier :: Equipping unit %1 with _customGearSet: %2",_unit,_customGearSet];
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
		if ((typeName _x) == "STRING") then
		{
			_x = [_x,1];
		};
		_unit addMagazines _x;
	} forEach _magazines;


	// Add gun and attachments
	if !(_weapon isEqualTo "") then
	{
		[_unit, _weapon, 0] call BIS_fnc_addWeapon;

		{
			_unit addPrimaryWeaponItem _x;
		} forEach _weaponAttachments;

		_unit selectWeapon _weapon;
	};


	// Add pistol and attachments
	if !(_pistol isEqualTo "") then
	{
		[_unit, _pistol, 0] call BIS_fnc_addWeapon;

		{
			_unit addPrimaryWeaponItem _x;
		} forEach _pistolAttachments;
	};

	// Add items
	{
		_unit addItem _x;
	} forEach _items;
};

{
	_unit setSkill [(_x select 0),(_x select 1)];
} forEach (missionNamespace getVariable [format["DMS_ai_skill_%1",_difficulty],[]]);


// Soldier killed event handler
_unit addMPEventHandler ["MPKilled",'if (isServer) then {[_this, '+str _side+', '+str _type+'] call DMS_fnc_OnKilled;};'];

// Remove ramming damage from players. Will not work if unit is not local (offloaded)
if (DMS_ai_disable_ramming_damage) then
{
	_unit addEventHandler ["HandleDamage",
	{
		_dmg = _this select 2;
		if (isPlayer (_this select 3) && {(_this select 4)==""}) then
		{
			_dmg = 0;
		};
		_dmg
	}];
};

_unit enableAI "TARGET";
_unit enableAI "AUTOTARGET";
_unit enableAI "MOVE";
_unit enableAI "ANIM";
_unit enableAI "FSM";

if (_type=="Soldier") then
{
	_unit setVariable ["DMS_AISpawnPos",_pos];
	_unit setVariable ["DMS_LastAIDistanceCheck",time];
};

if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG SpawnAISoldier :: Spawned a %1 %2 %6 AI at %3 with %4 difficulty to group %5",_class,_side,_pos,_difficulty,_group,_type];
};

_unit
