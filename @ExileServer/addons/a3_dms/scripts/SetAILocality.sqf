/*
	Makes a random player within 3 KM of the AI the owner.
	Offloading AI can increase server performance.
	Could however have negative effects if target player has a potato PC.

	How To Use:
	[_pos, _group] call DMS_SetAILocality;
	Posistion of the player and the group that the AIs are in.

*/
private ["_group","_position","_exit","_randomPlayer"];

_group = _this select 0;
_position = _this select 1;
_exit = false;

while {!_exit} do 
{
	_randomPlayer = call ExileServer_system_session_getRandomPlayer;
	if((_randomPlayer distance2D _position) < 3000)then
	{
		_exit = true;
	};
};

ExileServerOwnershipSwapQueue pushBack [_group,_randomPlayer];

true