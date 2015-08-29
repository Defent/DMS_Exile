/*
	DMS_SpawnAIGroup
	Created by eraser1
	Based off of WAI

	Usage:
	[
		_pos,					// Position of AI
		_count,					// Number of AI
		_difficulty,			// "random","hardcore","difficult","moderate", or "easy"
		_type 					// "random","assault","MG","sniper" or "unarmed"
		_side 					// "bandit","hero", etc.
	] call DMS_SpawnAIGroup;
*/
//<------ TODO

_position 			= _this select 0;
	_pos_x 			= _position select 0;
	_pos_y 			= _position select 1;
	_pos_z 			= _position select 2;
_count 				= _this select 1;
_difficulty			= _this select 2;
_type 				= _this select 3;
_side				= _this select 4;


if(debug_mode) then { diag_log("WAI: Spawning AI " + str(_side)); };

// if soldier have AT/AA weapons
if (typeName _type == "ARRAY") then {
	_launcher		= _type select 1;
	_type		= _type select 0;
};

// Create AI group	
_unitGroup	= createGroup wai_bandit_side;
	
// Find position
if(_pos_z == 0) then {
	if(floor(random 2) == 1) then {
		_pos_x = _pos_x - (5 + random(10));
	} else {
		_pos_x = _pos_x + (5 + random(10));
	};			

	if(floor(random 2) == 1) then {
		_pos_y = _pos_y - (5 + random(10));
	} else {
		_pos_y = _pos_y + (5 + random(10));
	};
};

// spawn X numvbers of AI in the group
for "_x" from 1 to _count do {
	_unit = [_unitGroup,[_pos_x,_pos_y,_pos_z],_type,_difficulty,_side] call DMS_SpawnAISoldier;
	ai_ground_units = (ai_ground_units + 1);
};

if (!isNil "_launcher" && wai_use_launchers) then {
	call {
		if (_launcher == "at") exitWith { _launcher = ai_wep_launchers_AT call BIS_fnc_selectRandom; };
		if (_launcher == "aa") exitWith { _launcher = ai_wep_launchers_AA call BIS_fnc_selectRandom; };
	};
	_rocket = _launcher call find_suitable_ammunition;
	_unit addItemToBackpack _rocket;
	_unit addItemToBackpack _rocket;
	_unit addWeapon _launcher;
	_unit addBackpack "B_Carryall_mcamo";
	
	if(debug_mode) then { diag_log("WAI: AI "+str(_unit) + " have " + str(_rocket)); };
};

_unitGroup setFormation "ECH LEFT";
_unitGroup selectLeader ((units _unitGroup) select 0);

if (!isNil "_mission") then {
	if(debug_mode) then { diag_log("WAI: mission nr " + str(_mission)); };
	[_unitGroup, _mission] spawn bandit_behaviour;
} else {
	[_unitGroup] spawn bandit_behaviour;
};

if(_pos_z == 0) then {
	[_unitGroup,[_pos_x,_pos_y,_pos_z],_difficulty] spawn group_waypoints;
};

diag_log format ["WAI: Spawned a group of %1 AI at %2",_count,_position];
_unitGroup