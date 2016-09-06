/*
	"Occupation" static mission for Altis, Chernarus, Namalsk and Taviana
	Created by second_coming
*/

private["_wp","_wp2","_wp3","_pos","_missionName","_msgStart","_msgWIN","_msgLOSE"];

// For logging purposes
private _num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

switch (toLower worldName) do
{
	case "chernarus":
	{
		_pos = [3810,8887,0];
		_missionName = "Vybor Occupation";
		_msgStart = ['#FFFF00',"Vybor is under martial law! There are reports they have a large weapon cache..."];
		_msgWIN = ['#0080FF',"Convicts have successfully assaulted the town of Vybor and secured the cache!"];
		_msgLOSE = ['#FF0000',"The troops have left Vybor, taking the cache with them..."];
	};

	case "altis":
	{
		_pos = [12571,14337,0];
		_missionName = "Neochori Occupation";
		_msgStart = ['#FFFF00',"Neochori is under martial law! There are reports they have a large weapon cache..."];
		_msgWIN = ['#0080FF',"Convicts have successfully assaulted the town of Neochori and secured the cache!"];
		_msgLOSE = ['#FF0000',"The troops have left Neochori, taking the cache with them..."];
	};

	case "taviana":
	{
		_pos = [14000,12220,0];
		_missionName = "Solibor Occupation";
		_msgStart = ['#FFFF00',"Solibor is under martial law! There are reports they have a large weapon cache..."];
		_msgWIN = ['#0080FF',"Convicts have successfully assaulted the town of Solibor and secured the cache!"];
		_msgLOSE = ['#FF0000',"The troops have left Solibor, taking the cache with them..."];
	};

	case "namalsk":
	{
		_pos = [3926,7523,0];
		_missionName = "Norinsk Occupation";
		_msgStart = ['#FFFF00',"Norinsk is under martial law! There are reports they have a large weapon cache..."];
		_msgWIN = ['#0080FF',"Convicts have successfully assaulted the town of Norinsk and secured the cache!"];
		_msgLOSE = ['#FF0000',"The troops have left Norinsk, taking the cache with them..."];
	};

	case "napf":
	{
		_chance = random 100;
		if(_chance < 40) then
		{
			_pos = [8846.05,16066,0.00157166];
			_missionName = "Lenzburg Occupation";
			_msgStart = ['#FFFF00',"Lenzburg is under martial law! There are reports they have a large weapon cache..."];
			_msgWIN = ['#0080FF',"Convicts have successfully assaulted the town of Lenzburg and secured the cache!"];
			_msgLOSE = ['#FF0000',"The troops have left Lenzburg, taking the cache with them..."];
		}
		else
		{
			_pos = [2426.39,7712.04,0.00131989];
			_missionName = "Worb Occupation";
			_msgStart = ['#FFFF00',"Worb is under martial law! There are reports they have a large weapon cache..."];
			_msgWIN = ['#0080FF',"Convicts have successfully assaulted the town of Worb and secured the cache!"];
			_msgLOSE = ['#FF0000',"The troops have left Worb, taking the cache with them..."];
		};

	};
	
	case "tanoa":
	{
		_chance = random 100;
		if(_chance < 40) then
		{
			_pos = [11621,2648.86,0];
			_missionName = "Lijnhaven Occupation";
			_msgStart = ['#FFFF00',"Lijnhaven is under martial law! There are reports they have a large weapon cache..."];
			_msgWIN = ['#0080FF',"Convicts have successfully assaulted the town of Lijnhaven and secured the cache!"];
			_msgLOSE = ['#FF0000',"The troops have left Lijnhaven, taking the cache with them..."];
		}
		else
		{
			_pos = [5850.64,10216.4,0];
			_missionName = "Georgetown Occupation";
			_msgStart = ['#FFFF00',"Georgetown is under martial law! There are reports they have a large weapon cache..."];
			_msgWIN = ['#0080FF',"Convicts have successfully assaulted the town of Georgetown and secured the cache!"];
			_msgLOSE = ['#FF0000',"The troops have left Georgetown, taking the cache with them..."];
		};
	};			
	
	default
	{
	    diag_log format["DMS ERROR :: Attempting to run occupation with unsupported map: %1",worldName];
	};
};

if (isNil "_pos") exitWith {};

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

diag_log text "[DMS]: Town Occupation Mission Started";


// Set general mission difficulty
_difficulty = "hardcore";


