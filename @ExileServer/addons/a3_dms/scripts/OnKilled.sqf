/*
	DMS_OnKilled
	Created by eraser1 and Defent
	Influenced by WAI

	Usage:
	[
		[
			_killedUnit,
			_killer
		],
		_side,				// "bandit" only for now
		_type				// not currently used
	] call DMS_OnKilled;
*/


private ["_unit", "_player", "_playerObj", "_side", "_type", "_launcher", "_rockets", "_money", "_respect", "_moneyGain", "_repGain"];


if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG OnKilled :: Logging AI death with parameters: %1",_this];
};
	
_unit 		= _this select 0 select 0;
_player 	= _this select 0 select 1;
_side 		= _this select 1;
_type 		= _this select 2;
_launcher 	= secondaryWeapon _unit;

if (isPlayer _player) then
{
	_playerObj = _player;

	if (DMS_ai_share_info) then
	{
		{
			if (((position _x) distance (position _unit)) <= DMS_ai_share_info_distance ) then {
				_x reveal [_player, 4.0];
			};
		} count allUnits;
	};
}
else
{
	_playerObj = gunner _player;

	if (isNull _playerObj) then
	{
		_playerObj = driver _player;
	};

	if (DMS_clear_AI_body || {DMS_remove_roadkill && {(random 100) <= DMS_remove_roadkill_chance}}) then
	{
		removeAllWeapons 				_unit;
		removeAllAssignedItems 			_unit;
		removeAllItemsWithMagazines 	_unit;
		removeUniform 					_unit;
		removeVest 						_unit;
		removeBackpack 					_unit;
	};
};

if(DMS_ai_remove_launchers && {_launcher != ""}) then
{
	_rockets = _launcher call DMS_selectMagazine;
	_unit removeWeapon _launcher;
	
	{
		if(_x == _rockets) then {
			_unit removeMagazine _x;
		};
		false;
	} count magazines _unit;
};

if(DMS_RemoveNVG) then
{
	_unit unlinkItem "NVGoggles";
};



if ((!isNull _playerObj) && {(getPlayerUID _playerObj) != ""}) then
{
	_moneyGain = missionNamespace getVariable [format ["DMS_%1MoneyGainOnKill",_side],0];
	_repGain = missionNamespace getVariable [format ["DMS_%1RepGainOnKill",_side],0];

	if ((_moneyGain>0) || (_repGain>0)) then
	{
		_money = _playerObj getVariable ["ExileMoney", 0];
		_respect = _playerObj getVariable ["ExileScore", 0];
		
		if (_moneyGain>0) then
		{
			// Set client's money
			_money = _money + _moneyGain;
			_playerObj setVariable ["ExileMoney",_money];

			// Send notification and update client's money stats
			// Somebody done fucked up so you don't see the sender for the money sending ;)
			[_playerObj, "moneyReceivedRequest", [str _money, "AI KILL"]] call ExileServer_system_network_send_to;
		};

		if (_repGain>0) then
		{
			// Set client's respect
			_respect = _respect + _repGain;
			_playerObj setVariable ["ExileScore",_respect];

			// Send frag message
			[_playerObj, "showFragRequest", [ [["AI KILL",_repGain]] ] ] call ExileServer_system_network_send_to;

			// Send updated respect value to client
			ExileClientPlayerScore = _respect;
			(owner _playerObj) publicVariableClient "ExileClientPlayerScore";
			ExileClientPlayerScore = nil;
		};

		// Update client database entry
		format["setAccountMoneyAndRespect:%1:%2:%3", _money, _respect, (getPlayerUID _playerObj)] call ExileServer_system_database_query_fireAndForget;
	};
};


DMS_CleanUpList pushBack [_unit,diag_tickTime,DMS_CompletedMissionCleanupTime];