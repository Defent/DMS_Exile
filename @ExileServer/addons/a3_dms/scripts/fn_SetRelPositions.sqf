/*
    DMS_fnc_SetRelPositions
    Created by eraser1

    Usage:
    [
        [
            _object1,
            _object2,
            ...
            _objectN
        ],
        _newCenterPos
    ] call DMS_fnc_SetRelPositions;

    This function will move a list of objects to a new location by calculating their center position, then their relative position from the center, and then place them in their corresponding relative positions in the new location.
*/

if !(params
[
    "_objects",
    "_newCPos"
])
exitWith
{
    diag_log format ["DMS ERROR :: Calling DMS_fnc_setRelPositions with invalid parameters: %1",_this];
};


private _center = [_objects] call DMS_fnc_GetCenter;

{
    private _relpos = (getPosATL _x) vectorDiff _center;
    private _objPos = [_newCPos,_relpos] call DMS_fnc_CalcPos;

    _x setPosATL _objPos;

    if (DMS_DEBUG) then
    {
        format ["Setting %1 at %2; %3 is the relpos from original center %4, reapplied to new center %5",typeOf _x,_objPos,_relpos,_center,_newCPos] call DMS_fnc_DebugLog;
    };
} foreach _objects;
