/*
	DMS_fnc_FillCrate

	Original credit goes to WAI: https://github.com/nerdalertdk/WICKED-AI
	Edited by eraser1

	Usage:
	[
		_crate,
		[
			_weapons,
			_items,
			_backpacks
		]
	] call DMS_fnc_FillCrate;
	
	Each loot argument can be an explicitly defined array of weapons with a number to spawn, or simply a number and weapons defined in the config.sqf are used
*/

if (isNil "_this") exitWith
{
	diag_log "DMS ERROR :: Calling DMS_FillCrate with nil argument!";
};


private ["_crate","_lootValues","_wepCount","_weps","_itemCount","_items","_backpackCount","_backpacks","_weapon","_ammo","_item","_backpack"];

_OK = params
[
	["_crate",objNull,[objNull]],
	["_lootValues",[0,0,0],[[]],[3]]
];

if (!_OK || {isNull _crate}) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_FillCrate with invalid parameters: %1",_this];
};

// Weapons
if(typeName (_lootValues select 0) == "ARRAY") then
{
	_wepCount	= (_lootValues select 0) select 0;
	_weps	= (_lootValues select 0) select 1;
}
else
{
	_wepCount	= _lootValues select 0;
	_weps	= DMS_boxWeapons;
};


// Items
if(typeName (_lootValues select 1) == "ARRAY") then
{
	_itemCount	= (_lootValues select 1) select 0;
	_items	= (_lootValues select 1) select 1;
}
else
{
	_itemCount	= _lootValues select 1;
	_items	= DMS_boxItems;
};


// Backpacks
if(typeName (_lootValues select 2) == "ARRAY") then
{
	_backpackCount	= (_lootValues select 2) select 0;
	_backpacks = (_lootValues select 2) select 1;
}
else
{
	_backpackCount = _lootValues select 2;
	_backpacks = DMS_boxBackpacks;
};


if(DMS_DEBUG) then
{
	diag_log format["DMS_DEBUG FillCrate :: Filling %4 with %1 guns, %2 items and %3 backpacks",_wepCount,_itemCount,_backpackCount,_crate];
};


if ((_wepCount>0) && {count _weps>0}) then
{
	// Add weapons + mags
	for "_i" from 1 to _wepCount do
	{
		_weapon = _weps call BIS_fnc_selectRandom;
		_ammo = _weapon call DMS_fnc_selectMagazine;
		if ((typeName _weapon)=="STRING") then
		{
			_weapon = [_weapon,1];
		};
		_crate addWeaponCargoGlobal _weapon;
		_crate addItemCargoGlobal [_ammo, (4 + floor(random 3))];
	};
};


if ((_itemCount > 0) && {count _items>0}) then
{
	// Add items
	for "_i" from 1 to _itemCount do
	{
		_item = _items call BIS_fnc_selectRandom;
		if ((typeName _item)=="STRING") then
		{
			_item = [_item,1];
		};
		_crate addItemCargoGlobal _item;
	};
};


if ((_backpackCount > 0) && {count _backpacks>0}) then
{
	// Add backpacks
	for "_i" from 1 to _backpackCount do
	{
		_backpack = _backpacks call BIS_fnc_selectRandom;
		if ((typeName _backpack)=="STRING") then
		{
			_backpack = [_backpack,1];
		};
		_crate addBackpackCargoGlobal _backpack;
	};
};


if(DMS_RareLoot && {count DMS_RareLootList>0}) then
{
	// (Maybe) Add rare loot
	if(random 100 < DMS_RareLootChance) then
	{
		_item = DMS_RareLootList call BIS_fnc_selectRandom;
		if ((typeName _item)=="STRING") then
		{
			_item = [_item,1];
		};
		_crate addItemCargoGlobal _item;
	};
};


if(DMS_SpawnBoxSmoke && {sunOrMoon == 1}) then {
	_marker = "SmokeShellPurple" createVehicle getPosATL _crate;
	_marker setPosATL (getPosATL _crate);
	_marker attachTo [_crate,[0,0,0]];
};

if (DMS_SpawnBoxIRGrenade && {sunOrMoon != 1}) then {
	_marker = "B_IRStrobe" createVehicle getPosATL _crate;
	_marker setPosATL (getPosATL _crate);
	_marker attachTo [_crate, [0,0,0.5]];
};