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
            if
            (
                ((_pos select 0) >= (_blacklist_pos select 0)) &&               // if x is greater than x1 and
                {(_pos select 0) <= (_blacklist_parameter select 0)} &&         // if x is less than x2 and
                {(_pos select 1) >= (_blacklist_pos select 1)} &&               // if y is greater than y1 and
                {(_pos select 1) <= (_blacklist_parameter select 1)}            // if y is less than y2
            ) throw _x;                                                         // blacklisted
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
