/*
	DMS_fnc_SetAILocality
	Created by Defent and eraser1

	Usage:
	[
		_groupOrUnit,
		_posOrObject 		// Does not have to be defined if element 1 is a unit
	] call DMS_fnc_SetAILocality;

	Makes a random player within 3 KM of the AI unit or group the owner.
	Offloading AI can increase server performance.
	Could however have negative effects if target player has a potato PC.

*/
private ["_AI", "_pos", "_exit", "_client"];

_AI = param [0,objNull,[objNull,grpNull]];

if (isNull _AI) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_SetAILocality with null parameter; _this: %1",_this];
};

if ((typeName _AI)=="OBJECT") then
{
	_pos = _AI;
}
else
{
	_pos = param [1,"",[objNull,[]],[2,3]];
};

if (_pos isEqualTo "") exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_SetAILocality with invalid position; this: %1",_this];
};

_client = objNull;

{
	if ((alive _x) && {(_x distance2D _pos)<=3000}) exitWith
	{
		_client = _x;
	};
} forEach allPlayers;

if (!isNull _client) then
{
	ExileServerOwnershipSwapQueue pushBack [_AI,_client];
	if (DMS_DEBUG) then
	{
		diag_log format ["DMS_DEBUG SetAILocality :: Ownership swap of %1 (%4) to %2 (%3) is added to ExileServerOwnershipSwapQueue.",_AI,name _client,getPlayerUID _client,typeName _AI];
	};
}
else
{
	if (DMS_DEBUG) then
	{
		diag_log format ["DMS_DEBUG SetAILocality :: No viable client found for the ownership of %1!",_AI];
	};
};