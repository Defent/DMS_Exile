private ["_ammo","_tool","_crate","_weapon","_item","_backpack","_num_tools","_num_items","_num_backpacks","_num_weapons","_weapons_array","_tool_array","_item_array","_backpack_array"];

_crate = _this select 0;
_crate allowdamage true;

// WEAPONS
if(typeName (_this select 1) == "ARRAY") then {
	_num_weapons	= (_this select 1) select 0;
	_weapons_array	= (_this select 1) select 1;
} else {
	_num_weapons	= _this select 1;
	_weapons_array	= [ai_assault_wep,ai_machine_wep,ai_sniper_wep] call BIS_fnc_selectRandom;
};
// TOOLS
if(typeName (_this select 2) == "ARRAY") then {
	_num_tools	= (_this select 2) select 0;
	_tool_array = (_this select 2) select 1;
} else {
	_num_tools	= _this select 2;
	_tool_array = crate_tools + ai_assault_scope + crate_tools;
};
// RANDOM
if(typeName (_this select 3) == "ARRAY") then {
	_num_items	= (_this select 3) select 0;
	_item_array	= (_this select 3) select 1;
} else {
	_num_items	= _this select 3;
	_item_array	= crate_random call BIS_fnc_selectRandom;
};
// BACKPACK
if(typeName (_this select 4) == "ARRAY") then {
	_num_backpacks	= (_this select 4) select 0;
	_backpack_array = (_this select 4) select 1;
} else {
	_num_backpacks = _this select 4;
	_backpack_array = crate_backpacks_all;
};

if(DMS_DEBUG) then {
	diag_log format["DMS :: Spawning in a dynamic crate with %1 guns, %2 tools, %3 items and %4 backpacks",_num_weapons,_num_tools,_num_items,_num_backpacks];
};

if(_num_weapons > 0) then {

	_num_weapons = (ceil((_num_weapons) / 2) + floor(random (_num_weapons / 2)));

	for "_i" from 1 to _num_weapons do {
		_weapon = _weapons_array call BIS_fnc_selectRandom;
		_ammo = _weapon call find_suitable_ammunition;
		_crate addWeaponCargoGlobal [_weapon,1];
		_crate addMagazineCargoGlobal [_ammo, (1 + floor(random 5))];
	};

};

if(_num_tools > 0) then {

	_num_tools	= (ceil((_num_tools) / 2) + floor(random (_num_tools / 2)));

	for "_i" from 1 to _num_tools do {
		_tool = _tool_array call BIS_fnc_selectRandom;

		if(typeName (_tool) == "ARRAY") then {
			_crate addItemCargoGlobal  [_tool select 0,_tool select 1];
		} else {
			_crate addItemCargoGlobal  [_tool,1];
		};
	};

};

if(_num_items > 0) then {

	_num_items	= (ceil((_num_items) / 2) + floor(random (_num_items / 2)));

	for "_i" from 1 to _num_items do {
		_item = _item_array call BIS_fnc_selectRandom;

		if(typeName (_item) == "ARRAY") then {
			_crate addItemCargoGlobal [_item select 0,_item select 1];
		} else {
			_crate addItemCargoGlobal [_item,1];
		};
	};

};

if(_num_backpacks > 0) then {

	_num_backpacks	= (ceil((_num_backpacks) / 2) + floor(random (_num_backpacks / 2)));

	for "_i" from 1 to _num_backpacks do {
		_backpack = _backpack_array call BIS_fnc_selectRandom;

		if(typeName (_backpack) == "ARRAY") then {
			_crate addBackpackCargoGlobal [_backpack select 0,_backpack select 1];
		} else {
			_crate addBackpackCargoGlobal [_backpack,1];
		};
	};

};

if(wai_high_value) then {

	if(random 100 < wai_high_value_chance) then {

		_item = crate_items_high_value call BIS_fnc_selectRandom;
		_crate addItemCargoGlobal [_item,1];
	};

};