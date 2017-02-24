/*
	Sample mission (duplicate for testing purposes)
*/

private ["_num", "_side", "_OK", "_group", "_pos", "_difficulty", "_AICount", "_type", "_launcher", "_class", "_pinCode", "_vehicle", "_missionAIUnits", "_missionObjs", "_msgStart", "_msgWIN", "_msgLOSE", "_missionName", "_markers", "_time", "_added", "_cleanup"];

// For logging purposes
_num = DMS_MissionCount;


// Set mission side
_side = "bandit";


// This part is unnecessary, but exists just as an example to format the parameters for "DMS_fnc_MissionParams" if you want to explicitly define the calling parameters for DMS_fnc_FindSafePos.
// It also allows anybody to modify the default calling parameters easily.
if ((isNil "_this") || {_this isEqualTo [] || {!(_this isEqualType [])}}) then
{
	_this =
	[
		[15,DMS_WaterNearBlacklist,DMS_MinSurfaceNormal,DMS_SpawnZoneNearBlacklist,DMS_TraderZoneNearBlacklist,DMS_MissionNearBlacklist,DMS_PlayerNearBlacklist,DMS_TerritoryNearBlacklist,DMS_ThrottleBlacklists],
		[
			[]
		],
		_this
	];
};

// Check calling parameters for manually defined mission position.
// You can define "_extraParams" to specify the vehicle classname to spawn, either as _classname or [_classname]
_OK = (_this call DMS_fnc_MissionParams) params
[
	["_pos",[],[[]],[3]],
	["_extraParams",[]]
];

if !(_OK) exitWith
{
	diag_log format ["DMS ERROR :: Called MISSION thieves.sqf with invalid parameters: %1",_this];
};


// Set general mission difficulty
_difficulty = "easy";


// Create AI
_AICount = 3 + (round (random 1));

_group =
[
	_pos,					// Position of AI
	_AICount,				// Number of AI
	"hardcore",				// "random","hardcore","difficult","moderate", or "easy"
	"random", 				// "random","assault","MG","sniper" or "unarmed" OR [_type,_launcher]
	_side 					// "bandit","hero", etc.
] call DMS_fnc_SpawnAIGroup;


_class =
	if (_extraParams isEqualTo []) then
	{
		DMS_CarThievesVehicles call BIS_fnc_SelectRandom
	}
	else
	{
		if (_extraParams isEqualType "") then
		{
			_extraParams
		}
		else
		{
			if ((_extraParams isEqualType []) && {(_extraParams select 0) isEqualType ""}) then
			{
				_extraParams select 0
			}
			else
			{
				DMS_CarThievesVehicles call BIS_fnc_SelectRandom
			};
		};
	};

//DMS_fnc_SpawnPersistentVehicle will automatically turn the pincode into a string and format it.
_pinCode = 1000 + round (random 8999);

_vehicle = [_class,_pos,_pinCode] call DMS_fnc_SpawnPersistentVehicle;



// Define mission-spawned AI Units
_missionAIUnits =
[
	_group 		// We only spawned the single group for this mission
];

// Define mission-spawned objects
_missionObjs =
[
	[],			// No spawned buildings
	[_vehicle],
	[]
];

// Define Mission Start message
_msgStart = ['#FFFF00',format ["A band of thieves are attempting to break into a %1. Eliminate them and you might get the car for yourself!",getText (configFile >> "CfgVehicles" >> _class >> "displayName")]];

// Define Mission Win message
_msgWIN = ['#0080ff',format ["Convicts have eliminated the thieves! Looks like the thieves managed to figure out that the code was %1...",_pinCode]];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The thieves cracked the code and drove off!"];

// Define mission name (for map markers, mission messages, and logging)
_missionName = "Car Thieves";

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
			_group,
			true
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
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};
