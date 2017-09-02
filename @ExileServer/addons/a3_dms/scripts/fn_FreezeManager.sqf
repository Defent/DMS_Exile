/*
    DMS_fnc_FreezeManager
    Created by eraser1

    Determines which AI groups (if any) to "freeze" in order to improve server performance, and will "un-freeze" frozen AI when a player is nearby.
    This function will also offload AI after "un-freezing" if configured to do so.

    NOTE: If you want this function to ignore a specific group, then you can set the variable "DMS_AllowFreezing" on the group to false.
    eg: _group setVariable ["DMS_AllowFreezing",false]
*/

{
    private _leader = leader _x;
    private _units = units _x;


    if (_x getVariable ["DMS_isGroupFrozen",false]) then
    {
        if ([_leader,DMS_ai_unfreezingDistance] call DMS_fnc_IsPlayerNearby) then
        {
            {
                _x enableSimulationGlobal true;
                (vehicle _x) enableSimulationGlobal true;
            } forEach _units;

            _x setVariable ["DMS_isGroupFrozen",false];


            if (DMS_ai_offloadOnUnfreeze) then
            {
                [_x, _leader] call DMS_fnc_SetAILocality;
            };


            if (DMS_DEBUG) then
            {
                format["FreezeManager :: Un-froze AI Group: %1",_x] call DMS_fnc_DebugLog;
            };
        };
    }
    else
    {
        if (DMS_ai_allowFreezing) then
        {
            private _canFreeze = false;

            try
            {
                if !(_x getVariable ["DMS_AllowFreezing",true]) throw "not allowed to be frozen";

                if ((side _x) isEqualTo independent) then
                {
                    {
                        if (isPlayer _x) throw "player group";
                    } forEach _units;


                    if ((count _units) isEqualTo 1) throw "Exile flyover (probably)";
                };

                if (DMS_ai_freeze_Only_DMS_AI && {!(_x getVariable ["DMS_SpawnedGroup",false])}) throw "not a DMS-spawned group";

                _canFreeze = true;
            }
            catch
            {
                // Mark the group to speed up future checks
                _x setVariable ["DMS_AllowFreezing",false];

                if (DMS_DEBUG) then
                {
                    format["FreezeManager :: Cannot freeze group ""%1"": %2", _x, _exception] call DMS_fnc_DebugLog;
                };
            };



            if (_canFreeze) then
            {
                if !([_leader,DMS_ai_freezingDistance] call DMS_fnc_IsPlayerNearby) then
                {
                    {
                        _x enableSimulationGlobal false;
                        (vehicle _x) enableSimulationGlobal false;
                    } forEach _units;

                    _x setVariable ["DMS_isGroupFrozen",true];


                    if (DMS_DEBUG) then
                    {
                        format["FreezeManager :: Froze AI Group: %1",_x] call DMS_fnc_DebugLog;
                    };
                };
            };
        };
    };
} forEach allGroups;
