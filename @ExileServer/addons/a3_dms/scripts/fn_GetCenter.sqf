/*
    DMS_fnc_GetCenter
    Originally created by Maca134 for the M3Editor
    Adapted by eraser1

    Usage:
    [
        [
            _object1,
            _object2,
            ...
            _objectN
        ]
    ] call DMS_fnc_GetCenter;

    Calculates and returns the approximate center co-ordinates (in PositionATL) for a list of objects.
*/

private _objects = _this param [0, [], [[]]];
private _ax = [];
private _ay = [];
private _az = [];

{
    private _position = getPosASL _x;
    _ax pushBack (_position select 0);
    _ay pushBack (_position select 1);
    _az pushBack (_position select 2);
} foreach _objects;

private _xs = 0;
private _xc = {_xs = _xs + _x; true} count _ax;
private _xz = _xs / _xc;

private _ys = 0;
private _yc = {_ys = _ys + _x; true} count _ay;
private _yz = _ys / _yc;

private _zs = 0;
private _zc = {_zs = _zs + _x; true} count _az;
private _zz = _zs / _zc;

ASLToATL [_xz, _yz, _zz]
