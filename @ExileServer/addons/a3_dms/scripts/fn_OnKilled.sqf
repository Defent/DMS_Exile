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
if (DMS_DEBUG) then
{
	(format ["OnKilled :: Logging AI death with parameters: %1",_this]) call DMS_fnc_DebugLog;
};

params
[
	"_unit",
	"_killer"
];
private _side 			= _unit getVariable ["DMS_AI_Side", "bandit"];
private _type 			= _unit getVariable ["DMS_AI_Type", "soldier"];
private _launcher 		= secondaryWeapon _unit;
private _launcherVar	= _unit getVariable ["DMS_AI_Launcher",""];
private _playerObj		= objNull;

_unit call ([missionNamespace getVariable [_unit getVariable ["DMS_AI_CustomOnKilledFnc",""],{}]] param [0,{},[{}]]);

// Some of the previously used functions work with non-local argument. Some don't. BIS is annoying
private _removeAll =
{
	{_this removeWeaponGlobal _x;} forEach (weapons _this);
	{_this unlinkItem _x;} forEach (assignedItems _this);
	{_this removeItem _x;} forEach (items _this);

	removeAllItemsWithMagazines 	_this;
	removeHeadgear 					_this;
	removeUniform 					_this;
	removeVest 						_this;
	removeBackpackGlobal 			_this;
};

moveOut _unit;

_unit removeAllEventHandlers "HandleDamage";

// Remove gear according to configs
if (DMS_clear_AI_body && {(random 100) <= DMS_clear_AI_body_chance}) then
{
	_unit call _removeAll;
};

if (DMS_ai_remove_launchers && {(_launcherVar != "") || {_launcher != ""}}) then
{
	// Because arma is stupid sometimes
	if (_launcher isEqualTo "") then
	{
		_launcher = _launcherVar;

		diag_log "sneaky launchers...";

		_unit spawn
		{
			sleep 0.5;

			{
				_holder = _x;
				{
					if (_x isKindOf ["LauncherCore", configFile >> "CfgWeapons"]) exitWith
					{
						deleteVehicle _holder;
						diag_log "gotcha";
					};
				} forEach (weaponCargo _holder);
			} forEach (nearestObjects [_this, ["GroundWeaponHolder","WeaponHolderSimulated"], 5]);
		};
	};

	_unit removeWeaponGlobal _launcher;

	{
		if (_x isKindOf ["CA_LauncherMagazine", configFile >> "CfgMagazines"]) then
		{
			_unit removeMagazineGlobal _x;
		};
	} forEach (magazines _unit);
};

if(DMS_RemoveNVG) then
{
	_unit unlinkItem "NVGoggles";
};

private _grp = group _unit;
private _grpUnits = (units _grp) - [_unit];
// Give the AI a new leader if the killed unit was the leader
if (!(_grpUnits isEqualTo []) && {(leader _grp) isEqualTo _unit}) then
{
	_grp selectLeader (selectRandom _grpUnits);
};

private _av = _unit getVariable ["DMS_AssignedVeh",objNull];
if (!isNull _av) then
{
	// Determine whether or not the vehicle has any active crew remaining.
	private _memCount = {[(alive _x),false] select (_unit isEqualTo _x);} count (crew _av);


	// Destroy the vehicle and add it to cleanup if there are no active crew members of the vehicle.
	if (_memCount isEqualTo 0) then
	{
		/*
		This is some pretty funky code because this is about the fastest way to do the task.
		An "if-statement" inside another "if-statement" is almost as fast, but it isn't as slick ;)
		*/
		if
		(
			call
			([
				{	(random 100)<(_av getVariable ["DMS_DestructionChance",DMS_AI_destroyVehicleChance])	},
				{	DMS_AI_destroyStaticWeapon && {(random 100)<(_av getVariable ["DMS_DestructionChance",DMS_AI_destroyStaticWeapon_chance])}	}
			] select (_av isKindOf "StaticWeapon"))
		) then
		{
			_av setDamage 1;
			_av setVariable ["ExileDiedAt",time];
			_av spawn {sleep 1;_this enableSimulationGlobal false;};


			if (DMS_DEBUG) then
			{
				(format["OnKilled :: Destroying used AI vehicle %1, and disabling simulation.",typeOf _av]) call DMS_fnc_DebugLog;
			};
		}
		else
		{
			_av lock 1;

			if (DMS_DEBUG) then
			{
				(format["OnKilled :: Unlocking used AI vehicle (%1).",typeOf _av]) call DMS_fnc_DebugLog;
			};
		};
	}
	else
	{
		// Only check for this stuff for ground vehicles that have guns...
		if ((_av isKindOf "LandVehicle") && {(count (weapons _av))>0}) then
		{
			private _gunner = gunner _av;
			private _driver = driver _av;


			// The fact that I have to do this in the FUCKING ONKILLED EVENTHANDLER is a testament to why ArmA will make me die prematurely
			private _gunnerIsAlive = alive _gunner;
			private _driverIsAlive = alive _driver;

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
					params
					[
						"_driver",
						"_av",
						"_killer"
					];

					private _grp 		= group _driver;
					private _owner 		= groupOwner _grp;

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
						(format["OnKilled :: Switched driver of AI Vehicle (%1) to gunner.",typeOf _av]) call DMS_fnc_DebugLog;
					};

					if (_owner!=2) then
					{
						private _start = time;

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

private _roadKilled = false;

if (isPlayer _killer) then
{
	private _veh = vehicle _killer;

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
			private _boom = createVehicle ["SLAMDirectionalMine_Wire_Ammo", [0,0,100], [], 0, "CAN_COLLIDE"];
			_boom setPosATL (getPosATL _playerObj);
			_boom setDamage 1;
			if (DMS_DEBUG) then
			{
				(format ["OnKilled :: %1 roadkilled an AI! Creating mine at the roadkilled AI's position!",name _killer]) call DMS_fnc_DebugLog;
			};
		};


		// Remove gear from roadkills if configured to do so
		if (DMS_remove_roadkill && {(random 100) <= DMS_remove_roadkill_chance}) then
		{
			_unit call _removeAll;
		};
	};

	_unit setVariable ["DMS_KillerID",owner _playerObj];


	// Reveal the killer to the AI units
	if (DMS_ai_share_info) then
	{
		private _revealAmount = 4.0;

		private _muzzle = currentMuzzle _playerObj;

		if (_muzzle isEqualType "") then
		{
			private _silencer = _playerObj weaponAccessories _muzzle select 0;
			if (!isNil "_silencer" && {_silencer != ""}) then
			{
				_revealAmount = 2.0;
			};
		};


		{
			if ((alive _x) && {!(isPlayer _x) && {(_x distance2D _unit) <= DMS_ai_share_info_distance}}) then
			{
				_x reveal [_killer, _revealAmount max (_x knowsAbout _playerObj)];
			};
		} forEach _grpUnits;
	};
};


[_playerObj, _unit, _side, _type, _roadKilled] call DMS_fnc_PlayerAwardOnAIKill;


// Let Exile handle the AI Body cleanup.
_unit setVariable ["ExileDiedAt",time];
_unit setVariable ["DMS_KillerObj",[_playerObj,_killer] select (isNull _playerObj)];
