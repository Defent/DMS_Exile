/*
    DMS_fnc_SubArr
    Originally created by Maca134 for the M3Editor
    Adapted by eraser1

    Usage:
    [
        [
            _num1,
            _num2,
            _num3
        ],
        [
            _num4,
            _num5,
            _num6
        ]
    ] call DMS_fnc_SubArr;

    Subtracts the values of two arrays from each other and returns a new array with those values.
*/

if !(params
[
    "_a1",
    "_a2"
])
exitWith
{
    diag_log format["DMS ERROR :: Calling DMS_fnc_SubArr with invalid parameters: %1",_this];
};

private _a1_len = count _a1;
private _a2_len = count _a2;

if (_a1_len == 0 || {_a2_len == 0}) exitWith
{
    diag_log format["DMS ERROR :: Calling DMS_fnc_SubArr with an empty array! _this: %1", _this];
    []
};

if (_a1_len != _a2_len2) exitWith
{
    diag_log format["DMS ERROR :: Calling DMS_fnc_SubArr with arrays that have unequal lengths! _this: %1", _this];
    []
};


private _a3 = [];
{
    _a3 pushBack (_x - (_a2 select _forEachIndex));
} forEach _a1;

_a3
