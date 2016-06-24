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
    (format ["CleanUp :: CLEANING UP: %1",_this]) call DMS_fnc_DebugLog;
};

if !(_this isEqualType []) then
{
    _this = [_this];
};


private _skippedObjects = [];
{
    private _parameter = _x;

    switch (typeName _parameter) do
    {
        case "ARRAY":
        {
            if (DMS_DEBUG) then
            {
                (format ["CleanUp :: Doing recursive call for ARRAY: %1",_parameter]) call DMS_fnc_DebugLog;
            };
            _parameter call DMS_fnc_CleanUp;
        };

        case "OBJECT":
        {
            if (isNull _parameter) exitWith {};

            if !([_parameter,DMS_CleanUp_PlayerNearLimit] call DMS_fnc_IsPlayerNearby) then
            {
                _parameter call ExileServer_system_garbageCollector_deleteObject;
            }
            else
            {
                _skippedObjects pushBack _parameter;
                if (DMS_DEBUG) then
                {
                    (format ["CleanUp :: Skipping cleanup for |%1|, player within %2 meters!",_parameter,DMS_CleanUp_PlayerNearLimit]) call DMS_fnc_DebugLog;
                };
            };
        };

        case "GROUP":
        {
            if (isNull _parameter) exitWith {};

            // Group cleanup should only be called when it has to be deleted regardless of player presence, so no need to check for nearby players
            // If you want to check player presence before deleting a group, then do {(units _group) call DMS_fnc_CleanUp} instead of {_group call DMS_fnc_CleanUp}
            {
                _x call ExileServer_system_garbageCollector_deleteObject;
            } forEach (units _parameter);

            if (local _parameter) then
            {
                deleteGroup _parameter;
            }
            else
            {
                [groupOwner _parameter, "DeleteGroupPlz", [_parameter]] call ExileServer_system_network_send_to;
            };
        };

        default
        {
            diag_log format ["DMS ERROR :: Calling DMS_fnc_CleanUp with an invalid parameter: %1 | Type: %2", _parameter, typeName _parameter];
            []
        };
    };
} forEach _this;


if !(_skippedObjects isEqualTo []) then
{
    DMS_CleanUpList pushBack [_skippedObjects,diag_tickTime,30];
};
