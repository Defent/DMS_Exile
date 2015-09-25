/*
	DMS_fnc_SpawnAIStatic
	Created by eraser1
	Influenced by WAI

	Usage:
	[
		[				// Array of static gun positions
			_pos1,
			_pos2,
			...
			_pos3
		],
		_group,			// Group to which the AI unit(s) belongs to
		_class,			// Class: "random","assault","MG","sniper" or "unarmed"
		_difficulty,	// Difficulty: "random","static","hardcore","difficult","moderate", or "easy"
		_side,			// "bandit","hero", etc.
		_MGClass		// !OPTIONAL) String: classname of the MG. Use "random" to select a random one from DMS_static_weapons
	] call DMS_fnc_SpawnAIStatic;

	Returns an array of static gun objects.
*/

private ["_OK", "_guns", "_pos", "_MGClassInput", "_MGClass", "_gun", "_unit", "_group", "_class", "_difficulty", "_side", "_positions"];


_OK = params
[
	["_positions",[],[[]]],
	["_group",grpNull,[grpNull]],
	["_class","random",[""]],
	["_difficulty","static",[""]],
	["_side","bandit",[""]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnAIStatic with invalid parameters: %1",_this];
};

_MGClassInput = "random";
if ((count _this)>5) then
{
	_MGClassInput = param [5,"random",[""]];
};


_guns = [];

{
	_pos = _x;

	_MGClass = _MGClassInput;
	if (_MGClass == "random") then
	{
		_MGClass = DMS_static_weapons call BIS_fnc_selectRandom;
	};
	
	_gun = createVehicle [_MGClass, _pos, [], 0, "CAN_COLLIDE"];
	_gun setDir (random 360);
	_gun setPosATL _pos;
	_gun addEventHandler ["GetOut",{(_this select 0) setDamage 1;}];
	_gun lock 2;

	_guns pushBack _gun;

	_unit = [_group,_pos,_class,_difficulty,_side,"Static"] call DMS_fnc_SpawnAISoldier;
	
	_unit moveInGunner _gun;
	reload _unit;
	_unit setVariable ["DMS_AssignedVeh",_gun];

	if (DMS_DEBUG) then
	{
		diag_log format ["DMS_DEBUG SpawnAIStatic :: Created unit %1 at %2 as static gunner in %3",_unit,_pos,_gun];
	};
} forEach _positions;


if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG SpawnAIStatic :: Created %1 static AI with parameters: %2",count _positions,_this];
};

_guns