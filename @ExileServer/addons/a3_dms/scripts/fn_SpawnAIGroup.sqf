/*
	DMS_fnc_SpawnAIGroup
	Created by eraser1
	Based off of WAI

	Usage:
	[
		_pos,					// Position of AI
		_count,					// Number of AI
		_difficulty,			// AI Difficulty: "random","hardcore","difficult","moderate", or "easy"
		_class,					// AI Class: "random","assault","MG","sniper" or "unarmed" OR [_class,_launcherType]
		_side 					// Only "bandit" is supported atm
	] call DMS_fnc_SpawnAIGroup;

	Returns AI Group
*/
private ["_OK", "_pos", "_count", "_difficulty", "_class", "_group", "_side", "_launcherType", "_launcher", "_unit", "_rocket"];

_OK = params
[
	["_pos","_pos ERROR",[[]],[3]],
	["_count","_count ERROR",[0]],
	["_difficulty","_difficulty ERROR",[""]],
	["_class","_class ERROR",[""]],
	["_side","_side ERROR",[""]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_SpawnAIGroup with invalid parameters: %1",_this];
	grpNull
};


if (DMS_DEBUG) then
{
	(format["SpawnAIGroup :: Spawning %1 %2 %3 AI at %4 with %5 difficulty.",_count,_class,_side,_pos,_difficulty]) call DMS_fnc_DebugLog;
};

// if soldier have AT/AA weapons
if (typeName _class == "ARRAY") then
{
	_launcherType		= _class select 1;
	_class			= _class select 0;
};


_group = createGroup (missionNamespace getVariable [format ["DMS_%1Side",_side],EAST]);

_group setVariable ["DMS_LockLocality",nil];
_group setVariable ["DMS_SpawnedGroup",true];
_group setVariable ["DMS_Group_Side", _side];

if (_count < 1) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_SpawnAIGroup with less than 1 _count! _this: %1",_this];
	_group
};

for "_i" from 1 to _count do
{
	_unit = [_group,[_pos,random 5,random 360] call DMS_fnc_SelectOffsetPos,_class,_difficulty,_side,"Soldier"] call DMS_fnc_SpawnAISoldier;
};

// An AI will definitely spawn with a launcher if you define type
if ((!isNil "_launcherType") || {DMS_ai_use_launchers && {DMS_ai_launchers_per_group>0}}) then
{
	if (isNil "_launcherType") then
	{
		_launcherType = "AT";
	};

	_units = units _group;

	for "_i" from 0 to (((DMS_ai_launchers_per_group min _count)-1) max 0) do
	{
		if ((random 100)<DMS_ai_use_launchers_chance) then
		{
			_unit = _units select _i;

			_launcher = ((missionNamespace getVariable [format ["DMS_AI_wep_launchers_%1",_launcherType],["launch_NLAW_F"]]) call BIS_fnc_selectRandom);

			removeBackpackGlobal _unit;
			_unit addBackpack "B_Carryall_mcamo";
			_rocket = _launcher call DMS_fnc_selectMagazine;

			[_unit, _launcher, DMS_AI_launcher_ammo_count,_rocket] call BIS_fnc_addWeapon;

			_unit setVariable ["DMS_AI_Launcher",_launcher];
			
			if (DMS_DEBUG) then
			{
				(format["SpawnAIGroup :: Giving %1 a %2 launcher with %3 %4 rockets",_unit,_launcher,DMS_AI_launcher_ammo_count,_rocket]) call DMS_fnc_DebugLog;
			};
		};
	};
};


_group selectLeader ((units _group) select 0);
_group setFormation "WEDGE";



[_group,_pos,_difficulty,"COMBAT"] call DMS_fnc_SetGroupBehavior;


diag_log format ["DMS_SpawnAIGroup :: Spawned %1 AI at %2.",_count,_pos];

_group
