/*
	DMS_fnc_SpawnAIGroup
	Created by eraser1
	Based off of WAI

	Usage:
	[
		_pos,					// Position of AI
		_count,					// Number of AI
		_difficulty,			// AI Difficulty: "random","hardcore","difficult","moderate", or "easy"
		_class,					// AI Class: "random","assault","MG","sniper" or "unarmed" OR [_class,_launcher]
		_side 					// Only "bandit" is supported atm
	] call DMS_fnc_SpawnAIGroup;

	Returns AI Group
*/
private ["_OK", "_pos", "_count", "_difficulty", "_class", "_side", "_pos_x", "_pos_y", "_pos_z", "_launcher", "_unit", "_client"];

_OK = params
[
	["_pos",[0,0,0],[[]],[3]],
	["_count",0,[0]],
	["_difficulty","random",[""]],
	["_class","random",[""]],
	["_side","bandit",[""]]
];

if (!_OK) then
{
	diag_log format ["DMS ERROR :: Calling DMS_SpawnAIGroup with invalid parameters: %1",_this];
};

_pos_x 			= _pos select 0;
_pos_y 			= _pos select 1;
_pos_z 			= _pos select 2;


if(DMS_DEBUG) then
{
	diag_log format["DMS_DEBUG SpawnAIGroup :: Spawning %1 %2 %3 AI at %4 with %5 difficulty.",_count,_class,_side,_pos,_difficulty];
};

// if soldier have AT/AA weapons
if (typeName _class == "ARRAY") then
{
	_launcher		= _class select 1;
	_class			= _class select 0;
};
	
// Randomize position
if(_pos_z == 0) then
{
	if(round(random 1) == 1) then
	{
		_pos_x = _pos_x - (5 + random(10));
	} else {
		_pos_x = _pos_x + (5 + random(10));
	};			

	if(round(random 1) == 1) then
	{
		_pos_y = _pos_y - (5 + random(10));
	} else {
		_pos_y = _pos_y + (5 + random(10));
	};
};


_group = createGroup (missionNamespace getVariable [format ["DMS_%1Side",_side],EAST]);

_group setVariable ["DMS_LockLocality",nil];
_group setVariable ["DMS_SpawnedGroup",true];

if (_count < 1) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_SpawnAIGroup with less than 1 _count! _this: %1",_this];
	_group
};

for "_i" from 1 to _count do
{
	_unit = [_group,[_pos_x,_pos_y,_pos_z],_class,_difficulty,_side,"Soldier"] call DMS_fnc_SpawnAISoldier;
};

// An AI will definitely spawn with a launcher if you define type
if ((!isNil "_launcher") || {DMS_ai_use_launchers && {(random 100) <= DMS_ai_use_launchers_chance}}) then
{
	if (isNil "_launcher") then
	{
		_launcher = "AT";
	};

	_launcher = ((missionNamespace getVariable [format ["DMS_AI_wep_launchers_%1",_launcher],["launch_NLAW_F"]]) call BIS_fnc_selectRandom);

	removeBackpackGlobal _unit;
	_unit addBackpack "B_Carryall_mcamo";
	_rocket = _launcher call DMS_fnc_selectMagazine;

	[_unit, _launcher, DMS_AI_launcher_ammo_count,_rocket] call BIS_fnc_addWeapon;

	_unit setVariable ["DMS_AI_Launcher",_launcher];
	
	if(DMS_DEBUG) then
	{
		diag_log format["DMS_DEBUG SpawnAIGroup :: Giving %1 a %2 launcher with %3 %4 rockets",_unit,_launcher,DMS_AI_launcher_ammo_count,_rocket];
	};
};


_group selectLeader ((units _group) select 0);
_group setFormation "WEDGE";


if(_pos_z == 0) then
{
	[_group,_pos,_difficulty,"COMBAT"] call DMS_fnc_SetGroupBehavior;
};


diag_log format ["DMS_SpawnAIGroup :: Spawned %1 AI at %2.",_count,_pos];

_group
