private["_result","_position","_radius"];

_result 	= false;
_position 	= _this select 0;
_radius		= _this select 1;

for "_i" from 0 to 359 step 45 do {
	_position = [(_position select 0) + (sin(_i)*_radius), (_position select 1) + (cos(_i)*_radius)];
	if (surfaceIsWater _position) exitWith {
		_result = true; 
	};
};
_result