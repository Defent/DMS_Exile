/*
	DMS_fnc_selectMagazine
	Created by eraser1

	Usage:
	_weaponClassName call DMS_fnc_selectMagazine;

	Apply magazine type filters if needed
*/

private _result 	= "";
private _magArray 	= getArray (configFile >> "CfgWeapons" >> _this >> "magazines");

if (count _magArray > 0) then
{
	_result = _magArray select 0;
};

_result
