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
		_monitorParams,					// ARRAY: Parameters specific to the _monitorType. See below.
		_customGearSet					// (OPTIONAL) ARRAY: The custom gear set of the AI. Refer to documentation of fn_SpawnAISoldier.sqf for more info: https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/scripts/fn_SpawnAISoldier.sqf
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

		"increasing_difficulty":
			_monitorParams =
			[
				_AICount,				// SCALAR: If the AI Group has fewer than "_AICount" living units, then the group will receive reinforcements.
				_reinforcementCount,	// SCALAR: The (maximum) number of units to spawn as reinforcements.
				_maxAICount				// (OPTIONAL) SCALAR: Maximum number of AI Units after reinforcements. Default value is equivalent to _AICount. Set to 0 for no limit.
			]

		"static_gunner":
			_monitorParams =
			[
				_staticGun,				// OBJECT: If this object (static gun) loses its gunner and/or is deleted, then a new static gun and/or gunner will spawn to replace the previous one.
				_gunPos,				// ARRAY (positionATL): The position of the static gun.
				_staticGunClass			// (OPTIONAL) STRING: The classname of the static gun to spawn as reinforcement.
			]

		"armed_vehicle":
			_monitorParams =
			[
				_AICount,				// SCALAR: If the AI Group has fewer than "_AICount" living units, then the group will receive reinforcements.
				_vehClass				// (OPTIONAL) STRING: The classname of the vehicle to spawn. Use "random" to select a random vehicle from "DMS_ArmedVehicles". Default: "random"
			]

		"armed_vehicle_replace":
			_monitorParams =
			[
				_vehicle,				// OBJECT: When this vehicle is null or dead, then this group will receive reinforcements. The spawned vehicle will then be the new _vehicle.
				_vehClass				// (OPTIONAL) STRING: The classname of the vehicle to spawn. Use "random" to select a random vehicle from "DMS_ArmedVehicles". Default: "random"
			]
		NOTE: Every reinforcement vehicle counts as one unit given for monitor type "armed_vehicle" and "armed_vehicle_replace"

		"heli_troopers":
			_monitorParams =
			[
				_AICount,				// SCALAR: If the AI Group has fewer than "_AICount" living units, then the group will receive reinforcements.
		        _ejectFFVGunners,               // BOOLEAN: Whether or not to eject Fire-From-Vehicle (FFV) gunners.
		        _maxJumpers,                    // SCALAR: Maximum number of AI to eject from the aircraft. Set to a really high # to ignore (like 999).
		        _remainAsGunship,               // BOOLEAN: Whether or not to keep the heli flying around as a gunship.
		        _dropPoint,                     // OBJECT or ARRAY (OPTIONAL - Position2D or 3D): The location to drop the reinforcements at. The drop point will default to the group leader.
		        _heliClass,                     // STRING (OPTIONAL): The classname of the heli to spawn.
		        _spawnPos                       // ARRAY (OPTIONAL - Position2D or 3D): The position for the heli to spawn at.
			]
			This reinforcement type will attempt to drop the AI off at the group leader's position. The heli will spawn in the air 500-5000 meters away from the leader's position and 1000 meters away from a player (default).

	Returns whether or not reinforcement waves or units given exceeds/matches maximum wave or unit reinforcements. If true, then no more reinforcements will be spawned (so the passed info should be deleted from the available reinforcements list).
*/

