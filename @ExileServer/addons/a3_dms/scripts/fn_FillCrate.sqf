/*
	DMS_fnc_FillCrate

	Inspired by WAI: https://github.com/nerdalertdk/WICKED-AI
	created by eraser1

	Usage:
	[
		_crate,						// OBJECT: The crate object
		_lootValues,				// ARRAY, STRING, or NUMBER: String or number refers to a crate case in config.cfg; array determines random crate weapons/items/backpacks
		_rareLootChance				// (OPTIONAL) NUMBER: Manually define the percentage chance of spawning some rare items.
	] call DMS_fnc_FillCrate;

	If the "_lootValues" parameter is a number or a string, the function will look for a value defined as "DMS_CrateCase_*", where the "*" is replaced by the "_lootValues" parameter. EG: DMS_CrateCase_Sniper.

	Otherwise, the "_lootValues" parameter must be defined as:
		[
			_weapons,
			_items,
			_backpacks
		]

	Each loot argument can be an explicitly defined array of weapons with a number to spawn, or simply a number and weapons defined in the config.sqf are used.
	For example, if you want to configure the list from which weapons, items, and backpacks are selected, it should be of the form:
	[
		[
			_number_of_weapons,
			[
				"wepClassname1",
				"wepClassname2",
				...
				"wepClassnameN"
			]
		],
		[
			_number_of_items,
			[
				"itemClassname1",
				"itemClassname2",
				...
				"itemClassnameN"
			]
		],
		[
			_number_of_backpacks,
			[
				"backpackClassname1",
				"backpackClassname2",
				...
				"backpackClassnameN"
			]
		]
	]

	For example, _weapons could simply be a number, in which case the given number of weapons are selected from "DMS_boxWeapons",
	or an array as [_wepCount,_weps], where _wepCount is the number of weapons, and _weps is an array of weapons from which the guns are randomly selected.

	OR:
		[
			_customLootFunctionParams,
			_customLootFunction
		]
		In this case, "_customLootFunctionParams" is passed to "_customLootFunction", and the custom loot function must return the loot in the form:
		[
			[
				weapon1,
				weapon2,
				[weapon_that_appears_twice,2],
				...
				weaponN
			],
			[
				item1,
				item2,
				[item_that_appears_5_times,5],
				...
				itemN
			],
			[
				backpack1,
				backpack2,
				[backpack_that_appears_3_times,3],
				...
				backpackN
			]
		]
*/

if (!(params
[
	"_crate",
	"_lootValues"
])
||
{isNull _crate})
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_FillCrate with invalid parameters: %1",_this];
};

_crate hideObjectGlobal false;

if !(_crate getVariable ["DMS_CrateGodMode",DMS_GodmodeCrates]) then
{
	_crate allowDamage true;
};
if (_crate getVariable ["DMS_CrateEnableRope",DMS_EnableBoxMoving]) then
{
	_crate enableRopeAttach true;
};

_crate enableSimulationGlobal true;


