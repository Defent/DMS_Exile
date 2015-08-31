/*
    DMS_CleanUp
    Created by eraser1

    Usage:
    [
        _objectOrGroup1,
        _objectOrGroup2,
        ...
        _objectOrGroupN
    ] call DMS_CleanUp;

    Alternative Usage:
    _objectOrGroup call DMS_CleanUp;
*/


if (DMS_DEBUG) then
{
    diag_log ("DMS_DEBUG CleanUp :: CLEANING UP: "+str _this);
};

if !((typeName _this) == "ARRAY") then
{
    if (DMS_DEBUG) then
    {
        diag_log ("DMS_DEBUG CleanUp :: Converting single object into array: "+str _this);
    };
    _this = [_this];
};


/*
if ([_this,20] call DMS_isPlayerNearbyARRAY) exitWith //<-----Not sure if it's more/less efficient
{
    [30, DMS_CleanUp, _this, false] call ExileServer_system_thread_addTask;
};
*/

private ["_skippedObjects","_clean"];

_skippedObjects = [];

_clean =
{   
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

        if !([_x,DMS_CleanUp_PlayerNearLimit] call ExileServer_util_position_isPlayerNearby) then
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
                    false;
                } count (units _x);

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
            _x call DMS_CleanUp;
        };
        diag_log format ["DMS ERROR :: Attempted to call DMS_CleanUp on non- group or object %1 from array %2",_x,_this];
    };

    false;
} count _this;


if !(_skippedObjects isEqualTo []) then
{
    DMS_CleanUpList pushBack [_skippedObjects,diag_tickTime,30];
};