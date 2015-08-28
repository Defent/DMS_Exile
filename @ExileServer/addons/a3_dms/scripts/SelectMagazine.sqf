private["_result","_ammoArray"];

_result 	= "";
_ammoArray 	= getArray (configFile >> "CfgWeapons" >> _this >> "magazines");

if (count _ammoArray > 0) then {
	_result = _ammoArray select 0;
};

_result