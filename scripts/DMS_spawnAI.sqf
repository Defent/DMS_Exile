DMS_spawnAI = {
	private ["_group", "_pos","_soldier","_skill","_units","_playerObject"];
	_pos  = _this select 0;
	_units = _this select 1;
	_skill = _this select 2;
	//_playerObject = (owner player);
	// Needed 4 exile
	_group = createGroup INDEPENDENT;
	_group setBehaviour "COMBAT";
	_group setCombatMode "RED";
	_group allowFleeing 0;
	
	// Set AI owner to Player.
	_group setGroupOwner (owner player);
	// Not tested this one, may need to apply above one.
	//ExileServerOwnershipSwapQueue pushBack [_group,_playerObject];
	
	
	for "_i" from 1 to _units do {
		_soldier = _group createUnit ["i_g_soldier_unarmed_f", [_pos select 0, _pos select 1, 0], [], 1, "Form"];
		removeAllAssignedItems _soldier;
		removeUniform _soldier;
		removeHeadgear _soldier;
		removeAllItems _soldier;
		removeAllWeapons _soldier;
		_soldier forceaddUniform "U_I_officerUniform";
		_soldier addVest "V_5_Epoch"; 
		_soldier addGoggles "G_Diving";
		for "_i" from 1 to 3 do {
		_soldier addItemToVest  "30Rnd_65x39_caseless_mag";
		};
		_soldier addWeapon "arifle_MXC_Holo_pointer_F";
		_soldier setRank "Private";
		{
		_soldier enableAI _x;
		}forEach ["TARGET","AUTOTARGET","MOVE","ANIM"];
		_soldier disableAI "FSM";
		_soldier allowDammage true;
		switch (_skill) do
		{
			case 1: 
			{
				_soldier setSkill ["aimingspeed", 0.05];
				_soldier setSkill ["spotdistance", 0.05];
				_soldier setSkill ["aimingaccuracy", 0.02];
				_soldier setSkill ["aimingshake", 0.02];
				_soldier setSkill ["spottime", 0.1];
				_soldier setSkill ["spotdistance", 0.3];
				_soldier setSkill ["commanding", 0.3];
				_soldier setSkill ["general", 0.2];
			};
			case 2: 
			{
				_soldier setSkill ["spotdistance", 0.1];
				_soldier setSkill ["aimingaccuracy", 0.05];
				_soldier setSkill ["aimingshake", 0.05];
				_soldier setSkill ["spottime", 0.2];
				_soldier setSkill ["spotdistance", 0.4];
				_soldier setSkill ["commanding", 0.4];
				_soldier setSkill ["general", 0.3];
			};
			case 3:
			{
				_soldier setSkill ["aimingspeed", 0.15];
				_soldier setSkill ["spotdistance", 0.15];
				_soldier setSkill ["aimingaccuracy", 0.1];
				_soldier setSkill ["aimingshake", 0.1];
				_soldier setSkill ["spottime", 0.3];
				_soldier setSkill ["spotdistance", 0.5];
				_soldier setSkill ["commanding", 0.5];
				_soldier setSkill ["general", 0.6];
				};
			case 4: 
			{
				_soldier setSkill ["aimingspeed", 0.3];
				_soldier setSkill ["spotdistance", 0.3];
				_soldier setSkill ["aimingaccuracy", 0.3];
				_soldier setSkill ["aimingshake", 0.3];
				_soldier setSkill ["spottime", 0.4];
				_soldier setSkill ["spotdistance", 0.6];
				_soldier setSkill ["commanding", 0.6];
				_soldier setSkill ["general", 0.7];
			};		
			case 5: 
			{

				_soldier setSkill ["aimingspeed", 0.9];
				_soldier setSkill ["spotdistance", 0.9];
				_soldier setSkill ["aimingaccuracy", 0.9];
				_soldier setSkill ["aimingshake", 0.9];
				_soldier setSkill ["spottime", 0.9];
				_soldier setSkill ["spotdistance", 0.9];
				_soldier setSkill ["commanding", 0.8];
			};
			case 6: // Stupidly fucking OP.
			{
				_soldier setSkill ["aimingspeed", 1];
				_soldier setSkill ["spotdistance", 1];
				_soldier setSkill ["aimingaccuracy", 1];
				_soldier setSkill ["aimingshake", 1];
				_soldier setSkill ["spottime", 1];
				_soldier setSkill ["spotdistance", 1];
				_soldier setSkill ["commanding", 1];
			};
		};
	};
};