// Check ALL the variables
if !(params
[
	"_AIGroup",
	"_reinforcementInfo",
	"_updateInfo",
	"_spawnLocations",
	"_class",
	"_difficulty",
	"_side",
	"_monitorType",
	"_monitorParams"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid parameters: %1",_this];
	true
};


if !(_reinforcementInfo params
[
	"_wavesInfo",
	"_unitsInfo"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _reinforcementInfo: %1",_reinforcementInfo];
	true
};


if !(_wavesInfo params
[
	"_maxReinforcementWaves",
	"_reinforcementWavesGiven"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _wavesInfo: %1",_wavesInfo];
	true
};


if !(_unitsInfo params
[
	"_maxReinforcementUnits",
	"_reinforcementUnitsGiven"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _unitsInfo: %1",_unitsInfo];
	true
};


if !(_updateInfo params
[
	"_updateDelay",
	"_lastUpdated"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _updateInfo: %1",_updateInfo];
	true
};

private _customGearSet =
	if ((count _this) > 9) then
	{
		_this select 9
	}
	else
	{
		[]
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

private _reinforcementsDepleted = call _fnc_isDepleted;

if (!_reinforcementsDepleted && {(diag_tickTime-_lastUpdated)>_updateDelay}) then
{
	private "_unitsToSpawn";

	private _remainingUnits =
		if (isNull _AIGroup) then
		{
			// The group (presumably) lost all units and got deleted, so we create a new group using the given side and continue with that.
			_AIGroup = createGroup (missionNamespace getVariable [format ["DMS_%1Side",_side],EAST]);

			_this set [0, _AIGroup];


			if (DMS_DEBUG) then
			{
				(format ["GroupReinforcementsManager :: Group provided was null! Created new group for ""%1"" side: %2",_side, _AIGroup]) call DMS_fnc_DebugLog;
			};

			0
		}
		else
		{
			{alive _x} count (units _AIGroup);
		};


	if (DMS_DEBUG) then
	{
		(format ["GroupReinforcementsManager :: Checking reinforcements for group %1 with %2 surviving units. _this: %3",_AIGroup, _remainingUnits, _this]) call DMS_fnc_DebugLog;
	};

	switch (toLower _monitorType) do
	{
		case "playernear":
		{
			if !(_monitorParams params
			[
				"_posOrObj",
				"_radius",
				"_reinforcementCount"
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};


			if ([_posOrObj,_radius] call DMS_fnc_IsPlayerNearby) then
			{
				private _maxAICount = _monitorParams param [3, 0, [0]];

				_unitsToSpawn = _reinforcementCount min ((_maxAICount-_remainingUnits) max 0);
			};
		};

		case "maintain":
		{
			if !(_monitorParams params
			[
				"_AICount"
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
			if !(_monitorParams params
			[
				"_AICount",
				"_reinforcementCount"
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};


			if (_remainingUnits<_AICount) then
			{
				private _maxAICount = _monitorParams param [2, _AICount, [0]];

				_unitsToSpawn = _reinforcementCount min ((_maxAICount-_remainingUnits) max 0);
			};
		};

		case "increasing_resistance":
		{
			if !(_monitorParams params
			[
				"_AICount",
				"_reinforcementCount",
				"_increment_AICount"
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};


			if (_remainingUnits<_AICount) then
			{
				private _maxAICount = _monitorParams param [3, _AICount, [0]];

				_unitsToSpawn = _reinforcementCount min ((_maxAICount-_remainingUnits) max 0);

				_monitorParams set [0, _AICount + _increment_AICount];
			};
		};

		case "increasing_difficulty":
		{
			if !(_monitorParams params
			[
				"_AICount",
				"_reinforcementCount"
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};


			if (_remainingUnits<_AICount) then
			{
				_difficulty =
					switch (toLower _difficulty) do
					{
						case "easy": {"moderate"};
						case "moderate": {"difficult"};
						case "difficult";
						case "hardcore": {"hardcore"};
					};

				private _maxAICount = _monitorParams param [3, _AICount, [0]];

				_unitsToSpawn = _reinforcementCount min ((_maxAICount-_remainingUnits) max 0);
			};
		};

		case "armed_vehicle":
		{
			if !(_monitorParams params
			[
				"_AICount"
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};

			if (_remainingUnits<_AICount) then
			{
				private _vehClass = _monitorParams param [1, "random", [""]];

				private _leaderPos = getPosATL (leader _AIGroup);

				private _veh =
				[
					[
						if (_spawnLocations isEqualTo []) then {_leaderPos getPos [100+(random 200),random 360]} else {selectRandom _spawnLocations},
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

		case "armed_vehicle_replace":
		{
			if !(_monitorParams params
			[
				"_vehicle"
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};

			if ((isNull _vehicle) || {!alive _vehicle} || {(count (crew _vehicle)) isEqualTo 0}) then
			{
				deleteVehicle _vehicle;

				private _vehClass = _monitorParams param [1, "random", [""]];

				private _leaderPos = getPosATL (leader _AIGroup);

				_vehicle =
				[
					[
						if (_spawnLocations isEqualTo []) then {[_leaderPos,100+(random 200),random 360] call DMS_fnc_SelectOffsetPos} else {selectRandom _spawnLocations},
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

				_monitorParams set [0, _vehicle];

				if (DMS_DEBUG) then
				{
					(format["GroupReinforcementsManager :: Group %1 received a ""%2"" vehicle (%3) as reinforcements.",_AIGroup, _vehClass, _vehicle]) call DMS_fnc_DebugLog;
				};
			};
		};

		case "static_gunner":
		{
			if !(_monitorParams params
			[
				"_staticGun",
				"_gunPos"
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};

			if ((isNull _staticGun) || {!alive _staticGun} || {(count (crew _staticGun)) isEqualTo 0}) then
			{
				deleteVehicle _staticGun;

				private _staticGunClass = _monitorParams param [1, "random", [""]];

				private _leaderPos = getPosATL (leader _AIGroup);

				_staticGun =
				[
					[
						_gunPos
					],
					_AIGroup,
					_class,
					_difficulty,
					_side,
					_staticGunClass
				] call DMS_fnc_SpawnAIStaticMG;

				// Every vehicle counts as one unit given, so the number of units given is equivalent to number of waves given.
				_reinforcementWavesGiven = _reinforcementWavesGiven + 1;
				_reinforcementUnitsGiven = _reinforcementWavesGiven;

				_monitorParams set [0, _staticGun];

				if (DMS_DEBUG) then
				{
					(format["GroupReinforcementsManager :: Group %1 received a ""%2"" static gun (%3) as reinforcement at %4.",_AIGroup, _staticGunClass, _staticGun, _gunPos]) call DMS_fnc_DebugLog;
				};
			};
		};

		case "heli_troopers":
		{
			if !(_monitorParams params
			[
				"_AICount",
				"_ejectFFVGunners",
			    "_maxJumpers",
			    "_remainAsGunship"
			])
			exitWith
			{
				_reinforcementsDepleted = true;
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GroupReinforcementsManager with invalid _monitorParams: %1 | _monitorType: %2 | Setting _reinforcementsDepleted to true.",_monitorParams,_monitorType];
			};

			if (_remainingUnits<_AICount) then
			{
				private _dropPoint = _monitorParams param [4, getPosATL (leader _AIGroup), [objNull,[]], [2,3]];
				private _heliClass = _monitorParams param [5, selectRandom DMS_ReinforcementHelis, [""]];

				private _params =
				[
			        _AIGroup,
			        _class,
			        _difficulty,
			        _side,
			        _dropPoint,
			        _ejectFFVGunners,
					_maxJumpers,
			        _remainAsGunship,
					_heliClass
			    ];

				if ((count _monitorParams)>6) then
				{
					_params pushBack (_monitorParams select 6);
				};

				private _heli = _params call DMS_fnc_SpawnHeliReinforcement;

				// Every vehicle counts as one unit given, so the number of units given is equivalent to number of waves given.
				_reinforcementWavesGiven = _reinforcementWavesGiven + 1;
				_reinforcementUnitsGiven = _reinforcementWavesGiven;


				if (DMS_DEBUG) then
				{
					(format["GroupReinforcementsManager :: Group %1 received a ""%2"" vehicle (%3) as reinforcements.", _AIGroup, typeOf _heliClass, _heli]) call DMS_fnc_DebugLog;
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
		private _spawnPos = [];

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

		private _units = [];

		if (_spawnLocations isEqualTo []) then
		{
			// No spawn locations were provided, so we just use the leader of the group as the spawn location.
			_spawnPos = getPosATL (leader _AIGroup);

			for "_i" from 0 to (_unitsToSpawn-1) do
			{
				_units pushBack ([_AIGroup,_spawnPos,_class,_difficulty,_side,"Soldier",_customGearSet] call DMS_fnc_SpawnAISoldier);
			};
		}
		else
		{
			// Shuffle the list.
			private _spawningLocations = _spawnLocations call ExileClient_util_array_shuffle;
			_spawnPos = _spawningLocations select 0;				// Define it for spawning flares
			_spawningLocations_count = count _spawningLocations;

			// Add extra spawning locations if there are not enough.
			for "_i" from 0 to (_unitsToSpawn-_spawningLocations_count-1) do
			{
				_spawningLocations pushBack (selectRandom _spawningLocations);
			};

			// Now to spawn the AI...
			for "_i" from 0 to (_unitsToSpawn-1) do
			{
				_units pushBack ([_AIGroup,_spawningLocations select _i,_class,_difficulty,_side,"Soldier",_customGearSet] call DMS_fnc_SpawnAISoldier);
			};
		};

		_units joinSilent _AIGroup;		// Otherwise they don't like each other...

		// Update the given reinforcements count.
		_reinforcementWavesGiven = _reinforcementWavesGiven + 1;
		_reinforcementUnitsGiven = _reinforcementUnitsGiven + _unitsToSpawn;

		if (DMS_SpawnFlareOnReinforcements) then
		{
			playSound3D ["a3\missions_f_beta\data\sounds\Showcase_Night\flaregun_4.wss", objNull, false, (ATLToASL _spawnPos) vectorAdd [0,0,250],2];
			("F_20mm_Red" createVehicle (_spawnPos vectorAdd [0,0,250])) setVelocity [0,0,-1];
		};

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
