/*
    DMS_fnc_IsPosBlacklisted
    Created by eraser1

    Usage:
    [
        _pos,
        [
            _blacklist1,
            _blacklist2,
            ...
            _blacklistN
        ]
    ] call DMS_fnc_IsPosBlacklisted;

    A blacklist can be in the form:
        [[x1,y1],[x2,y2]]
    where x1 is LESS than x2, and y1 is LESS than y2. This method is SLOWER.

    or,
        [[x,y],radius]
    where any position within "radius" meters of position "x,y" is blacklisted. This method is FASTER.

    Returns true if the given position is blacklisted.
*/


if !(params
[
    "_pos",
    "_blacklists"
]) exitWith
{
    diag_log format ["DMS ERROR :: Calling DMS_fnc_IsPosBlacklisted with invalid parameters: %1",_this];
};


try
{
    {
        _x params
        [
            "_blacklist_pos",
            "_blacklist_parameter"
        ];

        if (_blacklist_parameter isEqualType 0) then
        {
            if ((_pos distance2D _blacklist_pos) <= _blacklist_parameter) throw _x;
        }
        else
        {
            _pos params
            [
                "_pos_x",
                "_pos_y"
            ];

            _blacklist_pos params
            [
                "_minX",
                "_minY"
            ];

            _blacklist_parameter params
            [
                "_maxX",
                "_maxY"
            ];

            if ((_pos_x >= _minX) && {_pos_x <= _maxX} && {_pos_y >= _minY} && {_pos_y <= _maxY}) throw _x;
        };
    } forEach _blacklists;

    false
}
catch
{
    if (DMS_DEBUG) then
    {
        format["Position |%1| is blacklisted by blacklist parameter |%2|. All provided blacklists: %3",_pos,_exception,_blacklists] call DMS_fnc_DebugLog;
    };

    true
};
