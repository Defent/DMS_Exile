/*
	DMS_SpawnAISoldier
	Created by eraser1
	Based off of WAI

	Usage:
	[
		_group,					// Group the AI will belong to
		_pos,					// Position of AI
		_type,					// "random","assault","MG","sniper" or "unarmed"
		_difficulty,			// "random","hardcore","difficult","moderate", or "easy"
		_side, 					// "bandit","hero", etc.
		_customGearSet		// OPTIONAL: Manually defined AI gear.
	] call DMS_SpawnAIGroup;

	Usage for _customGearSet:
	[
		_weapon,				// String | EG: "LMG_Zafir_F"
		_weaponAttachments,		// Array of strings | EG: ["optic_dms","bipod_03_F_blk"]
		_magazines,				// Array of arrays | EG: [["150Rnd_762x54_Box",2],["16Rnd_9x21_Mag",3]]
		_pistol,				// String | EG: "hgun_Pistol_heavy_01_snds_F"
		_pistolAttachments,		// Array of strings | EG: ["optic_MRD","muzzle_snds_acp"]
		_items,					// Array of strings | EG: ["Rangefinder","ItemGPS","Exile_Item_InstaDoc"]
		_helmet,				// String | EG: "H_HelmetLeaderO_ocamo"
		_uniform,				// String | EG: "U_O_GhillieSuit"
		_vest,					// String | EG: "V_PlateCarrierGL_blk"
		_backpack				// String | EG: "B_Carryall_oli"
	]
*/

private ["_OK", "_useCustomGear", "_unarmed", "_type", "_customGear", "_unit", "_side", "_nighttime", "_weapon", "_muzzle", "_suppressor", "_pistols", "_pistol", "_customGearSet", "_helmet", "_uniform", "_vest", "_backpack", "_magazines", "_weaponAttachments", "_pistolAttachments", "_items", "_difficulty", "_skillArray"];

_OK = params
[
	["_group",(createGroup DMS_banditSide),[grpNull]],
	["_pos",[0,0,0],[[]],[3]],
	["_type","random",[""]],
	["_difficulty","random",[""]],
	["_side","bandit",[""]]
];
_useCustomGear = false;
_unarmed = false;

if (!_OK) then
{
	diag_log format ["DMS ERROR :: DMS_SpawnAISoldier called with invalid parameters: %1",_this];
}
else
{
	if ((_type isEqualTo "custom") && {((count _this)>5)}) then
	{
		_customGear = _this select 5;
		_useCustomGear = true;
	};
};

if(_difficulty isEqualTo "random") then
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
	{_unit linkItem _x;false;} count DMS_ai_default_items;
};

/*
call {
	if(_side == "bandit") 	exitWith { _unit setVariable ["Bandit",true];};
	if(_side == "hero") 	exitWith { _unit setVariable ["Hero",true];};
	if(_side == "special") 	exitWith { _unit setVariable ["Special",true];};
};
*/

call
{
	if (_type isEqualTo "random") exitWith  { _type = DMS_random_AI call BIS_fnc_selectRandom;};
	if (_type isEqualTo "unarmed") exitWith { _type = "assault";_unarmed = true; };
};

// Unit name
_unit setName format["[DMS_Unit_%1%2]",_type,floor(random 1000)];

