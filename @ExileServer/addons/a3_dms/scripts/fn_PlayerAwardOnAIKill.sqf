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

private ["_playerUID", "_playerObj", "_moneyChange", "_AISide", "_AIType", "_repChange", "_roadKilled", "_unitMoney", "_unit", "_unitRespect", "_playerMoney", "_playerRespect", "_msgType", "_msgParams"];

if !(params
[
	["_playerObj",	objNull,	[objNull]	],
	["_unit",		objNull,	[objNull]	],
	["_AISide",		"",			[""]		],
	["_AIType",		"",			[""]		],
	["_roadKilled",	false,		[false]		]
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_PlayerAwardOnAIKill with invalid parameters: %1",_this];
};


_playerUID = getPlayerUID _playerObj;

if ((!isNull _playerObj) && {(_playerUID != "") && {_playerObj isKindOf "Exile_Unit_Player"}}) then
{
	_moneyChange = missionNamespace getVariable [format ["DMS_%1_%2_MoneyGain",_AISide,_AIType],0];
	_repChange = missionNamespace getVariable [format ["DMS_%1_%2_RepGain",_AISide,_AIType],0];


	// Check for individually defined AI money/respect.
	_unitMoney = _unit getVariable ["DMS_AI_Money",""];
	_unitRespect = _unit getVariable ["DMS_AI_Respect",""];

	if !(_unitMoney isEqualTo "") then
	{
		_moneyChange = _unitMoney;
	};

	if !(_unitRespect isEqualTo "") then
	{
		_repChange = _unitRespect;
	};


	if (_roadKilled && {DMS_Diff_RepOrTabs_on_roadkill}) then
	{
		_moneyChange = missionNamespace getVariable [format ["DMS_%1_%2_RoadkillMoney",_AISide,_AIType],0];
		_repChange = missionNamespace getVariable [format ["DMS_%1_%2_RoadkillRep",_AISide,_AIType],0];
	};


	if ((_moneyChange!=0) || (_repChange!=0)) then
	{
		_playerMoney = _playerObj getVariable ["ExileMoney", 0];
		_playerRespect = _playerObj getVariable ["ExileScore", 0];

		if (DMS_DEBUG) then
		{
			format ["PlayerAwardOnAIKill :: Attempting to give %1 (%2) %3 poptabs and %4 respect. Player currently has %5 tabs and %6 respect.", name _playerObj, _playerUID, _moneyChange, _repChange, _playerMoney, _playerRespect] call DMS_fnc_DebugLog;
		};
		
		if (_moneyChange!=0) then
		{
			private ["_msgType", "_msgParams"];

			// Set client's money
			// I also make sure that they don't get negative poptabs
			_playerMoney = (_playerMoney + _moneyChange) max 0;
			_playerObj setVariable ["ExileMoney",_playerMoney];

			_msgType = "moneyReceivedRequest";
			_msgParams = [str _playerMoney, format ["killing a %1 AI",_AIType]];

			if (_moneyChange<0) then
			{
				// Change message for players when they're actually LOSING poptabs
				_msgType = "notificationRequest";
				_msgParams = ["Whoops",[format ["Lost %1 poptabs from running over a %2 AI!",abs _moneyChange,_AIType]]];

				// With the error message the money value won't be updated on the client, so I just directly PVC the value.
				ExileClientPlayerMoney = _playerMoney;
				(owner _playerObj) publicVariableClient "ExileClientPlayerMoney";
				ExileClientPlayerMoney = nil;
			};

			if (DMS_Show_Kill_Poptabs_Notification) then
			{
				// Send notification and update client's money stats
				[_playerObj, _msgType, _msgParams] call ExileServer_system_network_send_to;
			}
			else
			{
				// Player's money will already be updated for negative values, so let's not create unnecessary network traffic by sending another PVC
				if (_moneyChange>0) then
				{
					ExileClientPlayerMoney = _playerMoney;
					(owner _playerObj) publicVariableClient "ExileClientPlayerMoney";
					ExileClientPlayerMoney = nil;
				};
			};
		};

		if (_repChange!=0) then
		{
			_attributes = [[format ["%1 AI KILL",toUpper _AIType],_repChange]];

			if (DMS_AIKill_DistanceBonusCoefficient>0) then
			{
				_distance = floor (_unit distance _playerObj);

				if (_distance>DMS_AIKill_DistanceBonusMinDistance) then
				{
					_distanceBonus = floor (_distance * DMS_AIKill_DistanceBonusCoefficient);
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

			// Send updated respect value to client
			ExileClientPlayerScore = _playerRespect;
			(owner _playerObj) publicVariableClient "ExileClientPlayerScore";
			ExileClientPlayerScore = nil;
		};

		if (DMS_DEBUG) then
		{
			format ["PlayerAwardOnAIKill :: %1 (%2) awarded %3 poptabs and %4 respect for killing %5. Player's money is now %6, and respect is now %7. Roadkill: %8", name _playerObj, _playerUID, _moneyChange, _repChange, _unit, _playerMoney, _playerRespect, _roadKilled] call DMS_fnc_DebugLog;
		};

		// Update client database entry
		format["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, _playerUID] call ExileServer_system_database_query_fireAndForget;
	}
	else
	{
		if (DMS_DEBUG) then
		{
			format ["PlayerAwardOnAIKill :: %1 (%2) was not awarded any poptabs or respect.", name _playerObj, _playerUID] call DMS_fnc_DebugLog;
		};
	};
}
else
{
	if (DMS_DEBUG) then
	{
		format ["PlayerAwardOnAIKill :: No reward for non-player _playerObj: %1",_playerObj] call DMS_fnc_DebugLog;
	};
};