/*
    DMS_fnc_FreezeToggle
    created by eraser1

    Usage:
    [
        _group,                     // GROUP: The AI Group to be frozen
        _freeze                     // BOOL: "true" if you want to freeze, false if you want to un-freeze
    ] call DMS_fnc_FreezeToggle;

    Freezes/un-freezes a specified group.
*/

if !(params
[
    "_group",
    "_freeze"
]) exitWith
{
    diag_log format["DMS ERROR :: Calling DMS_fnc_FreezeToggle with invalid parameters: %1",_this];
};

if (_freeze) then
{
    {
        _x enableSimulationGlobal false;
        (vehicle _x) enableSimulationGlobal false;
    } forEach (units _group);

    _group setVariable ["DMS_isGroupFrozen",true];
}
else
{
    {
        _x enableSimulationGlobal true;
        (vehicle _x) enableSimulationGlobal true;
    } forEach (units _group);

    _group setVariable ["DMS_isGroupFrozen",false];
};
