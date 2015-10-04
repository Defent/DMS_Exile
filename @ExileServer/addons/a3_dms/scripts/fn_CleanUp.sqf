/*
    DMS_fnc_CleanUp
    Created by eraser1

    Usage:
    [
        _objectOrGroup1,
        _objectOrGroup2,
        ...
        _objectOrGroupN
    ] call DMS_fnc_CleanUp;

    Alternative Usage:
    _objectOrGroup call DMS_fnc_CleanUp;
*/


if (DMS_DEBUG) then
{
    diag_log ("DMS_DEBUG CleanUp :: CLEANING UP: "+str _this);
};

if !((typeName _this) == "ARRAY") then
{
    _this = [_this];
};

private ["_skippedObjects","_clean"];

_skippedObjects = [];

_clean =
{   
    {
        detach _x;
        _x call _clean;
    } forEach (attachedObjects _x);
    _this enableSimulationGlobal false;
    _this removeAllMPEventHandlers "mpkilled";
    _this removeAllMPEventHandlers "mphit";
    _this removeAllMPEventHandlers "mprespawn";
    _this removeAllEventHandlers "FiredNear";
    _this removeAllEventHandlers "HandleDamage";
    _this removeAllEventHandlers "Killed";
    _this removeAllEventHandlers "Fired";
    _this removeAllEventHandlers "GetOut";
    _this removeAllEventHandlers "GetIn";
    _this removeAllEventHandlers "Local";
    deleteVehicle _this;
};


{
    if ((typeName _x) == "OBJECT") then
    {
        if (isNull _x) exitWith {};

        if !([_x,DMS_CleanUp_PlayerNearLimit] call DMS_fnc_IsPlayerNearby) then
        {
            _x call _clean;
        }
        else
        {
            _skippedObjects pushBack _x;
            if (DMS_DEBUG) then
            {
                diag_log format ["DMS_DEBUG CleanUp :: Skipping cleanup for |%1|, player within %2 meters!",_x,DMS_CleanUp_PlayerNearLimit];
            };
        };
    }
    else
    {
        if ((typeName _x) == "GROUP") exitWith
        {
            if (!isNull _x) then
            {
                // Group cleanup should only be called when it has to be deleted regardless, so no need to check for nearby players
                {
                    _x call _clean;
                } forEach (units _x);

                if(local _x)then
                {
                    deleteGroup _x;
                }
                else
                {
                    [groupOwner _x,"DeleteGroupPlz",[_x]] call ExileServer_system_network_send_to;
                };
            };
        };
        if ((typeName _x) == "ARRAY") exitWith
        {
            if (DMS_DEBUG) then
            {
                diag_log format ["DMS_DEBUG CleanUp :: Doing recursive call for ARRAY: %1",_x];
            };
            _x call DMS_fnc_CleanUp;
        };
        diag_log format ["DMS ERROR :: Attempted to call DMS_fnc_CleanUp on non- group or object %1 from array %2",_x,_this];
    };
} forEach _this;


if !(_skippedObjects isEqualTo []) then
{
    DMS_CleanUpList pushBack [_skippedObjects,diag_tickTime,30];
};