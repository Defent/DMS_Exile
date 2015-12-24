/*
	DMS_fnc_SetGroupBehavior
	Created by eraser1

	Usage:
	[
		_group,							// GROUP or OBJECT: Group or unit to change the behavior of
		_pos,							// ARRAY (positionATL): Location for the AI to guard
		_difficulty,					// STRING: Difficulty of the AI
		_behavior						// (OPTIONAL) STRING: AI Behavior. Refer to: https://community.bistudio.com/wiki/setBehaviour
	] call DMS_fnc_SetGroupBehavior;

	Returns true if the call was completed
*/

private ["_OK", "_exit", "_group", "_behavior", "_pos", "_difficulty", "_radius", "_npos", "_i", "_wp"];


if !(params
[
	["_group",grpNull,[grpNull,objNull]],
	["_pos",[0,0,0],[[]],[2,3]],
	["_difficulty","moderate",[""]]
])
then
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SetGroupBehavior with invalid params: %1",_this];
};

_exit = false;

try
{
	if (isNull _group) throw "_group is null!";

	if (_group isEqualType objNull) then
	{
		if !(alive _group) throw "_group is a dead object!";
		
		_group = group _group;
	};
}
catch
{
	_exit = true;
	if (DMS_DEBUG) then
	{
		format["SetGroupBehavior :: Exiting function because %1", _exception] call DMS_fnc_DebugLog;
	};
};

if (_exit) exitWith {false};


// Mostly for DMS_fnc_SpawnAIVehicle, since setting behavior to COMBAT makes the driving suck...
_behavior = if ((count _this)>3) then {_this select 3;} else {"COMBAT"};


_group setCombatMode "RED";
_group setBehaviour _behavior;


if (_difficulty == "random") then
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
	_npos = [_pos,_radius,_i] call DMS_fnc_SelectOffsetPos;
	_wp = _group addWaypoint [_npos,5];
	_wp setWaypointType "MOVE";
};

_wp = _group addWaypoint [[_pos,_radius,0] call DMS_fnc_SelectOffsetPos,0];
_wp setWaypointType "CYCLE";



true