/*
	DMS_fnc_SpawnAIGroup
	Created by eraser1
	Based off of WAI

	Usage:
	[
		_pos,					// ARRAY (positionATL): Position of AI
		_count,					// SCALAR: Number of AI
		_difficulty,			// STRING: AI Difficulty: "random","hardcore","difficult","moderate", or "easy"
		_class,					// STRING: AI Class: "random","assault","MG", or "sniper" OR [_class,_launcherType]
		_side, 					// STRING: Only "bandit" is supported by default
		_customGearSet			// (OPTIONAL) ARRAY: Manually defined AI gear. Refer to functional documentation of fn_SpawnAISoldier.sqf for more info: https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/scripts/fn_SpawnAISoldier.sqf
	] call DMS_fnc_SpawnAIGroup;

	Returns AI Group
*/

if !(params
[
	"_pos",
	"_count",
	"_difficulty",
	"_class",
	"_side"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_SpawnAIGroup with invalid parameters: %1",_this];
	grpNull
};

if (DMS_DEBUG) then
{
	(format["SpawnAIGroup :: Spawning %1 %2 %3 AI at %4 with %5 difficulty.",_count,_class,_side,_pos,_difficulty]) call DMS_fnc_DebugLog;
};


private _launcherType = "";

// if soldier have AT/AA weapons
if (_class isEqualType []) then
{
	_launcherType	= _class select 1;
	_class			= _class select 0;
};


private _customGearSet = [];

if (_class == "custom") then
{
	if ((count _this)>5) then
	{
		_customGearSet = _this select 5;
	}
	else
	{
		diag_log format["DMS ERROR :: Calling DMS_fnc_SpawnAIGroup with custom class without defining _customGearSet! Setting _class to ""random"" _this: %1",_this];
		_class = "random";
	};
};


_group = createGroup (missionNamespace getVariable [format ["DMS_%1Side",_side],EAST]);

_group setVariable ["DMS_LockLocality",true];									// Lock locality until all units are spawned
_group setVariable ["DMS_SpawnedGroup",true];
_group setVariable ["DMS_Group_Side", _side];

for "_i" from 1 to _count do
{
	_unit = [_group,_pos,_class,_difficulty,_side,"Soldier",_customGearSet] call DMS_fnc_SpawnAISoldier;
};

// An AI will definitely spawn with a launcher if you define type
if (DMS_ai_use_launchers || {!(_launcherType isEqualTo "")}) then
{
	if (_launcherType isEqualTo "") then
	{
		_launcherType = "AT";
	};

	private _units = units _group;
	private _launchers = missionNamespace getVariable [format ["DMS_AI_wep_launchers_%1",_launcherType],DMS_AI_wep_launchers_AT];

	for "_i" from 0 to ((DMS_ai_launchers_per_group min _count)-1) do
	{
		if ((random 100)<DMS_ai_use_launchers_chance) then
		{
			private _unit = _units select _i;

			private _launcher = selectRandom _launchers;

			removeBackpackGlobal _unit;
			_unit addBackpack "B_Carryall_mcamo";

			[_unit, _launcher, DMS_AI_launcher_ammo_count] call DMS_fnc_addWeapon;

			_unit setVariable ["DMS_AI_Launcher",_launcher];

			if (DMS_DEBUG) then
			{
				(format["SpawnAIGroup :: Giving %1 a %2 launcher with %3 rockets",_unit,_launcher,DMS_AI_launcher_ammo_count]) call DMS_fnc_DebugLog;
			};
		};
	};
};


_group selectLeader ((units _group) select 0);
_group setFormation "WEDGE";



[_group,_pos,_difficulty,"COMBAT"] call DMS_fnc_SetGroupBehavior;

if (DMS_ai_freezeOnSpawn) then
{
	[_group,true] call DMS_fnc_FreezeToggle;
};

_group setVariable ["DMS_LockLocality",false];									// Unlock locality now that we're done with the group


diag_log format ["DMS_SpawnAIGroup :: Spawned %1 AI at %2.",_count,_pos];

_group
