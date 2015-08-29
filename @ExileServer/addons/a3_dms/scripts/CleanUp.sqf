/*
    DMS_CleanUp
    Created by eraser1

    Usage:
    [
        _object1,
        _object2,
        ...
        _objectN
    ] call DMS_CleanUp;

    Alternative Usage:
    _object call DMS_CleanUp;
*/


if (DMS_DEBUG) then
{
    diag_log ("DMS_DEBUG CleanUp :: CLEANING UP: "+str _this);
};

if !((typeName _this) isEqualTo "ARRAY") then
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

private "_skippedObjects";

_skippedObjects = [];

{
    if ((typeName _x) isEqualTo "OBJECT") then {
        if !([_x,DMS_CleanUp_PlayerNearLimit] call ExileServer_util_position_isPlayerNearby) then {
            _x enableSimulationGlobal false;
            _x removeAllMPEventHandlers "mpkilled";
            _x removeAllMPEventHandlers "mphit";
            _x removeAllMPEventHandlers "mprespawn";
            _x removeAllEventHandlers "FiredNear";
            _x removeAllEventHandlers "HandleDamage";
            _x removeAllEventHandlers "Killed";
            _x removeAllEventHandlers "Fired";
            _x removeAllEventHandlers "GetOut";
            _x removeAllEventHandlers "GetIn";
            _x removeAllEventHandlers "Local";
            deleteVehicle _x;
        } else {
            _skippedObjects pushBack _x;
            if (DMS_DEBUG) then
            {
                diag_log format ["DMS_DEBUG CleanUp :: Skipping cleanup for |%1|, player within %2 meters!",_this,DMS_CleanUp_PlayerNearLimit];
            };
        };
    }
    else
    {
        diag_log format ["DMS ERROR :: Attempted to call DMS_CleanUp on non-object %1 from array %2",_x,_this];
    };

    false;
} count _this;

if !(_skippedObjects isEqualTo []) then {
    DMS_CleanUpList pushBack [_skippedObjects,diag_tickTime,30];
};