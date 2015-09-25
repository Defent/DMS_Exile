/*
	DMS_fnc_SpawnMinefield
	Created by eraser1
	
	Usage:
	[
		_centerPos,
		_difficulty,
		_side
	] call DMS_fnc_SpawnMinefield;
*/

private ["_centerPos", "_difficulty", "_side", "_mines", "_minesInfo", "_AISide", "_mineCount", "_radius"];


_mines = [];

if (DMS_SpawnMinesAroundMissions) then
{

	_OK = params
	[
		["_centerPos","",[[]],[2,3]],
		["_difficulty","",[""]],
		["_side","",[""]]
	];

	if (!_OK) exitWith
	{
		diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnMinefield with invalid parameters: %1",_this];
	};


	_minesInfo	= missionNamespace getVariable [format ["DMS_MineInfo_%1", _difficulty], [10,50]];
	_AISide		= missionNamespace getVariable [format ["DMS_%1Side", _side], EAST];


	_mineCount	= _minesInfo select 0;
	_radius		= _minesInfo select 1;


	for "_i" from 1 to _mineCount do
	{
		private ["_minePos", "_mine"];

		_minePos = [_centerPos,random _radius,random 360] call DMS_fnc_SelectOffsetPos;
		_mine = createMine ["ATMine", _minePos, [], 0];
		_AISide revealMine _mine;


		_mines pushBack _mine;
	};

	if (DMS_DEBUG) then
	{
		diag_log format ["DMS_DEBUG SpawnMinefield :: Spawned %1 mines around %2 with _minesInfo: %3 | _mines: %4",count _mines,_centerPos,_minesInfo,_mines];
	};
};



_mines