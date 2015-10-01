/*
	DMS_fnc_SetGroupBehavior
	Created by eraser1

	Usage:
	[
		_group,
		_pos,
		_difficulty
	] call DMS_fnc_SetGroupBehavior;

*/

private ["_OK", "_group", "_behavior", "_pos", "_difficulty", "_radius", "_npos", "_i", "_wp"];

_OK = params
[
	["_group",grpNull,[grpNull]],
	["_pos",[0,0,0],[[]],[2,3]],
	["_difficulty","moderate",[""]]
];

if (!_OK) then
{
	diag_log format ["DMS ERROR :: Calling DMS_SetGroupBehavior with invalid params: %1",_this];
};


_behavior = "COMBAT";

// Mostly for DMS_fnc_SpawnAIVehicle, since setting behavior to COMBAT makes the driving suck...
if (((count _this)>3)) then
{
	_behavior = _this select 3;
};

_group setCombatMode "RED";
_group setBehaviour _behavior;


if(_difficulty == "random") then
{
	_difficulty = DMS_ai_skill_random call BIS_fnc_selectRandom;
};

_radius = missionNamespace getVariable [format["DMS_AI_WP_Radius_%1",_difficulty],40];


// Remove all previous waypoints
for "_i" from count (waypoints _group) to 1 step -1 do
{
	deleteWaypoint ((waypoints _group) select _i);
};

// Add waypoints around the center position.
for "_i" from 0 to 359 step 45 do
{
	_npos = [(_pos select 0) + (sin(_i)*_radius), (_pos select 1) + (cos(_i)*_radius)];
	_wp = _group addWaypoint [_npos,(_radius/5)];
	_wp setWaypointType "MOVE";
};

_wp = _group addWaypoint [_pos,_radius];
_wp setWaypointType "CYCLE";
