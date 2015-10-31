/*
	DMS_fnc_GroupReinforcementsManager
	Created by eraser1

	Usage:
	[
		_AIGroup,						// GROUP: The AI group to monitor.
		[
			[
				_maxReinforcementWaves,			// SCALAR: The maximum number of reinforcement waves that this group can receive. Set to -1 for unlimited reinforcement waves.
				_reinforcementWavesGiven		// SCALAR: The number of reinforcement waves given to this group.
			],
			[
				_maxReinforcementUnits,			// SCALAR: The maximum number of reinforcement units that this group can receive. Set to -1 for unlimited reinforcement units.
				_reinforcementUnitsGiven		// SCALAR: The number of reinforcement units given to this group.
			]
		],
		[
			_updateDelay,					// SCALAR: Delay in seconds until the AI group is reinforced.
			_lastUpdated					// SCALAR: The time (diag_tickTime) when the group was last reinforced.
		],
		_spawnLocations,				// ARRAY: Array of positions (ATL) where reinforcement AI can spawn. Passing an empty array will cause the group leader's position to be used. For "armed_vehicle" _monitorType, a random position between 100 and 300 meters from the leader is used.
		_class,							// STRING: The "class" of AI to spawn as reinforcements. Supported values: "random","assault","MG","sniper" or "unarmed"
		_difficulty,					// STRING: The difficulty of the AI to be spawned. Supported values: "random","static","hardcore","difficult","moderate", or "easy"
		_side,							// STRING: The "side" that the AI are on. Currently only "bandit" is supported.
		_monitorType,					// STRING: How the AI group should be managed. Supported types: "playernear", "maintain", "reinforce", "increasing_resistance", "armed_vehicle"
		_monitorParams					// ARRAY: Parameters specific to the _monitorType. See below.
	] call DMS_fnc_GroupReinforcementsManager;

	About "_monitorType" types:
		
		"playernear":
			_monitorParams =
			[
				_posOrObj,				// ARRAY (position): The position at which the players have to be near.
				_radius,				// SCALAR: The distance (in meters) that a player has to be near in order for reinforcements to spawn
				_reinforcementCount,	// SCALAR: The (maximum) number of units to spawn as reinforcements.
				_maxAICount				// (OPTIONAL) SCALAR: Maximum number of AI Units after reinforcements. Set to 0 for no limit. Default value is 0.
			]

		"maintain":
			_monitorParams =
			[
				_AICount 				// SCALAR: If the AI Group has fewer than "_AICount" living units, then new members will be added to the group until it has "_AICount" living units again.
			]

		"reinforce":
			_monitorParams =
			[
				_AICount,				// SCALAR: If the AI Group has fewer than "_AICount" living units, then the group will receive reinforcements.
				_reinforcementCount,	// SCALAR: The (maximum) number of units to spawn as reinforcements.
				_maxAICount				// (OPTIONAL) SCALAR: Maximum number of AI Units after reinforcements. Set to 0 for no limit. Default value is equivalent to _AICount.
			]

		"increasing_resistance":
			_monitorParams =
			[
				_AICount,				// SCALAR: If the AI Group has fewer than "_AICount" living units, then the group will receive reinforcements.
				_reinforcementCount,	// SCALAR: The (maximum) number of units to spawn as reinforcements.
				_increment_AICount,		// SCALAR: After reinforcements, "_AICount" is increased by this amount, so subsequent reinforcements will be spawned for even greater amounts of AI (increasing the number of total AI, until "_maxAICount" is reached).
				_maxAICount				// (OPTIONAL) SCALAR: Maximum number of AI Units after reinforcements. Default value is equivalent to _AICount. Set to 0 for no limit.
			]

		"armed_vehicle":
			_monitorParams =
			[
				_AICount,				// SCALAR: If the AI Group has fewer than "_AICount" living units, then the group will receive reinforcements.
				_vehClass				// (OPTIONAL) STRING: The classname of the vehicle to spawn. Use "random" to select a random vehicle from "DMS_ArmedVehicles". Default: "random"
			]
		NOTE: Every reinforcement vehicle as one unit given for monitor type "armed_vehicle"

	Returns whether or not reinforcement waves or units given exceeds/matches maximum wave or unit reinforcements. If true, then no more reinforcements will be spawned (so the passed info should be deleted from the available reinforcements list).
*/

private ["_AIGroup", "_reinforcementInfo", "_updateInfo", "_spawnLocations", "_class", "_difficulty", "_side", "_monitorType", "_monitorParams", "_wavesInfo", "_unitsInfo", "_maxReinforcementWaves", "_reinforcementWavesGiven", "_maxReinforcementUnits", "_reinforcementUnitsGiven", "_updateDelay", "_lastUpdated", "_fnc_isDepleted", "_reinforcementsDepleted"];

