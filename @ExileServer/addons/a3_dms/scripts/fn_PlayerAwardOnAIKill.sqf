/*
	DMS_fnc_PlayerAwardOnAIKill
	Created by eraser1

	Gives (or removes) a player's respect/poptabs for killing an AI.

	Usage:
	[
		_playerObj,
		_unit,
		_AISide,
		_AIType,
		_roadKilled
	] call DMS_fnc_PlayerAwardOnAIKill;

	Returns nothing
*/

if !(params
[
	"_playerObj",
	"_unit",
	"_AISide",
	"_AIType",
	"_roadKilled"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_PlayerAwardOnAIKill with invalid parameters: %1",_this];
};


private _playerUID = getPlayerUID _playerObj;

if ((!isNull _playerObj) && {(_playerUID != "") && {_playerObj isKindOf "Exile_Unit_Player"}}) then
{
	// Check for individually defined AI money/respect/rank.
	private _moneyChange = _unit getVariable ["DMS_AI_Money",0];
	private _repChange = _unit getVariable ["DMS_AI_Respect",0];
	//private _unitRank = _unit getVariable ["DMS_AI_Rank",0];


	if (_roadKilled && {_unit getVariable ["DMS_Diff_RepOrTabs_on_roadkill",DMS_Diff_RepOrTabs_on_roadkill]}) then
	{
		_moneyChange = missionNamespace getVariable [format ["DMS_%1_%2_RoadkillMoney",_AISide,_AIType],0];
		_repChange = missionNamespace getVariable [format ["DMS_%1_%2_RoadkillRep",_AISide,_AIType],0];
		//_rankChange = missionNamespace getVariable [format ["DMS_%1_%2_RoadkillRank",_AISide,_AIType],0];
	};


	private _playerMoney = _playerObj getVariable ["ExileMoney", 0];
	private _playerRespect = _playerObj getVariable ["ExileScore", 0];
	//private _playerRank = _playerObj getVariable ["ExileHumanity", 0];
	private _unitName = name _unit;
	private _distance = [];

	/*
	if (DMS_DEBUG) then
	{
		format ["PlayerAwardOnAIKill :: Attempting to give %1 (%2) %3 poptabs and %4 respect and %5 rank. Player currently has %6 tabs and %7 respect and &8 rank.", name _playerObj, _playerUID, _moneyChange, _repChange, _rankChange,_playerMoney, _playerRespect,_playerRank] call DMS_fnc_DebugLog;
	};
	*/


	if (DMS_GiveMoneyToPlayer_OnAIKill && {_moneyChange!=0}) then
	{
		// Set client's money
		_playerMoney = (_playerMoney + _moneyChange) max 0;			//Also make sure that they don't get negative poptabs
		_playerObj setVariable ["ExileMoney",_playerMoney,true];

		if (DMS_Show_Kill_Poptabs_Notification) then
		{
			// Create and send message to player
			private _msgParams =
				if (_moneyChange > 0) then
				{
					["SuccessTitleOnly",[format ["Gained %1 poptabs for killing %2 AI!",abs _moneyChange,_AIType]]];
				}
				else
				{
					["ErrorTitleOnly",[format ["Lost %1 poptabs for killing %2 AI!",abs _moneyChange,_AIType]]];
				};

			// Send notification
			[_playerObj, "toastRequest", _msgParams] call ExileServer_system_network_send_to;

			// Update money in database
			format["setPlayerMoney:%1:%2", _playerMoney, _playerObj getVariable ["ExileDatabaseID", 0]] call ExileServer_system_database_query_fireAndForget;
		};
	};


	if (DMS_GiveRespectToPlayer_OnAIKill && {_repChange!=0}) then
	{
		private _attributes = [[format ["KILLED %1",toUpper(_unitName)],_repChange]];

		if (DMS_AIKill_DistanceBonusCoefficient>0) then
		{
			_distance = floor (_unit distance _playerObj);

			if (_distance>DMS_AIKill_DistanceBonusMinDistance) then
			{
				private _distanceBonus = floor (_distance * DMS_AIKill_DistanceBonusCoefficient);
				_attributes pushBack [format ["%1m RANGE BONUS",_distance], _distanceBonus];

				_repChange = _repChange + _distanceBonus;
			};
		};

		// Set client's respect
		_playerRespect = _playerRespect + _repChange;
		_playerObj setVariable ["ExileScore",_playerRespect];

		if (DMS_Show_Kill_Respect_Notification) then
		{
			// Send frag message
			[_playerObj, "showFragRequest", [_attributes]] call ExileServer_system_network_send_to;
		};

		// Update respect in database
		format["setAccountScore:%1:%2", _playerRespect, _playerUID] call ExileServer_system_database_query_fireAndForget;

		// Send updated respect value to client
		ExileClientPlayerScore = _playerRespect;
		(owner _playerObj) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;
	};


	if (DMS_Show_Party_Kill_Notification) then
	{
		private _group = group _playerObj;
		private _members = units _group;

		if ((count _members)>1) then
		{
			private _msg = format
			[
				"%1 killed %2 from %3 meters away and received %4 poptabs, and %5 respect.",
				name _playerObj,
				_unitName,
				if (_distance isEqualTo []) then {floor(_unit distance _playerObj)} else {_distance},
				_moneyChange,
				_repChange
			];

			/*
			if (DMS_Enable_RankChange) then
			{
				_msg = _msg + format[" (+%1 rank)", _rankChange];
			};
			*/

			{
				_msg remoteExecCall ["systemChat", _x];
			} forEach _members;
		};
	};


	//DONKEYPUNCH CUSTOM KILL STAT ADD FOR AI KILL
	if (DMS_Add_AIKill2DB) then
	{
		_newKillerFrags = _killer getVariable ["ExileKills", 0];
		_newKillerFrags = _newKillerFrags + 1;
		_killer setVariable ["ExileKills", _newKillerFrags];
		format["addAccountKill:%1", getPlayerUID _killer] call ExileServer_system_database_query_fireAndForget;
		ExileClientPlayerKills = _newKillerFrags;
		(owner _playerObj) publicVariableClient "ExileClientPlayerKills";
		ExileClientPlayerKills = nil;
	};

	/*
	//DONKEYPUNCH CUSTOM KILL RANK CHANGE FOR AI KILL
	if (DMS_Enable_RankChange && {_rankChange!=0}) then
	{
		_playerRank = (_playerRank+_rankChange);
		_killer setVariable ["ExileHumanity",_playerRank];
		format["modifyAccountHumanity:%1:%2",_rankChange,getPlayerUID _killer] call ExileServer_system_database_query_fireAndForget;
		ExileClientPlayerHumanity = _playerRank;
		(owner _playerObj) publicVariableClient "ExileClientPlayerHumanity";
		ExileClientPlayerHumanity = nil;
	};
	*/


	if (DMS_DEBUG) then
	{
		format ["PlayerAwardOnAIKill :: %1 (%2) awarded %3 poptabs and %4 respect for killing %5. Player's money is now %6, and respect is now %7. Roadkill: %8", name _playerObj, _playerUID, _moneyChange, _repChange, _unit, _playerMoney, _playerRespect, _roadKilled] call DMS_fnc_DebugLog;
	};
}
else
{
	if (DMS_DEBUG) then
	{
		format ["PlayerAwardOnAIKill :: No reward for non-player _playerObj: %1",_playerObj] call DMS_fnc_DebugLog;
	};
};
