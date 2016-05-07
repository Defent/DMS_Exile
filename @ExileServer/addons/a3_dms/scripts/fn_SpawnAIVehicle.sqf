/*
	DMS_fnc_SpawnAIVehicle
	Created by eraser1

	Usage:
	[
		[
			_spawnPos,				// The position at which the AI vehicle will spawn
			_gotoPos				// (OPTIONAL) The position to which the AI vehicle will drive to. If it isn't defined, _spawnPos is used. <--- THIS IS NOT USED. I'm not sure why I included this.
		],
		_group,						// Group to which the AI units belongs to
		_class,						// Class: "random","assault","MG","sniper" or "unarmed"
		_difficulty,				// Difficulty: "random","static","hardcore","difficult","moderate", or "easy"
		_side,						// "bandit","hero", etc.
		_vehClass					// (OPTIONAL) String: classname of the Vehicle. Use "random" to select a random one from DMS_ArmedVehicles
	] call DMS_fnc_SpawnAIVehicle;

	Returns the spawned vehicle.
*/

if !(params
[
	["_positions",[],[[]],[1,2]],
	["_group",grpNull,[grpNull]],
	["_class","random",[""]],
	["_difficulty","static",[""]],
	["_side","bandit",[""]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnAIVehicle with invalid parameters: %1",_this];
};


// Using another params-exitwith structure just for _spawnPos because it's pretty important...
if !(_positions params
[
	["_spawnPos",[],[[]],[2,3]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnAIVehicle with invalid _positions parameters: %1",_positions];
};

private _vehClass =
	if ((count _this)>5) then
	{
		param [5,"random",[""]]
	}
	else
	{
		"random"
	};

if (_vehClass == "random") then
{
	_vehClass = selectRandom DMS_ArmedVehicles;
};


private _veh = createVehicle [_vehClass, _spawnPos, [], 0, "NONE"];
_veh setFuel 1;
_veh engineOn true;
_veh lock 2;

_group addVehicle _veh;

private _driver = [_group,_spawnPos,_class,_difficulty,_side,"Vehicle"] call DMS_fnc_SpawnAISoldier;
_driver moveInDriver _veh;
_driver setVariable ["DMS_AssignedVeh",_veh];

private _crewCount =
{
	private _unit = [_group,_spawnPos,_class,_difficulty,_side,"Vehicle"] call DMS_fnc_SpawnAISoldier;
	_unit moveInTurret [_veh, _x];
	_unit setVariable ["DMS_AssignedVeh",_veh];
	true
} count (allTurrets [_veh, true]);


if (DMS_DEBUG) then
{
	(format ["SpawnAIVehicle :: Created a %1 armed vehicle (%2) with %3 crew members at %4 with %5 difficulty to group %6.",_side,_vehClass,_crewCount+1,_spawnPos,_difficulty,_group]) call DMS_fnc_DebugLog;
};


_veh
