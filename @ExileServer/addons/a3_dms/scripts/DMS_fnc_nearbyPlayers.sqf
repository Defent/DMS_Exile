DMS_fnc_nearbyPlayers = {
	private ["_pos", "_isNearList", "_isNear"];
	_pos = [_this, 0, objNull, [objNull,[]], [2,3]] call BIS_fnc_param;
	_dis = [_this, 1, DMS_player_minDist, [0]] call BIS_fnc_param;

	_isNearList = _pos nearEntities ["Exile_Unit_Player",_dis];
	_isNear = false;
	
	// Check for Players
	if ((count(_isNearList)) > 0) then {
		{
			if (isPlayer _x) exitWith {
				_isNear = true;
			};
			false;
		} count _isNearList;
	};

	// Check for Players in Vehicles
	if !(_isNear) then {
		_isNearList = _pos nearEntities [["LandVehicle", "Air", "Ship"], _dis];
		{
			if (_isNear) exitWith {};
			{
				if (isPlayer _x) exitWith {
					_isNear = true;
				};
				false;
			} count (crew _x);
			false;
		} count _isNearList;
	};
	_isNear
};