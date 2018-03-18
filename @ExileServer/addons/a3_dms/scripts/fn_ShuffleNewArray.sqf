/*
    DMS_fnc_ShuffleNewArray
    created by eraser1

    Usage:
    _array call DMS_fnc_ShuffleNewArray

    Shuffles an array without modifying the original (input) array.
*/

_this = + _this;

_shuffled = [];

for "_i" from (count _this) to 1 step -1 do
{
    _shuffled pushBack (_this deleteAt floor(random _i));
};

_shuffled;
