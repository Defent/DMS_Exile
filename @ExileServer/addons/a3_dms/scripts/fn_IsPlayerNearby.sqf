/*
	DMS_fnc_IsPlayerNearby
	Created by eraser1

	Usage:
	[
		_positionOrObject,
		_distance
	] call DMS_fnc_IsPlayerNearby;

	Returns whether or not a player is within "_distance" meters of "_positionOrObject".
*/
 
private ["_pos", "_dis", "_isNear"];

_OK = params
[
	["_pos", "", [objNull,[]], [2,3]],
	["_dis", 0, [0]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_IsPlayerNearby with invalid parameters: %1",_this];
};

_isNear = false;

try
{
	{
		{
			if (isPlayer _x) then
			{
				throw _x;
			};
		} forEach (crew _x);
	} forEach (_pos nearEntities [["Exile_Unit_Player","LandVehicle", "Air", "Ship"], _dis]);
	
	if (DMS_DEBUG) then
	{
		(format ["IsPlayerNearby :: No players within %1 meters of %2!",_dis,_pos]) call DMS_fnc_DebugLog;
	};
}
catch
{
	_isNear = true;
	if (DMS_DEBUG) then
	{
		(format ["IsPlayerNearby :: %1 is within %2 meters of %3!",_exception,_dis,_pos]) call DMS_fnc_DebugLog;
	};
};


_isNear;