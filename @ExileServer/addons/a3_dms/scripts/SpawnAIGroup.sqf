/*
	DMS_SpawnAIGroup
	Created by eraser1
	Based off of WAI

	Usage:
	[
		_pos,					// Position of AI
		_count,					// Number of AI
		_difficulty,			// "random","hardcore","difficult","moderate", or "easy"
		_type 					// "random","assault","MG","sniper" or "unarmed" OR [_type,_launcher]
		_side 					// Only "bandit" is supported atm
	] call DMS_SpawnAIGroup;

	Returns AI Group
*/
private ["_OK", "_pos", "_count", "_difficulty", "_type", "_side", "_pos_x", "_pos_y", "_pos_z", "_launcher", "_unit", "_client"];

_OK = params
[
	["_pos",[0,0,0],[[]],[3]],
	["_count",0,[0]],
	["_difficulty","random",[""]],
	["_type","random",[""]],
	["_side","bandit",[""]]
];

if (!_OK) then
{
	diag_log format ["DMS ERROR :: Calling DMS_SpawnAIGroup with invalid parameters: %1",_this];
};

if (_count < 1) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_SpawnAIGroup with less than 1 _count! _this: %1",_this];
};

_pos_x 			= _pos select 0;
_pos_y 			= _pos select 1;
_pos_z 			= _pos select 2;


if(DMS_DEBUG) then
{
	diag_log format["DMS_DEBUG SpawnAIGroup :: Spawning %1 %2 %3 AI at %4 with %5 difficulty.",_count,_type,_side,_pos,_difficulty];
};

// if soldier have AT/AA weapons
if (typeName _type == "ARRAY") then
{
	_launcher		= _type select 1;
	_type			= _type select 0;
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

for "_i" from 1 to _count do {
	_unit = [_group,[_pos_x,_pos_y,_pos_z],_type,_difficulty,_side] call DMS_SpawnAISoldier;
};

// An AI will definitely spawn with a launcher if you define type
if ((!isNil "_launcher") || {DMS_ai_use_launchers && {(random 100) <= DMS_ai_use_launchers_chance}}) then
{
	if (isNil "_launcher") then
	{
		_launcher = "AT";
	};

	_launcher = ((missionNamespace getVariable [format ["DMS_AI_wep_launchers_%1",_launcher],["launch_NLAW_F"]]) call BIS_fnc_selectRandom);

	_unit addBackpack "B_Carryall_mcamo";

	[_unit, _launcher, DMS_AI_launcher_ammo_count] call BIS_fnc_addWeapon;
	
	if(DMS_DEBUG) then
	{
		diag_log format["DMS_DEBUG SpawnAIGroup :: Giving %1 a %2 launcher.",_unit,_launcher];
	};
};


_group selectLeader ((units _group) select 0);
_group setFormation "WEDGE";


if(_pos_z == 0) then
{
	[_group,_pos,_difficulty] call DMS_SetGroupBehavior;
};



if (DMS_ai_offload_to_client) then
{	
	/*
	_client = (allPlayers call BIS_fnc_selectRandom);
	ExileServerOwnershipSwapQueue pushBack [_group,_client];
	*/

//	[_group,_pos] call DMS_SetAILocality;

	if(DMS_DEBUG) then
	{
		diag_log format["DMS_DEBUG SpawnAIGroup :: Swapping group ownership of %1 to clients.",_group];
	};	
};


diag_log format ["DMS_SpawnAIGroup :: Spawned %1 AI at %2.",_count,_pos];

_group