if ((_lootValues isEqualType []) && {!((_lootValues select 1) isEqualType {})}) then
{
	// Weapons
	private _wepValues = _lootValues select 0;
	private _wepCount = 0;
	private _weps =
		if (_wepValues isEqualType []) then
		{
			_wepCount	= _wepValues select 0;
			_wepValues select 1
		}
		else
		{
			_wepCount	= _wepValues;
			DMS_boxWeapons
		};


	// Items
	private _itemValues = _lootValues select 1;
	private _itemCount = 0;
	private _items =
		if (_itemValues isEqualType []) then
		{
			_itemCount	= _itemValues select 0;
			_itemValues select 1
		}
		else
		{
			_itemCount	= _itemValues;
			DMS_boxItems
		};


	// Backpacks
	private _backpackValues = _lootValues select 2;
	private _backpackCount = 0;
	private _backpacks =
		if (_backpackValues isEqualType []) then
		{
			_backpackCount	= _backpackValues select 0;
			_backpackValues select 1
		}
		else
		{
			_backpackCount = _backpackValues;
			DMS_boxBackpacks
		};

	if (DMS_DEBUG) then
	{
		(format["FillCrate :: Filling %4 with %1 guns, %2 items and %3 backpacks",_wepCount,_itemCount,_backpackCount,_crate]) call DMS_fnc_DebugLog;
	};


	if (count _weps>0) then
	{
		// Add weapons + mags
		for "_i" from 1 to _wepCount do
		{
			private _weapon = selectRandom _weps;
			private _ammo = _weapon call DMS_fnc_selectMagazine;
			if (_weapon isEqualType "") then
			{
				_weapon = [_weapon,1];
			};
			_crate addWeaponCargoGlobal _weapon;
			if !(_ammo in ["Exile_Magazine_Swing","Exile_Magazine_Boing","Exile_Magazine_Swoosh"]) then
			{
				_crate addItemCargoGlobal [_ammo, (DMS_MinimumMagCount + floor(random DMS_MagRange))];
			};
		};
	};


	if (count _items>0) then
	{
		// Add items
		for "_i" from 1 to _itemCount do
		{
			private _item = selectRandom _items;
			if (_item isEqualType "") then
			{
				_item = [_item,1];
			};
			_crate addItemCargoGlobal _item;
		};
	};


	if (count _backpacks>0) then
	{
		// Add backpacks
		for "_i" from 1 to _backpackCount do
		{
			private _backpack = selectRandom _backpacks;
			if (_backpack isEqualType "") then
			{
				_backpack = [_backpack,1];
			};
			_crate addBackpackCargoGlobal _backpack;
		};
	};
}
else
{
	private _crateValues =
		if (_lootValues isEqualType []) then
		{
			(_lootValues select 0) call (_lootValues select 1)
		}
		else
		{
			missionNamespace getVariable (format ["DMS_CrateCase_%1",_lootValues])
		};

	if !((_crateValues params
	[
		"_weps",
		"_items",
		"_backpacks"
	]))
	exitWith
	{
		diag_log format ["DMS ERROR :: Invalid ""_crateValues"" (%1) generated from _lootValues: %2",_crateValues,_lootValues];
	};

	// Weapons
	{
		if (_x isEqualType "") then
		{
			_x = [_x,1];
		};
		_crate addWeaponCargoGlobal _x;
	} forEach _weps;

	// Items/Mags
	{
		if (_x isEqualType "") then
		{
			_x = [_x,1];
		};
		_crate addItemCargoGlobal _x;
	} forEach _items;

	// Backpacks
	{
		if (_x isEqualType "") then
		{
			_x = [_x,1];
		};
		_crate addBackpackCargoGlobal _x;
	} forEach _backpacks;

	if (DMS_DEBUG) then
	{
		(format["FillCrate :: Filled crate %1 (at %5) with weapons |%2|, items |%3|, and backpacks |%4|",_crate, _weps, _items, _backpacks, getPosATL _crate]) call DMS_fnc_DebugLog;
	};
};


if (DMS_RareLoot) then
{
	private _rareLootChance =
		if ((count _this)>2) then
		{
			_this param [2,DMS_RareLootChance,[0]]
		}
		else
		{
			DMS_RareLootChance
		};

	// (Maybe) Add rare loot
	if(random 100 < _rareLootChance) then
	{
		for "_i" from 1 to DMS_RareLootAmount do
		{
			_item = selectRandom DMS_RareLootList;
			if (_item isEqualType "") then
			{
				_item = [_item,1];
			};
			_crate addItemCargoGlobal _item;
		};
	};
};

// You can choose if you want to enable/disable smoke individually using setVariable.
if (_crate getVariable ["DMS_AllowSmoke", true]) then
{
	if (DMS_SpawnBoxSmoke && {sunOrMoon isEqualTo 1}) then
	{
		private _marker = (_crate getVariable ["DMS_CrateSmokeClassname", DMS_DefaultSmokeClassname]) createVehicle getPosATL _crate;
		_marker setPosATL (getPosATL _crate);
		_marker attachTo [_crate,[0,0,0]];
	};

	if (DMS_SpawnBoxIRGrenade && {sunOrMoon != 1}) then
	{
		private _marker = "B_IRStrobe" createVehicle getPosATL _crate;
		_marker setPosATL (getPosATL _crate);
		_marker attachTo [_crate, [0,0,0.5]];
	};
};
