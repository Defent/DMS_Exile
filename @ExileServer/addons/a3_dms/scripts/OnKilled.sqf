private ["_rockets","_launcher","_type","_mission","_unit","_player"];
	
	_unit 		= _this select 0;
	_player 	= _this select 1;
	_type 		= _this select 2;
	_launcher 	= secondaryWeapon _unit;

	call {

	 // then is faster than exitWith
		if(_type == "ground") 	then { ai_ground_units = (ai_ground_units -1);};

	// Not defined yet -->
	//	if(_type == "air") 		exitWith { ai_air_units = (ai_air_units -1); };
	//	if(_type == "vehicle") 	exitWith { ai_vehicle_units = (ai_vehicle_units -1); };
	//	if(_type == "static") 	exitWith { ai_emplacement_units = (ai_emplacement_units -1); };
	// <-- Not defined yet 

	};
	

	if (isPlayer _player) then {

		
		/* < NOT SURE IF THIS WORKS IN EXILE >

		private ["_gainMoney","_gainRep",];

		if (DMS_MoneyGainOnKill) then {
			_gainMoney = _unit getVariable ["ExileMoney", 0];
			call {
				if (_unit getVariable ["Bandit", false]) exitWith {
					_player setVariable ["ExileMoney",(ExileMoney + DMS_MoneyGainOnKill),true]; 
				};					
			};
		};

		if (DMS_RepGainOnKill) then {
			_gainRep = _player getVariable ["ExileScore", 0];
			call {	
				if (_unit getVariable ["Bandit", false]) exitWith {
					_player setVariable ["ExileScore",(ExileScore + DMS_RepGainOnKill),true]; 
				};					
			};
		};

		*/

		
		if (DMS_clear_AI_body) then {
			DMS_CleanUpList pushBack [_unit,diag_tickTime,DMS_CompletedMissionCleanupTime];
		};


		if (DMS_ai_share_info) then {
			{
				if (((position _x) distance (position _unit)) <= DMS_ai_share_info_distance ) then {
					_x reveal [_player, 4.0];
				};
			} count allUnits;
		};


	} else {

		if (DMS_remove_roadkill) then {

			removeBackpack _unit;
			removeAllWeapons _unit;

			{
				_unit removeMagazine _x
			} count magazines _unit;

		} else {

			if ((random 100) <= DMS_remove_roadkill_chance) then {

				removeAllWeapons _unit;
				
			};

		};

	};

	if(DMS_ai_remove_launchers && _launcher != "") then {

		_rockets = _launcher call DMS_selectMagazine;
		_unit removeWeapon _launcher;
		
		{
			if(_x == _rockets) then {
				_unit removeMagazine _x;
			};
		} count magazines _unit;
		
	};

	if(DMS_RemoveNVG) then {
		if (_unit hasWeapon "NVGoggles") then {
			_unit removeWeapon "NVGoggles";
		};
	};
