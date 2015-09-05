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

private ["_OK", "_group", "_pos", "_difficulty", "_radius", "_npos", "_i", "_wp"];

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

_group setCombatMode "RED";
_group setBehaviour "COMBAT";


if(_difficulty == "random") then
{
	_difficulty = DMS_ai_skill_random call BIS_fnc_selectRandom;
};

_radius = missionNamespace getVariable [format["DMS_AI_WP_Radius_%1"],40];

for "_i" from 0 to 359 step 45 do {
	_npos = [(_pos select 0) + (sin(_i)*_radius), (_pos select 1) + (cos(_i)*_radius)];
	_wp = _group addWaypoint [_npos,(_radius/5)];
	_wp setWaypointType "MOVE";
};

_wp = _group addWaypoint [_pos,_radius];
_wp setWaypointType "CYCLE";