// Create AI
_AICount 		= 27;
_group1Count 	= ceil(_AICount/3);
_group2Count 	= ceil(_AICount/3);
_group3Count 	= ceil(_AICount/3);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get AI to defend the position
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_group = [_pos, _group1Count, _difficulty, "random", _side] call DMS_fnc_SpawnAIGroup;
[ _group,_pos,_difficulty,"COMBAT" ] call DMS_fnc_SetGroupBehavior;

_buildings = _pos nearObjects ["building", 200];
{
	_buildingPositions = [_x, 10] call BIS_fnc_buildingPositions;
	if(count _buildingPositions > 0) then
	{
		_y = _x;
		// Find Highest Point
		_highest = [0,0,0];
		{
			if(_x select 2 > _highest select 2) then
			{
				_highest = _x;
			};

		} foreach _buildingPositions;
		_spawnPosition = _highest;

		_i = _buildingPositions find _spawnPosition;
		_wp = _group addWaypoint [_spawnPosition,0] ;
		_wp setWaypointFormation "Column";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointCompletionRadius 1;
		_wp waypointAttachObject _y;
		_wp setwaypointHousePosition _i;
		_wp setWaypointType "MOVE";

	};

} foreach _buildings;
if(count _buildings > 0 ) then
{
	_wp setWaypointType "CYCLE";
};


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_group2 = [	_pos, _group2Count, _difficulty, "random", _side] call DMS_fnc_SpawnAIGroup;
[ _group2,_pos,_difficulty,"COMBAT" ] call DMS_fnc_SetGroupBehavior;

_buildings = _pos nearObjects ["building", 100];
{
	_buildingPositions = [_x, 10] call BIS_fnc_buildingPositions;
	if(count _buildingPositions > 0) then
	{
		_y = _x;
		// Find Highest Point
		_highest = [0,0,0];
		{
			if(_x select 2 > _highest select 2) then
			{
				_highest = _x;
			};

		} foreach _buildingPositions;
		_spawnPosition = _highest;

		_i = _buildingPositions find _spawnPosition;
		_wp2 = _group2 addWaypoint [_spawnPosition,0] ;
		_wp2 setWaypointFormation "Column";
		_wp2 setWaypointBehaviour "AWARE";
		_wp2 setWaypointCombatMode "RED";
		_wp2 setWaypointCompletionRadius 1;
		_wp2 waypointAttachObject _y;
		_wp2 setwaypointHousePosition _i;
		_wp2 setWaypointType "MOVE";
	};

} foreach _buildings;
if(count _buildings > 0 ) then
{
	_wp2 setWaypointType "CYCLE";
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_group3 = [_pos, _group3Count, _difficulty, "random", _side] call DMS_fnc_SpawnAIGroup;
[ _group3,_pos,_difficulty,"COMBAT" ] call DMS_fnc_SetGroupBehavior;

_buildings = _pos nearObjects ["building", 100];
{
	_buildingPositions = [_x, 10] call BIS_fnc_buildingPositions;
	if(count _buildingPositions > 0) then
	{
		_y = _x;
		// Find Highest Point
		_highest = [0,0,0];
		{
			if(_x select 2 > _highest select 2) then
			{
				_highest = _x;
			};

		} foreach _buildingPositions;
		_spawnPosition = _highest;

		_i = _buildingPositions find _spawnPosition;
		_wp3 = _group2 addWaypoint [_spawnPosition,0] ;
		_wp3 setWaypointFormation "Column";
		_wp3 setWaypointBehaviour "AWARE";
		_wp3 setWaypointCombatMode "RED";
		_wp3 setWaypointCompletionRadius 1;
		_wp3 waypointAttachObject _y;
		_wp3 setwaypointHousePosition _i;
		_wp3 setWaypointType "MOVE";

	};

} foreach _buildings;
if(count _buildings > 0 ) then
{
	_wp3 setWaypointType "CYCLE";
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Get the AI to shut the fuck up :)
enableSentences false;
enableRadio false;

// Create Crate
_crate = ["I_CargoNet_01_ammo_F",_pos] call DMS_fnc_SpawnCrate;


// Define mission-spawned AI Units
_missionAIUnits =
[
	[_group,_group2,_group3]
];

// Define the group reinforcements
_groupReinforcementsInfo = [];

// Define mission-spawned objects and loot values
_missionObjs =
[
	[_missionAIUnits],			// armed AI vehicle and static gun(s). Note, we don't add the base itself because we don't want to delete it and respawn it if the mission respawns.
	[],
	[[_crate,[30 + (random 20),100 + (random 40),15 + (random 5)]]]			// weapons,items,backpacks
];

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
			[_group,_group2,_group3]
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
