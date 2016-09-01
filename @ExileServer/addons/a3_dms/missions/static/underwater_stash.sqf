/*
	"Underwater Stash" mission for Tanoa
	Created by eraser1
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [5884,2997,10];

// This mission should spawn on server start. Otherwise, if somebody is dumb enough to wait for it to spawn, then they're gonna get killed lol.
//if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


DMS_CrateCase_DiverGear =
[
    [
        "arifle_SDAR_F",
        "arifle_SDAR_F",
        "arifle_SDAR_F",
        "arifle_SDAR_F",
        "arifle_SDAR_F"
    ],
    [
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "U_O_Wetsuit",
        "U_O_Wetsuit",
        "U_O_Wetsuit",
        "U_O_Wetsuit",
        "U_O_Wetsuit",
        "V_RebreatherIA",
        "V_RebreatherIA",
        "V_RebreatherIA",
        "V_RebreatherIA",
        "V_RebreatherIA"
    ],
    [
        "B_Carryall_oli",
        "B_Bergen_tna_F",
        "B_ViperHarness_oli_F"
    ]
];

// I only made some of the variables in this file "private" because I couldn't bother making all of them private :p
private _crate = ["Box_IND_AmmoVeh_F",[5630,3100,0]] call DMS_fnc_SpawnCrate;
_crate setVariable ["DMS_AllowSmoke", false];


[_crate, "DiverGear"] call DMS_fnc_FillCrate;



private _sub1 = ["Exile_Boat_SDV_CSAT",[0,0,0]] call DMS_fnc_SpawnNonPersistentVehicle;
_sub1 setPosASL [5884,2997,-66];
_sub1 setVariable ["DMS_AllowSmoke", false];

private _sub2 = ["Exile_Boat_SDV_CSAT",[0,0,0]] call DMS_fnc_SpawnNonPersistentVehicle;
_sub2 setPosASL [5893.5,3037,-55];
_sub2 setVariable ["DMS_AllowSmoke", false];



private _diverGearSet =
[
    "arifle_SDAR_F",
    [],
    [["20Rnd_556x45_UW_mag",6]],
    "",
    [],
    ["Rangefinder","ItemGPS","NVGoggles"],
    "",
    "",
    "U_O_Wetsuit",
    "V_RebreatherIA",
    "B_Bergen_mcamo"
];


private _temp = DMS_ai_use_launchers;
DMS_ai_use_launchers = false;

private _diverGroup =
[
    [
        [5850.8,3048.1,-37.8057],
        [5863.21,3036.56,-38.2891],
        [5871.43,3054.4,-39.343],
        [5915.36,3021.77,-58.8748],
        [5905.08,2987.15,-65.313],
        [5877.29,2984.19,-60.6961],
        [5887.88,2986.54,-60.7556],
        [5909.77,3037.79,-52.0807],
        [5878.36,3045.98,-48.1157],
        [5845.63,3028.38,-49.0821],
        [5851.09,3009.14,-52.1915],
        [5856.83,3016.01,-49.785],
        [5869.44,3017.86,-49.7803],
        [5879.65,3022.51,-47.769],
        [5892.57,3030.16,-48.894],
        [5900.21,3031.82,-50.4109],
        [5882.36,3003.04,-55.3779],
        [5858.68,2977.79,-63.6817],
        [5899.83,3044.99,-51.4147],
        [5875.81,3007.73,-55.331],
        [5899.77,2994.57,-61.1307]
    ],
	21,
	"hardcore",
	"custom",
	_side,
    _diverGearSet
] call DMS_fnc_SpawnAIGroup_MultiPos;

DMS_ai_use_launchers = _temp;


{
    _x disableAI "PATH";
} forEach (units _diverGroup);





private _landGroup =
[
	[5633,3108,0],
	5,
	"hardcore",
	"sniper",
	"bandit"
] call DMS_fnc_SpawnAIGroup;



// Define mission-spawned AI Units
_missionAIUnits =
[
	_diverGroup, 		// We only spawned the single group for this mission
    _landGroup
];

// Define the group reinforcements
_groupReinforcementsInfo =
[
    // Removed reinforcements for this because while I was testing the mission the AI took too long to get back to the objective, and that's annoying
    /*
	[
		_diverGroup,			// pass the group
		[
			[
				-1,		// Let's limit number of units instead...
				0
			],
			[
				10,	    // Maximum 10 units can be given as reinforcements.
				0
			]
		],
		[
			180,		// About a 3 minute delay between reinforcements.
			diag_tickTime
		],
		[
            [5810,2874,1],
            [5933,2912,2],
            [5862,3132,0.5]
        ],
		"custom",
		"hardcore",
		_side,
		"reinforce",
		[
			5,			// Reinforcements will only trigger if there's fewer than 5 members left in the group
			3			// 3 reinforcement units per wave.
		],
        _diverGearSet
	]
    */
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	[],
	[_sub1, _sub2],
	[
        [
            _sub1,
            [
                1,
                [2,DMS_Box_BaseParts_Concrete],
                1
            ]
        ],
        [
            _sub2,
            [
                [2,DMS_sniper_weps],                // Spawn a random 5 weapons that AI snipers can spawn with.
                [5,DMS_BoxSurvivalSupplies],
                1
            ]
        ]
    ]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "The CSAT are storing money and supplies in an underwater stash! Eliminate them and take the supplies!"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully eliminated the CSAT and obtained the underwater stash!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Seems like CSAT forces moved their stash away..."];

// Define mission name (for map marker and logging)
_missionName = "Underwater Stash";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	"hardcore"
] call DMS_fnc_CreateMarker;

// Record time here (for logging purposes, otherwise you could just put "diag_tickTime" into the "DMS_AddMissionToMonitor" parameters directly)
_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		[
			"kill",
			_diverGroup              // Only need to kill the diver group.
		],
		[
			"playerNear",
			[_sub1,40]
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
	"hardcore",
	[],
    [
        [
            [
                _sub1,
                {_this setVariable ["ExileMoney",25000,true]}                       // The submarine will have 25,000 poptabs after the mission completes. The capacity is actually 5000, but I just overload it.
            ]
        ],
        [],
        {},
        {}
    ]
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
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,26,"hardcore",_time]) call DMS_fnc_DebugLog;
};
