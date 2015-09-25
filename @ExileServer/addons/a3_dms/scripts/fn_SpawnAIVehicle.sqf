/*
	DMS_fnc_SpawnAIVehicle
	Created by eraser1

	Usage:
	[
		[
			_spawnPos,				// The position at which the AI vehicle will spawn
			_gotoPos				// (OPTIONAL) The position to which the AI vehicle will drive to. If it isn't defined, _spawnPos is used
		],
		_group,						// Group to which the AI units belongs to
		_class,						// Class: "random","assault","MG","sniper" or "unarmed"
		_difficulty,				// Difficulty: "random","static","hardcore","difficult","moderate", or "easy"
		_side,						// "bandit","hero", etc.
		_vehClass					// (OPTIONAL) String: classname of the Vehicle. Use "random" to select a random one from DMS_ArmedVehicles
	] call DMS_fnc_SpawnAIVehicle;
	
	Returns the spawned vehicle.
*/

private ["_OK", "_positions", "_veh", "_spawnPos", "_gotoPos", "_vehClass", "_driver", "_gunner", "_tmpGroup", "_group", "_class", "_difficulty", "_side"];


_OK = params
[
	["_positions",[],[[]],[2]],
	["_group",grpNull,[grpNull]],
	["_class","random",[""]],
	["_difficulty","static",[""]],
	["_side","bandit",[""]]
];
if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnAIVehicle with invalid parameters: %1",_this];
};


// Using another params-exitwith structure just for _spawnPos because it's pretty important...
_OK = _positions params
[
	["_spawnPos",[],[[]],[2,3]]
];
if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnAIVehicle with invalid _positions parameters: %1",_positions];
};

// Simply use _spawnPos if _gotoPos isn't defined. Yes, you might get "param"/"params" RPT spam. Deal with it ;)
_gotoPos = _positions param [1,_spawnPos,[[]],[2,3]];

_vehClass = "random";
if ((count _this)>5) then
{
	_vehClass = param [5,"random",[""]];
};

if (_vehClass == "random") then
{
	_vehClass = DMS_ArmedVehicles call BIS_fnc_selectRandom;
};

_tmpGroup = createGroup (missionNamespace getVariable [format ["DMS_%1Side",_side],EAST]);

_veh = createVehicle [_vehClass, _spawnPos, [], 0, "NONE"];
_veh setDir (random 360);
_veh setPosATL _spawnPos;
_veh lock 2;


_driver = [_tmpGroup,_spawnPos,_class,_difficulty,_side,"Vehicle"] call DMS_fnc_SpawnAISoldier;
_gunner = [_tmpGroup,_spawnPos,_class,_difficulty,_side,"Vehicle"] call DMS_fnc_SpawnAISoldier;

_driver moveInDriver _veh;
_gunner moveInGunner _veh;

_driver setVariable ["DMS_AssignedVeh",_veh];
_gunner setVariable ["DMS_AssignedVeh",_veh];


[_tmpGroup,_gotoPos,_difficulty,"AWARE"] call DMS_fnc_SetGroupBehavior;

[_driver,_gunner] joinSilent _group;

if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG SpawnAIVehicle :: Created a %1 armed vehicle (%2) at %3 with %4 difficulty to group %5",_side,_vehClass,_spawnPos,_difficulty,_group];
};

_veh