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


private ["_unit", "_killer", "_side", "_type", "_launcher", "_launcherVar", "_playerObj", "_removeAll", "_rockets", "_grpUnits", "_av", "_memCount", "_gunner", "_driver", "_gunnerIsAlive", "_driverIsAlive", "_grp", "_owner", "_start", "_roadKilled", "_veh", "_boom", "_revealAmount", "_silencer", "_moneyChange", "_repChange", "_money", "_respect", "_msgType", "_msgParams"];


if (DMS_DEBUG) then
{
	diag_log format ["DMS_DEBUG OnKilled :: Logging AI death with parameters: %1",_this];
};
	
_unit 			= _this select 0 select 0;
_killer 		= _this select 0 select 1;
_side 			= _this select 1;
_type 			= _this select 2;
_launcher 		= secondaryWeapon _unit;
_launcherVar	= _unit getVariable ["DMS_AI_Launcher",""];
_playerObj		= objNull;

// Some of the previously used functions work with non-local argument. Some don't. BIS is annoying
_removeAll =
{
	{_this removeWeaponGlobal _x;} forEach (weapons _this);
	{_this unlinkItem _x;} forEach (assignedItems _this);
	{_this removeItem _x;} forEach (items _this);

	removeAllItemsWithMagazines 	_unit;
	removeHeadgear 					_unit;
	removeUniform 					_unit;
	removeVest 						_unit;
	removeBackpackGlobal 			_unit;
};

moveOut _unit;

// Remove gear according to configs
if (DMS_clear_AI_body && {(random 100) <= DMS_clear_AI_body_chance}) then
{
	_unit call _removeAll;
};

