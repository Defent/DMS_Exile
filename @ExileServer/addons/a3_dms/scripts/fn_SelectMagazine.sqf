/*
	DMS_fnc_selectMagazine
	Created by eraser1

	Usage:
	_weaponClassName call DMS_fnc_selectMagazine;

	Apply magazine type filters if needed
*/


private["_result","_ammoArray"];

_result 	= "";
_ammoArray 	= getArray (configFile >> "CfgWeapons" >> _this >> "magazines");

if (count _ammoArray > 0) then
{
	_result = _ammoArray select 0;
};

_result
