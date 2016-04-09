/*
    DMS_fnc_GetEmptySeats
    Created by eraser1

    Usage:
    _vehicle call DMS_fnc_GetEmptySeats;
    or
    [_vehicle] call DMS_fnc_GetEmptySeats;

    Returns a list of empty cargo seats in the form of [[<Object>unit,<String>role,<Number>cargoIndex,<Array>turretPath,<Boolean>personTurret], ...].
    "unit" will always be objNull.

    See https://community.bistudio.com/wiki/fullCrew and https://community.bistudio.com/wiki/moveInCargo for more info.
*/

if !(params
[
    ["_vehicle",objNull,[objNull]]
])
exitWith
{
    diag_log format ["DMS ERROR :: Calling DMS_fnc_GetEmptySeats with invalid parameter(s): %1",_this];
};

(fullCrew [_vehicle, "", true]) select
{
    _x params
    [
        "_unit",
        "_role",
        "_cargoIndex"
    ];

    isNull _unit
};
