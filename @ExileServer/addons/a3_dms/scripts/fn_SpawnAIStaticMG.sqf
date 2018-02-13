/*
	DMS_fnc_SpawnAIStaticMG
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
		_group,			// GROUP: Group to which the AI unit(s) belongs to
		_class,			// STRING: "random","assault","MG","sniper" or "unarmed"
		_difficulty,	// STRING: "random","static","hardcore","difficult","moderate", or "easy"
		_side,			// STRING: "bandit","hero", etc.
		_MGClass		// (OPTIONAL) STRING: classname of the MG. Use "random" to select a random one from DMS_static_weapons
	] call DMS_fnc_SpawnAIStaticMG;

	Returns an array of static gun objects.
*/

if !(params
[
	"_positions",
	"_group",
	"_class",
	"_difficulty",
	"_side"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnAIStaticMG with invalid parameters: %1",_this];
};

private _MGClassInput = param [5, "random", [""]];


private _guns = _positions apply
{
	private _MGClass = _MGClassInput;
	if (_MGClass == "random") then
	{
		_MGClass = selectRandom DMS_static_weapons;
	};

	private _gun = createVehicle [_MGClass, [0,0,0], [], 0, "CAN_COLLIDE"];
	_gun setDir (random 360);
	_gun setPosATL _x;
	_gun lock 2;

	_group addVehicle _gun;

	private _unit = [_group,_x,_class,_difficulty,_side,"Static"] call DMS_fnc_SpawnAISoldier;

	_unit moveInGunner _gun;
	reload _unit;
	_unit setVariable ["DMS_AssignedVeh",_gun];

	if (_group getVariable ["DMS_isGroupFrozen",false]) then
	{
		_unit enableSimulationGlobal false;
	};

	if (DMS_DEBUG) then
	{
		(format ["SpawnAIStaticMG :: Created unit %1 at %2 as static gunner in %3",_unit,_x,_gun]) call DMS_fnc_DebugLog;
	};
	_gun
};


if (DMS_DEBUG) then
{
	(format ["SpawnAIStaticMG :: Created %1 static AI with parameters: %2",count _positions,_this]) call DMS_fnc_DebugLog;
};

_guns
