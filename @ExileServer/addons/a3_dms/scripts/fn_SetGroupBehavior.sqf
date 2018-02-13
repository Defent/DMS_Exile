/*
	DMS_fnc_SetGroupBehavior
	Created by eraser1

	Usage:
	[
		_group,							// GROUP or OBJECT: Group or unit whose behavior is to be changed.
		_pos,							// ARRAY (positionATL): Location for the AI to guard
		_difficulty,					// STRING: Difficulty of the AI
		_behavior						// (OPTIONAL) STRING: AI Behavior. Refer to: https://community.bistudio.com/wiki/setBehaviour
	] call DMS_fnc_SetGroupBehavior;

	Returns true if the call was completed
*/

if !(params
[
	"_group",
	"_pos",
	"_difficulty"
])
then
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SetGroupBehavior with invalid params: %1",_this];
};

private _exit = false;

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


private _behavior = param [3, "COMBAT", [""]];


_group setCombatMode "RED";
_group setBehaviour _behavior;


_difficulty =
	switch (toLower _difficulty) do
	{
		case "random":
		{
			selectRandom DMS_ai_skill_random;
		};

		case "randomdifficult":
		{
			selectRandom DMS_ai_skill_randomDifficult;
		};

		case "randomeasy":
		{
			selectRandom DMS_ai_skill_randomEasy;
		};

		case "randomintermediate":
		{
			selectRandom DMS_ai_skill_randomIntermediate;
		};

		default
		{
		    _difficulty;
		};
	};

private _radius = missionNamespace getVariable [format["DMS_AI_WP_Radius_%1",_difficulty],40];


// Remove all previous waypoints
for "_i" from count (waypoints _group) to 1 step -1 do
{
	deleteWaypoint ((waypoints _group) select _i);
};

// Add waypoints around the center position.
for "_i" from 0 to 359 step 45 do
{
	private _npos = _pos getPos [_radius,_i];
	private _wp = _group addWaypoint [_npos,5];
	_wp setWaypointType "MOVE";
};

_wp = _group addWaypoint [_pos,0];
_wp setWaypointType "CYCLE";


true
