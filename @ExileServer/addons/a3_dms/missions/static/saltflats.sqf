/*
	"saltflats" static mission for Altis.
	Created by eraser1
	Credits to "Darth Rogue" for creating the base.
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [23300,18800,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Create AI
_AICount = 20 + (round (random 5));

_group =
[
	_pos,
	_AICount,
	_difficulty,
	"random",
	_side
] call DMS_fnc_SpawnAIGroup;

_veh =
[
	[
		[_pos,100,random 360] call DMS_fnc_SelectOffsetPos,
		_pos
	],
	_group,
	"assault",
	_difficulty,
	_side
] call DMS_fnc_SpawnAIVehicle;


_staticGuns =
[
	[
		[_pos,[-6.29138,3.9917,0]] call DMS_fnc_CalcPos
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"O_HMG_01_high_F"
] call DMS_fnc_SpawnAIStaticMG;

_baseObjs = [];
if (isNil "DMS_SaltFlatsBaseSpawned") then
{
	_baseObjs =
	[
		"saltflatsbase"
	] call DMS_fnc_ImportFromM3E_Static;
	DMS_SaltFlatsBaseSpawned = true;
};


// Create Crate
_crate = ["I_CargoNet_01_ammo_F",_pos] call DMS_fnc_SpawnCrate;


// Define mission-spawned AI Units
_missionAIUnits =
[
	_group 		// We only spawned the single group for this mission
];

// Define the group reinforcements
_groupReinforcementsInfo =
[
	[
		_group,			// pass the group
		[
			[
				5,		// Only 5 "waves" (5 vehicles can spawn as reinforcement)
				0
			],
			[
				-1,		// No need to limit the number of units since we're limiting "waves"
				0
			]
		],
		[
			300,		// At least a 5 minute delay between reinforcements.
			diag_tickTime
		],
		[
			[23239.7,18865.8,0],
			[23397,18862.8,0],
			[23485.5,18861.3,0],
			[23486,18683.9,0],
			[23493.1,18515.5,0],
			[23873.8,19413.2,0],
			[23211.9,18572.5,0],
			[23212.9,18751.7,0],
			[23211.5,18809.1,0]
		],
		"random",
		_difficulty,
		_side,
		"armed_vehicle",
		[
			7,			// Reinforcements will only trigger if there's fewer than 7 members left in the group
			"random"	// Select a random armed vehicle from "DMS_ArmedVehicles"
		]
	],
	[
		_group,			// pass the group (again)
		[
			[
				0,		// Let's limit number of units instead...
				0
			],
			[
				100,	// Maximum 100 units can be given as reinforcements.
				0
			]
		],
		[
			240,		// About a 4 minute delay between reinforcements.
			diag_tickTime
		],
		[
			[23500,18750,0.5],
			[23498,18715,0.5],
			[23461,18478.2,0],
			[23443,18495.3,0],
			[23424,18479.4,0],
			[23405.9,18497,0],
			[23387.1,18479.7,0],
			[23378.3,18497.6,0],
			[23359.2,18480,0],
			[23334.9,18479.2,0],
			[23295.1,18515.4,3.12796],
			[23242.7,18793.5,0.5],
			[23387.2,18638.5,0.5],
			[23294.6,18640.8,0.2],
			[23309.1,18683.1,0.6],
			[23308.5,18683,4],
			[23360.5,18686.3,4],
			[23362.9,18679,0.6],
			[23403.1,18685.1,0.6],
			[23420.9,18839.6,4.35],
			[23420.8,18843.4,12.35],
			[23421,18838.6,0.36],
			[23422.2,18823.8,0.4],
			[23502.1,18862.3,15.37],
			[23494.2,18478.6,15.37],
			[23206.6,18493.8,15.37],
			[23239.4,18561.1,0]
		],
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			10,			// Reinforcements will only trigger if there's fewer than 10 members left in the group
			7			// 7 reinforcement units per wave.
		]
	]
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	_staticGuns+[_veh],			// armed AI vehicle and static gun(s). Note, we don't add the base itself because we don't want to delete it and respawn it if the mission respawns.
	[],
	[[_crate,[75,250,25]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "A heavily guarded base has been located on the salt flats! There are reports they have a large weapon cache..."];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully assaulted the base on the salt flats and secured the cache!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Seems like the guards got bored and left the base, taking the cache with them..."];

// Define mission name (for map marker and logging)
_missionName = "AI Base";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

(_markers select 1) setMarkerSize [500,500];

// Record time here (for logging purposes, otherwise you could just put "diag_tickTime" into the "DMS_AddMissionToMonitor" parameters directly)
_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		[
			"kill",
			_group
		],
		[
			"playerNear",
			[_pos,100]
		]
	],
	_groupReinforcementsInfo,
	[
		_time,
		DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
	],
	_missionAIUnits,
	_missionObjs,
	[_missionName,_msgWIN,_msgLOSE],
	_markers,
	_side,
	_difficulty,
	[[],[]]
] call DMS_fnc_AddMissionToMonitor_Static;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));
	
	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;


	// Delete the markers directly
	{deleteMarker _x;} forEach _markers;


	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};


// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;



if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};