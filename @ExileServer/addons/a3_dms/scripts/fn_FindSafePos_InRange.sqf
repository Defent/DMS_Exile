/*
    DMS_fnc_FindSafePos_InRange
    Created by eraser1

    Exactly the same as DMS_fnc_FindSafePos except it only searches in a specific area as opposed to the whole map (minus the constraints of minimum distance from borders).

    Usage:
    [
        _centerPos,                // ARRAY (position): 2D or 3D center position to search around.
        _distanceMin,              // SCALAR (distance): Minimum distance from the center position to search around. See note below for actual calculation of distance.
        _distanceMax,              // SCALAR (distance): Maximum distance from the center position to search around. NOTE: Due to the way this function works (because of efficiency) the practical maximum distance is actually distance*sqrt(2). Therefore, the distance parameter is not wholly accurate.
        _posParameters             // ARRAY: The parameters to determine the position you want. More detail below.
    ] call DMS_fnc_FindSafePos_InRange;

    NOTE: I don't check to make sure "_distanceMax" is greater than "_distanceMin", so if you goof up, it's not on me. Also, if you set the values too close to each other, there's a good chance it's gonna result in performance issues and quite possibly no resulting position.

    "_posParameters" is simply passed to "DMS_fnc_FindSafePos". See the usage of that function for more detail: https://github.com/Defent/DMS_Exile/blob/master/%40ExileServer/addons/a3_dms/scripts/fn_FindSafePos.sqf

    Returns a position.
*/

if !(params
[
    "_centerPos",
    "_distanceMin",
    "_distanceMax",
    "_posParameters"
])
exitWith
{
    diag_log format["DMS ERROR :: Calling DMS_fnc_FindSafePos_InRange with invalid parameters: %1",_this];
    []
};

// Save the original values
private _original_x = DMS_MinMax_X_Coords;
private _original_y = DMS_MinMax_Y_Coords;
private _original_Blacklist = DMS_findSafePosBlacklist;

// Get the center values
private _center_x = _centerPos select 0;
private _center_y = _centerPos select 1;

// Set the restrictions
DMS_MinMax_X_Coords = [_center_x - _distanceMax, _center_x + _distanceMax];
DMS_MinMax_Y_Coords = [_center_y - _distanceMax, _center_y + _distanceMax];

DMS_findSafePosBlacklist =
    if (_distanceMin>0) then
    {
        [
            [
                [_center_x - _distanceMin, _center_y - _distanceMin],
                [_center_x + _distanceMin, _center_y + _distanceMin]
            ]
        ]
    }
    else
    {
        []
    };

private _usePresetOriginal = DMS_UsePredefinedMissionLocations;
DMS_UsePredefinedMissionLocations = false;

// NOW we get the position (hopefully)
private _pos = _posParameters call DMS_fnc_findSafePos;

// Reset the original values
DMS_MinMax_X_Coords = _original_x;
DMS_MinMax_Y_Coords = _original_y;
DMS_findSafePosBlacklist = _original_Blacklist;
DMS_UsePredefinedMissionLocations = _usePresetOriginal;

_pos
