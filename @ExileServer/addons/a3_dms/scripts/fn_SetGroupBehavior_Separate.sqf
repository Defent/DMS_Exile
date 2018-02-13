/*
    DMS_fnc_SetGroupBehavior_Separate
    created by eraser1

    Takes in an array of unit(s), moves them to a temporary group, sets their behavior, then moves them back to the original group.
    Use this function if you want to change the behavior of certain units in a group without adjusting the behavior of the whole group.

    Usage:
    [
        [   							// ARRAY of OBJECTs: Units whose behavior will be changed
            _unit1,
            _unit2,
            ...
            _unitN
        ],
        _finalGroup,                    // GROUP: The final group that the units will be moved to.
        _pos,							// ARRAY (positionATL): Location for the AI to guard
        _difficulty,					// STRING: Difficulty of the AI
        _behavior						// (OPTIONAL) STRING: AI Behavior. Refer to: https://community.bistudio.com/wiki/setBehaviour
    ] call DMS_fnc_SetGroupBehavior_Separate;

    Returns true if behavior was successfully changed, false otherwise.
*/

if !(params
[
  "_units",
  "_finalGroup",
  "_pos",
  "_difficulty"
])
then
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SetGroupBehavior_Separate with invalid params: %1",_this];
};

private _behavior = param [3, "COMBAT", [""]];

private _tmpGroup = createGroup (side _finalGroup);

_units joinSilent _tmpGroup;

private _return =
[
    _tmpGroup,
    _pos,
    _difficulty,
    _behavior
] call DMS_fnc_SetGroupBehavior;

_units joinSilent _finalGroup;
deleteGroup _tmpGroup;


_return