if(DMS_ai_remove_launchers && {(_launcherVar != "") || {_launcher != ""}}) then
{
	// Because arma is stupid sometimes
	if (_launcher=="") then
	{
		_launcher = _launcherVar;

		diag_log "sneaky launchers...";

		{
			if (_launcherVar in (weaponCargo _x)) exitWith
			{
				deleteVehicle _x;
				diag_log "gotcha";
			};
		} forEach (nearestObjects [_unit, ["GroundWeaponHolder","WeaponHolderSimulated"], 5]);
	};

	_rockets = _launcher call DMS_fnc_selectMagazine;
	_unit removeWeaponGlobal _launcher;
	
	{
		if(_x == _rockets) then
		{
			_unit removeMagazineGlobal _x;
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

_av = _unit getVariable ["DMS_AssignedVeh",objNull];
if (!isNull _av) then
{
	// Determine whether or not the vehicle has any active crew remaining.
	_memCount = {[(alive _x),false] select (_unit isEqualTo _x);} count (crew _av);


	// Destroy the vehicle and add it to cleanup if there are no active crew members of the vehicle.
	if (_memCount<1) then
	{
		_av setDamage 1;
		DMS_CleanUpList pushBack [_av,diag_tickTime,DMS_AIVehCleanUpTime];
		_av spawn {sleep 1;_this enableSimulationGlobal false;};


		if (DMS_DEBUG) then
		{
			diag_log format["DMS_DEBUG OnKilled :: Destroying used AI vehicle %1, disabling simulation, and adding to cleanup.",typeOf _av];
		};
	}
	else
	{
		// Only check for this stuff for ground vehicles that have guns...
		if ((_av isKindOf "LandVehicle") && {(count (weapons _av))>0}) then
		{
			_gunner = gunner _av;
			_driver = driver _av;


			// The fact that I have to do this in the FUCKING ONKILLED EVENTHANDLER is a testament to why ArmA will make me die prematurely
			_gunnerIsAlive = alive _gunner;
			_driverIsAlive = alive _driver;

			if (_unit isEqualTo _gunner) then
			{
				_gunnerIsAlive = false;
			};
			if (_unit isEqualTo _driver) then
			{
				_driverIsAlive = false;
			};

			// If the gunner is dead but the driver is alive, then the driver becomes the gunner.
			// Helps with troll AI vehicles driving around aimlessly after the gunner is shot off. More realistic imo
			if (!_gunnerIsAlive && {_driverIsAlive}) then
			{
				[_driver,_av,_killer] spawn
				{
					_driver 	= _this select 0;
					_av 		= _this select 1;
					_killer 	= _this select 2;
					_grp 		= group _driver;
					_owner 		= groupOwner _grp;

					_grp setVariable ["DMS_LockLocality",true];

					// The AI has to be local in order for these commands to work, so I reset locality, just because it's really difficult to deal with otherwise
					if (_owner!=2) then
					{
						diag_log format ["Temporarily setting owner of %1 to server from %2. Success: %3",_grp,_owner,_grp setGroupOwner 2];
					};

					sleep 5+(random 3); // 5 to 8 seconds delay after gunner death

					if !(alive _driver) exitWith {};

					unassignVehicle _driver;
					moveOut _driver;
					
					_driver disableCollisionWith _av;

					_av setVehicleAmmoDef 1;

					waitUntil
					{
						unassignVehicle _driver;
						doGetOut _driver;
						moveOut _driver;
						(vehicle _driver)==_driver
					};

					_driver assignAsGunner _av;
					[_driver] orderGetIn true;

					sleep 1.5;
					if !(alive _driver) exitWith {};

					_driver moveInGunner _av;
					
					_driver enableCollisionWith _av;

					if (DMS_DEBUG) then
					{
						diag_log format["DMS_DEBUG OnKilled :: Switched driver of AI Vehicle (%1) to gunner.",typeOf _av];
					};

					if (_owner!=2) then
					{
						_start = time;
						
						// Controlling AI... yes. I have to do this
						waitUntil
						{
							_driver assignAsGunner _av;
							[_driver] orderGetIn true;

							_driver moveInGunner _av;
						
							(((gunner _av) isEqualTo _driver) || {(time-_start)>30})
						};

						sleep 3;

						_start = time;

						waitUntil
						{
							_driver assignAsGunner _av;
							[_driver] orderGetIn true;

							_driver moveInGunner _av;
						
							(((gunner _av) isEqualTo _driver) || {(time-_start)>30})
						};

						_driver doTarget _killer;
						_driver doFire _killer;

						sleep 15;

						diag_log format ["Resetting ownership of %1 to %2. Success: %3",_grp,_owner,_grp setGroupOwner _owner];
					};

					_grp setVariable ["DMS_LockLocality",false];
				};
			};
		};
	};
};

_roadKilled = false;

if (isPlayer _killer) then
{
	_veh = vehicle _killer;

	_playerObj = _killer;


	// Fix for players killing AI from mounted vehicle guns
	if (!(_killer isKindOf "Exile_Unit_Player") && {!isNull (gunner _killer)}) then
	{
		_playerObj = gunner _killer;
	};


	if (!(_veh isEqualTo _killer) && {(driver _veh) isEqualTo _killer}) then
	{
		_playerObj = driver _veh;

		_roadKilled = true;

		if (DMS_explode_onRoadkill) then
		{
			_boom = createVehicle ["SLAMDirectionalMine_Wire_Ammo", ASLToAGL(getPosWorld _unit), [], 0, "CAN_COLLIDE"];
			_boom setDamage 1;
			if (DMS_DEBUG) then
			{
				diag_log format ["DMS_DEBUG OnKilled :: %1 roadkilled an AI! Creating mine at the roadkilled AI's position!",name _killer];
			};
		};


		// Remove gear from roadkills if configured to do so
		if (DMS_remove_roadkill && {(random 100) <= DMS_remove_roadkill_chance}) then
		{
			_unit call _removeAll;
		};
	};


	// Reveal the killer to the AI units
	if (DMS_ai_share_info) then
	{
		_revealAmount = 4.0;

		_silencer = _playerObj weaponAccessories currentMuzzle _playerObj select 0;
		if (!isNil "_silencer" && {_silencer != ""}) then
		{
			_revealAmount = 2.0;
		};


		{
			if ((alive _x) && {!(isPlayer _x) && {((getPosWorld _x) distance2D (getPosWorld _unit)) <= DMS_ai_share_info_distance}}) then
			{
				_x reveal [_killer, _revealAmount max (_x knowsAbout _playerObj)];
			};
		} forEach allUnits;
	};
};


if ((!isNull _playerObj) && {((getPlayerUID _playerObj) != "") && {_playerObj isKindOf "Exile_Unit_Player"}}) then
{
	_moneyChange = missionNamespace getVariable [format ["DMS_%1_%2_MoneyGain",_side,_type],0];
	_repChange = missionNamespace getVariable [format ["DMS_%1_%2_RepGain",_side,_type],0];

	if (_roadKilled && {DMS_Diff_RepOrTabs_on_roadkill}) then
	{
		_moneyChange = missionNamespace getVariable [format ["DMS_%1_%2_RoadkillMoney",_side,_type],0];
		_repChange = missionNamespace getVariable [format ["DMS_%1_%2_RoadkillRep",_side,_type],0];
	};

	if ((_moneyChange!=0) || (_repChange!=0)) then
	{
		_money = _playerObj getVariable ["ExileMoney", 0];
		_respect = _playerObj getVariable ["ExileScore", 0];
		
		if (_moneyChange!=0) then
		{
			private ["_msgType", "_msgParams"];

			// Set client's money
			// I also make sure that they don't get negative poptabs
			_money = (_money + _moneyChange) max 0;
			_playerObj setVariable ["ExileMoney",_money];

			// Change message for players when they're actually LOSING poptabs
			_msgType = "moneyReceivedRequest";
			_msgParams = [str _money, format ["killing a %1 AI",_type]];

			if (_moneyChange<0) then
			{
				_msgType = "notificationRequest";
				_msgParams = ["Whoops",[format ["Lost %1 poptabs from running over a %2 AI!",abs _moneyChange,_type]]];

				// With the error message the money value won't be updated on the client, so I just directly PVC the value.
				ExileClientPlayerMoney = _money;
				(owner _playerObj) publicVariableClient "ExileClientPlayerMoney";
				ExileClientPlayerMoney = nil;
			};

			// Send notification and update client's money stats
			[_playerObj, _msgType, _msgParams] call ExileServer_system_network_send_to;
		};

		if (_repChange!=0) then
		{
			// Set client's respect
			_respect = _respect + _repChange;
			_playerObj setVariable ["ExileScore",_respect];

			// Send frag message
			[_playerObj, "showFragRequest", [ [[format ["%1 AI KILL",toUpper _type],_repChange]] ] ] call ExileServer_system_network_send_to;

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