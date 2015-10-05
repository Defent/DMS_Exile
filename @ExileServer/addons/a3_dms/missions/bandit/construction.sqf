/*
	Sample mission (duplicate for testing purposes)
*/

private ["_num", "_side", "_pos", "_difficulty", "_AICount", "_group", "_crate", "_crate_loot_values", "_msgStart", "_msgWIN", "_msgLOSE", "_missionName", "_missionAIUnits", "_missionObjs", "_markers", "_time", "_added","_wreck1","_wreck2","_wreck3","_vehicle"];

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";


// find position
_pos = 
[
	25,DMS_WaterNearBlacklist,DMS_MaxSurfaceNormal,DMS_SpawnZoneNearBlacklist,DMS_TraderZoneNearBlacklist,DMS_MissionNearBlacklist,DMS_PlayerNearBlacklist,DMS_ThrottleBlacklists
]call DMS_fnc_findSafePos;


// Set general mission difficulty
_difficulty = "hardcore";


// Create AI
// TODO: Spawn AI only when players are nearby
_AICount = 5 + (round (random 2));

_group =
[
	_pos,					// Position of AI
	_AICount,				// Number of AI
	"hardcore",				// "random","hardcore","difficult","moderate", or "easy"
	"random", 				// "random","assault","MG","sniper" or "unarmed" OR [_type,_launcher]
	_side 					// "bandit","hero", etc.
] call DMS_fnc_SpawnAIGroup;


// Create Crate
_crate = ["Box_NATO_Wps_F",[(_pos select 0)+2,(_pos select 1)-1,0]] call DMS_fnc_SpawnCrate;

_wreck1 = createVehicle ["Land_CinderBlocks_F",[(_pos select 0) - 10, (_pos select 1),-0.1],[], 0, "CAN_COLLIDE"];
_wreck2 = createVehicle ["Land_Bricks_V1_F",[(_pos select 0) - 5, (_pos select 1),-3.3],[], 0, "CAN_COLLIDE"];
_wreck3 = createVehicle ["Land_Bricks_V1_F",[(_pos select 0) - 13, (_pos select 1),-1],[], 0, "CAN_COLLIDE"];

_vehicle = ["Exile_Car_Zamak",_pos] call DMS_fnc_SpawnNonPersistentVehicle;


// Set crate loot values
_crate_loot_values =
[
	3,		// Weapons
	[15,["Exile_Item_WoodWallKit","Exile_Item_WoodWallHalfKit","Exile_Item_WoodDoorwayKit","Exile_Item_WoodDoorKit","Exile_Item_Codelock","Exile_Item_PortableGeneratorKit","Exile_Item_WoodFloorKit","Exile_Item_WoodFloorPortKit"]],		// Items
	2 		// Backpacks
];


// Define mission-spawned AI Units
_missionAIUnits =
[
	_group 		// We only spawned the single group for this mission
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	[_wreck1,_wreck2,_wreck3],			// No spawned buildings
	[_vehicle],
	[[_crate,_crate_loot_values]]
];

// Define Mission Start message
_msgStart = ['#FFFF00',"A group of mercenaries have set up a construction site. Clear them out!"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully demolished the construction site!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The mercenaries have dismantled their construction site and escaped!"];


// Define mission name (for map marker and logging)
_missionName = "Construction Site";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
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
			_group
		],
		[
			"playerNear",
			[_pos,DMS_playerNearRadius]
		]
	],
	[
		_time,
		(DMS_MissionTimeOut select 0) + random((DMS_MissionTimeOut select 1) - (DMS_MissionTimeOut select 0))
	],
	_missionAIUnits,
	_missionObjs,
	[_missionName,_msgWIN,_msgLOSE],
	_markers,
	_side,
	_difficulty,
	[]
] call DMS_fnc_AddMissionToMonitor;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_AddMissionToMonitor! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	// Delete AI units and the crate. I could do it in one line but I just made a little function that should work for every mission (provided you defined everything correctly)
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
	diag_log format ["DMS_DEBUG MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time];
};