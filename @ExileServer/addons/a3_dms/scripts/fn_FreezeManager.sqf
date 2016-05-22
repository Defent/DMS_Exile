/*
    DMS_fnc_FreezeManager
    Created by eraser1

    Determines which AI groups (if any) to "freeze" in order to improve server performance, and will "un-freeze" frozen AI when a player is nearby.
    This function will also offload AI after "un-freezing" if configured to do so.

    NOTE: If you want this function to ignore a specific group, then you can set the variable "DMS_AllowFreezing" on the group to false.
    eg: _group setVariable ["DMS_AllowFreezing",false]
*/

if !(DMS_ai_allowFreezing) exitWith {};

private _recentlyUnfrozen = [];

{
    if (isNull _x) then
    {
        diag_log format["DMS ERROR :: Null Group found in DMS_FrozenAIGroups! Index: %1",_forEachIndex];
        DMS_FrozenAIGroups deleteAt _forEachIndex;
    }
    else
    {
        private _leader = leader _x;
        if ([_leader,DMS_ai_unfreezingDistance] call DMS_fnc_IsPlayerNearby) then
        {
            [_x,false] call DMS_fnc_FreezeToggle;
            _recentlyUnfrozen pushBack _x;

            if (DMS_ai_offloadOnUnfreeze) then
            {
                [_x, _leader] call DMS_fnc_SetAILocality;
            };

            if (DMS_DEBUG) then
            {
                format["FreezeManager :: Un-froze AI Group: %1",_x] call DMS_fnc_DebugLog;
            };

            DMS_FrozenAIGroups deleteAt _forEachIndex;
        };
    };
} forEach DMS_FrozenAIGroups;


{
	if (((count (units _x))>1) && {_x getVariable ["DMS_AllowFreezing",true]} && {!(DMS_ai_freeze_Only_DMS_AI && {!(_x getVariable ["DMS_SpawnedGroup",false])})}) then
	{
		private _leader = leader _x;
		private _group = _x;

		if ((!isNull _leader) && {alive _leader} && {!(isPlayer _leader)} && {!([_leader,DMS_ai_freezingDistance] call DMS_fnc_IsPlayerNearby)}) then
		{
            [_group,true] call DMS_fnc_FreezeToggle;

            if (DMS_DEBUG) then
            {
                format["FreezeManager :: Froze AI Group: %1",_group] call DMS_fnc_DebugLog;
            };

            // So that we don't check this group for freezing later on.
            _group setVariable ["DMS_AllowFreezing",false];
		};
	};
} forEach allGroups;


// NOW we allow them to be frozen again, so we avoid checking for nearby players TWICE on a group(s) that has just been un-frozen.
{
    _x setVariable ["DMS_AllowFreezing", true];
} forEach _recentlyUnfrozen;