// Check ALL the variables

if !(params
[
	["_AIGroup",			grpNull,	[grpNull]			],
	["_reinforcementInfo",	[],			[[]],		[2]		],
	["_updateInfo",			[],			[[]],		[2]		],
	["_spawnLocations",		[],			[[]]				],
	["_class",				"",			[""]				],
	["_difficulty",			"",			[""]				],
	["_side",				"",			[""]				],
	["_monitorType",		"",			[""]				],
	["_monitorParams",		[],			[[]]				]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid parameters: %1",_this];
	true
};


if !(_reinforcementInfo params
[
	["_wavesInfo", [], [[]]],
	["_unitsInfo", [], [[]]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _reinforcementInfo: %1",_reinforcementInfo];
	true
};


if !(_wavesInfo params
[
	["_maxReinforcementWaves", -1, [0]],
	["_reinforcementWavesGiven", 0, [0]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _wavesInfo: %1",_wavesInfo];
	true
};


if !(_unitsInfo params
[
	["_maxReinforcementUnits", -1, [0]],
	["_reinforcementUnitsGiven", 0, [0]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _unitsInfo: %1",_unitsInfo];
	true
};


if !(_updateInfo params
[
	["_updateDelay", 300, [0]],
	["_lastUpdated", 0, [0]]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _updateInfo: %1",_updateInfo];
	true
};



_fnc_isDepleted =
{
	switch (true) do
	{
		// Both "_maxReinforcementWaves" and "_maxReinforcementUnits" are limited, so we check both.
		case ((_maxReinforcementWaves>0) && {_maxReinforcementUnits>0}): {((_reinforcementWavesGiven>=_maxReinforcementWaves) || {_reinforcementUnitsGiven>=_maxReinforcementUnits})};

		// Only "_maxReinforcementWaves" is limited.
		case (_maxReinforcementWaves>0): {(_reinforcementWavesGiven>=_maxReinforcementWaves)};

		// Only "_maxReinforcementUnits" is limited.
		case (_maxReinforcementUnits>0): {(_reinforcementUnitsGiven>=_maxReinforcementUnits)};

		// Neither are limited, so reinforcements will never be depleted.
		default {false};
	};
};

_reinforcementsDepleted = call _fnc_isDepleted;

if (!_reinforcementsDepleted && {(diag_tickTime-_lastUpdated)>_updateDelay}) then
{
	private ["_remainingUnits", "_unitsToSpawn"];

	if (isNull _AIGroup) then
	{
		// The group (presumably) lost all units and got deleted, so we create a new group using the given side and continue with that.
		_remainingUnits = 0;
		_AIGroup = createGroup (missionNamespace getVariable [format ["DMS_%1Side",_side],EAST]);

		_this set [0, _AIGroup];


		if (DMS_DEBUG) then
		{
			(format ["GroupReinforcementsManager :: Group provided was null! Created new group for ""%1"" side: %2",_side, _AIGroup]) call DMS_fnc_DebugLog;
		};
	}
	else
	{
		_remainingUnits = {alive _x} count (units _AIGroup);
	};


	if (DMS_DEBUG) then
	{
		(format ["GroupReinforcementsManager :: Checking reinforcements for group %1 with %2 surviving units. _this: %3",_AIGroup, _remainingUnits, _this]) call DMS_fnc_DebugLog;
	};

	switch (toLower _monitorType) do
	{
		case "playernear":
		{
			private ["_posOrObj", "_radius", "_reinforcementCount", "_maxAICount"];

			if !(_monitorParams params
			[
				["_posOrObj", [], [objNull,[]], [2,3]],
				["_radius", 0, [0]],
				["_reinforcementCount", 0, [0]]
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};


			if ([_posOrObj,_radius] call DMS_fnc_IsPlayerNearby) then
			{
				_maxAICount = if ((count _monitorParams)>3) then {_monitorParams param [3, 0, [0]]} else {0};

				_unitsToSpawn = _reinforcementCount min ((_maxAICount-_remainingUnits) max 0);
			};
		};

		case "maintain":
		{
			private "_AICount";

			if !(_monitorParams params
			[
				["_AICount", 0, [0]]
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};


			if (_remainingUnits<_AICount) then
			{
				_unitsToSpawn = _AICount - _remainingUnits;
			};
		};

		case "reinforce":
		{
			private ["_AICount", "_reinforcementCount", "_maxAICount"];

			if !(_monitorParams params
			[
				["_AICount", 0, [0]],
				["_reinforcementCount", 0, [0]]
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};

			
			if (_remainingUnits<_AICount) then
			{
				_maxAICount = if ((count _monitorParams)>2) then {_monitorParams param [2, 0, [0]]} else {_AICount};

				_unitsToSpawn = _reinforcementCount min ((_maxAICount-_remainingUnits) max 0);
			};
		};

		case "increasing_resistance":
		{
			private ["_AICount", "_reinforcementCount", "_increment_AICount", "_maxAICount"];

			if !(_monitorParams params
			[
				["_AICount", 0, [0]],
				["_reinforcementCount", 0, [0]],
				["_increment_AICount", 0, [0]]
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};


			if (_remainingUnits<_AICount) then
			{
				_maxAICount = if ((count _monitorParams)>3) then {_monitorParams param [3, 0, [0]]} else {_AICount};

				_unitsToSpawn = _reinforcementCount min ((_maxAICount-_remainingUnits) max 0);

				_monitorParams set [0, _AICount + _increment_AICount];
			};
		};

		case "armed_vehicle":
		{
			private ["_AICount", "_vehClass", "_leaderPos", "_veh"];

			if !(_monitorParams params
			[
				["_AICount", 0, [0]]
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};

			if (_remainingUnits<_AICount) then
			{
				_vehClass = if ((count _monitorParams)>1) then {_monitorParams param [1, "", [""]]} else {"random"};

				_leaderPos = getPosATL (leader _AIGroup);

				_veh =
				[
					[
						if (_spawnLocations isEqualTo []) then {[_leaderPos,100+(random 200),random 360] call DMS_fnc_SelectOffsetPos} else {_spawnLocations call BIS_fnc_selectRandom},
						_leaderPos
					],
					_AIGroup,
					_class,
					_difficulty,
					_side,
					_vehClass
				] call DMS_fnc_SpawnAIVehicle;

				// Every vehicle counts as one unit given, so the number of units given is equivalent to number of waves given.
				_reinforcementWavesGiven = _reinforcementWavesGiven + 1;
				_reinforcementUnitsGiven = _reinforcementWavesGiven;

				if (DMS_DEBUG) then
				{
					(format["GroupReinforcementsManager :: Group %1 received a ""%2"" vehicle (%3) as reinforcements.",_AIGroup, _vehClass, _veh]) call DMS_fnc_DebugLog;
				};
			};
		};
		
		default
		{
			_reinforcementsDepleted = true;
			diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with unsupported _monitorType: %1 | Setting _reinforcementsDepleted to true.",_monitorType];
		};
	};

	if ((!isNil "_unitsToSpawn") && {_unitsToSpawn>0}) then
	{
		private ["_spawnPos", "_units"];

		if (_spawnLocations isEqualTo []) then
		{
			_spawnPos = getPosATL (leader _AIGroup);
		};

		if (_maxReinforcementUnits>0) then
		{
			_maxAvailableReinforcements = (_maxReinforcementUnits-_reinforcementUnitsGiven) max 0;
			if (_maxAvailableReinforcements<_unitsToSpawn) then
			{
				if (DMS_DEBUG) then
				{
					(format["GroupReinforcementsManager :: Group %1 requested %2 units for backup, but only %3 are available. Providing %3 units and setting _reinforcementsDepleted to true.",_AIGroup, _unitsToSpawn, _maxAvailableReinforcements]) call DMS_fnc_DebugLog;
				};
				_unitsToSpawn = _maxAvailableReinforcements;
				_reinforcementsDepleted = true;
			};
		};

		_units = [];

		for "_i" from 1 to _unitsToSpawn do
		{
			if (isNil "_spawnPos") then
			{
				_spawnPos = _spawnLocations call BIS_fnc_selectRandom;
			};

			_units pushBack ([_AIGroup,[_spawnPos,1+(random 3),random 360] call DMS_fnc_SelectOffsetPos,_class,_difficulty,_side,"Soldier"] call DMS_fnc_SpawnAISoldier);
		};

		_units joinSilent _AIGroup;	// Otherwise they don't like each other...

		// Update the given reinforcements count.
		_reinforcementWavesGiven = _reinforcementWavesGiven + 1;
		_reinforcementUnitsGiven = _reinforcementUnitsGiven + _unitsToSpawn;

		if (DMS_DEBUG) then
		{
			(format["GroupReinforcementsManager :: Group %1 received %2 units as backup (wave #%3, %4 units given total). Reinforcements Depleted: %5",_AIGroup, _unitsToSpawn, _reinforcementWavesGiven, _reinforcementUnitsGiven, _reinforcementsDepleted]) call DMS_fnc_DebugLog;
		};
	};

	if (!_reinforcementsDepleted) then
	{
		_reinforcementsDepleted = call _fnc_isDepleted;
	};

	// Update values
	_this set [1, [[_maxReinforcementWaves,_reinforcementWavesGiven],[_maxReinforcementUnits,_reinforcementUnitsGiven]]];
	_this set [2, [_updateDelay,diag_tickTime]];
};



_reinforcementsDepleted