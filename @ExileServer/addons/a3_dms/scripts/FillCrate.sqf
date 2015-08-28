/*
Original credit goes to WAI: https://github.com/nerdalertdk/WICKED-AI
Edited by eraser1

[
	_weapons,
	_tools,
	_items,
	_backpacks
]
Each argument can be an explicitly defined array of weapons with a number to spawn, or simply a number and weapons defined in the config.sqf are used
*/


private ["_ammo","_tool","_box","_weapon","_item","_backpack","_toolCount","_itemCount","_backpackCount","_wepCount","_weps","_tools","_items","_backpacks"];

_box = _this select 0;

// WEAPONS
if(typeName (_this select 1) == "ARRAY") then {
	_wepCount	= (_this select 1) select 0;
	_weps	= (_this select 1) select 1;
} else {
	_wepCount	= _this select 1;
	_weps	= DMS_boxWeapons;
};
// TOOLS
if(typeName (_this select 2) == "ARRAY") then {
	_toolCount	= (_this select 2) select 0;
	_tools = (_this select 2) select 1;
} else {
	_toolCount	= _this select 2;
	_tools = DMS_boxTools;
};
// RANDOM
if(typeName (_this select 3) == "ARRAY") then {
	_itemCount	= (_this select 3) select 0;
	_items	= (_this select 3) select 1;
} else {
	_itemCount	= _this select 3;
	_items	= DMS_boxItems;
};
// BACKPACK
if(typeName (_this select 4) == "ARRAY") then {
	_backpackCount	= (_this select 4) select 0;
	_backpacks = (_this select 4) select 1;
} else {
	_backpackCount = _this select 4;
	_backpacks = DMS_boxBackpacks;
};


if(DMS_DEBUG) then {
	diag_log format["DMS :: Filling a dynamic crate with %1 guns, %2 tools, %3 items and %4 backpacks",_wepCount,_toolCount,_itemCount,_backpackCount];
};


if ((_wepCount>0) && {count _weps>0}) then {

	for "_i" from 1 to _wepCount do {
		_weapon = _weps call BIS_fnc_selectRandom;
		_ammo = _weapon call DMS_selectMagazine;
		_box addWeaponCargoGlobal _weapon;
		_box addMagazineCargoGlobal [_ammo, (2 + floor(random 3))];
	};

};

if ((_toolCount > 0) && {count _tools>0}) then {

	for "_i" from 1 to _toolCount do {
		_tool = _tools call BIS_fnc_selectRandom;
		_box addItemCargoGlobal  _tool;
	};

};

if ((_itemCount > 0) && {count _items>0}) then {

	for "_i" from 1 to _itemCount do {
		_item = _items call BIS_fnc_selectRandom;
		_box addItemCargoGlobal _item;
	};

};

if ((_backpackCount > 0) && {count _backpacks>0}) then {

	for "_i" from 1 to _backpackCount do {
		_backpack = _backpacks call BIS_fnc_selectRandom;
		_box addBackpackCargoGlobal _backpack;
	};

};

if(DMS_RareLoot && {count DMS_RareLoot>0}) then {

	if(random 100 < DMS_RareLootChance) then {
		_item = DMS_RareLoot call BIS_fnc_selectRandom;
		_box addItemCargoGlobal _item;
	};

};