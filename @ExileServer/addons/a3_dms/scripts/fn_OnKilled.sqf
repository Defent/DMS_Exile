/*
	DMS_fnc_OnKilled
	Created by eraser1 and Defent
	Influenced by WAI

	Usage:
	[
		[
			_killedUnit,
			_killer
		],
		_side,				// "bandit" only for now
		_type				// Type of AI: "soldier","static","vehicle","heli", etc.
	] call DMS_fnc_OnKilled;
*/


private ["_unit", "_player", "_side", "_type", "_launcher", "_playerObj", "_rockets", "_grpUnits", "_veh", "_moneyGain", "_repGain", "_money", "_respect"];


if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG OnKilled :: Logging AI death with parameters: %1",_this];
};
	
_unit 		= _this select 0 select 0;
_player 	= _this select 0 select 1;
_side 		= _this select 1;
_type 		= _this select 2;
_launcher 	= secondaryWeapon _unit;
_playerObj	= objNull;

// Remove gear according to configs
if (DMS_clear_AI_body && {(random 100) <= DMS_clear_AI_body_chance}) then
{
	removeAllWeapons 				_unit;
	removeAllAssignedItems 			_unit;
	removeAllItemsWithMagazines 	_unit;
	removeHeadgear 					_unit;
	removeUniform 					_unit;
	removeVest 						_unit;
	removeBackpack 					_unit;
};

if(DMS_ai_remove_launchers && {_launcher != ""}) then
{
	_rockets = _launcher call DMS_fnc_selectMagazine;
	_unit removeWeaponGlobal _launcher;
	
	{
		if(_x == _rockets) then {
			_unit removeMagazine _x;
		};
	} forEach magazines _unit;
};

if(DMS_RemoveNVG) then
{
	_unit unlinkItem "NVGoggles";
};


// Give the AI a new leader if the killed unit was the leader
// credit: https://github.com/SMVampire/VEMF/
if (((count (units group _unit)) > 1) && {(leader group _unit) == _unit}) then
{
	_grpUnits = units group _unit;
	_grpUnits = _grpUnits - [_unit];
	(group _unit) selectLeader (_grpUnits call BIS_fnc_selectRandom);
};




if (isPlayer _player) then
{
	_veh = vehicle _player;

	_playerObj = _player;

	// Reveal the killer to the AI units
	if (DMS_ai_share_info) then
	{
		{
			if (((position _x) distance (position _unit)) <= DMS_ai_share_info_distance ) then
			{
				_x reveal [_player, 4.0];
			};
		} forEach allUnits;
	};

	// Fix for players killing AI from mounted vehicle guns
	if (!(_player isKindOf "Exile_Unit_Player") && {!isNull (gunner _player)}) then
	{
		_playerObj = gunner _player;
	};


	if (!(_veh isEqualTo _player) && {(driver _veh) isEqualTo _player}) then
	{
		_playerObj = driver _veh;


		// Don't reward players with poptabs/respect if configured to do so
		if !(DMS_credit_roadkill) then
		{
			_playerObj = objNull;
		};


		// Remove gear from roadkills if configured to do so
		if (DMS_remove_roadkill && {(random 100) <= DMS_remove_roadkill_chance}) then
		{
			removeAllWeapons 				_unit;
			removeAllAssignedItems 			_unit;
			removeAllItemsWithMagazines 	_unit;
			removeHeadgear 					_unit;
			removeUniform 					_unit;
			removeVest 						_unit;
			removeBackpack 					_unit;
		};
	};};


if ((!isNull _playerObj) && {((getPlayerUID _playerObj) != "")}) then
{
	_moneyGain = missionNamespace getVariable [format ["DMS_%1_%2_MoneyGain",_side,_type],0];
	_repGain = missionNamespace getVariable [format ["DMS_%1_%2_RepGain",_side,_type],0];

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
			[_playerObj, "moneyReceivedRequest", [str _money, "killing AI"]] call ExileServer_system_network_send_to;
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