if (!_useCustomGear) then
{
	if !(_type in DMS_ai_SupportedClasses) exitWith
	{
		diag_log format ["DMS ERROR :: DMS_SpawnAISoldier called with unsupported _type: %1 | _this: %2",_type,_this];
	};// No more idiot-proofing for the following configs

	// Items
	{_unit linkItem _x;false;} count (missionNamespace getVariable [format ["DMS_%1_items",_type],[]]);

	// Clothes
	_unit addHeadgear 		((missionNamespace getVariable [format ["DMS_%1_helmets",_type],[]]) call BIS_fnc_selectRandom);
	_unit forceAddUniform 	((missionNamespace getVariable [format ["DMS_%1_clothes",_type],[]]) call BIS_fnc_selectRandom);
	_unit addVest 			((missionNamespace getVariable [format ["DMS_%1_vests",_type],[]]) call BIS_fnc_selectRandom);
	_unit addBackpack 		((missionNamespace getVariable [format ["DMS_%1_backpacks",_type],[]]) call BIS_fnc_selectRandom);

	// Make AI effective at night
	_nighttime = (sunOrMoon != 1);
	if (_nighttime) then
	{
		_unit linkItem "NVGoggles";
	};

	if (!_unarmed) then
	{
		_weapon = (missionNamespace getVariable [format ["DMS_%1_weps",_type],[]) call BIS_fnc_selectRandom;
		_muzzle = [_unit, _weapon, 4 + floor(random 3)] call BIS_fnc_addWeapon;
		_unit selectWeapon _weapon;
		
		
		if((random 100) <= (missionNamespace getVariable [format["DMS_%1_optic_chance",_type],0])) then
		{
			_unit addPrimaryWeaponItem ((missionNamespace getVariable [format ["DMS_%1_optics",_type],[]) call BIS_fnc_selectRandom);
		};
		
		if (_nighttime && {(random 100) <= DMS_ai_nighttime_accessory_chance}) then
		{
			_unit addPrimaryWeaponItem (["acc_pointer_IR","acc_flashlight"] call BIS_fnc_selectRandom);
		};

		if((random 100) <= (missionNamespace getVariable [format["DMS_%1_bipod_chance",_type],0])) then
		{
			_unit addPrimaryWeaponItem (DMS_ai_BipodList call BIS_fnc_selectRandom);
		};
		

		if((random 100) <= (missionNamespace getVariable [format["DMS_%1_suppressor_chance",_type],0])) then
		{
			_suppressor = _weapon call find_suitable_suppressor;
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
			_muzzle = [_unit, "arifle_SDAR_F", 4 + floor(random 3), "20Rnd_556x45_UW_mag"] call BIS_fnc_addWeapon;
		};

		_pistols = missionNamespace getVariable [format ["DMS_%1_pistols",_type],[];
		if !(_pistols isEqualTo []) then
		{
			_pistol = _pistols call BIS_fnc_selectRandom;
			_muzzle = [_unit, _pistol, 2 + floor(random 2)] call BIS_fnc_addWeapon;
		};

		// Infinite Ammo
		_unit addeventhandler ["Fired", {(_this select 0) setvehicleammo 1;}];
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


	// Add Magazines before weapon so that gun will be loaded
	{
		if ((typeName _x) isEqualTo "STRING") then
		{
			_x = [_x,1];
		};
		_unit addMagazines _x;
		false;
	} count _magazines;


	// Add gun and attachments
	if !(_weapon isEqualTo "") then
	{
		_muzzle = [_unit, _weapon, 0] call BIS_fnc_addWeapon;

		{
			_unit addPrimaryWeaponItem _x;
			false;
		} count _weaponAttachments;

		_unit selectWeapon _weapon;
	};


	// Add pistol and attachments
	if !(_pistol isEqualTo "") then
	{
		_muzzle = [_unit, _pistol, 0] call BIS_fnc_addWeapon;

		{
			_unit addPrimaryWeaponItem _x;
			false;
		} count _pistolAttachments;
	};

	// Add items
	{
		_unit addItem _x;
		false;
	} count _items;
};

{
	_unit setSkill [(_x select 0),(_x select 1)];
	false;
} count (missionNamespace getVariable [format["DMS_ai_skill_%1",_difficulty],[]]);


// Soldier killed event handler
_unit addEventHandler ["Killed",{[_this, "soldier"] call DMS_OnKilled;}];
//_unit addEventHandler ["Killed",{[_unit, _group, "soldier"] call TargetsKilled;}];

_unit enableAI "TARGET";
_unit enableAI "AUTOTARGET";
_unit enableAI "MOVE";
_unit enableAI "ANIM";
_unit enableAI "FSM";

if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG SpawnAISoldier :: Spawned a %1 %2 AI at %3 with %4 difficulty to group %5",_type,_side,_pos,_difficulty,_group];
};

_unit
