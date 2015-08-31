/*
	DMS_FindSuppressor
	Taken from WAI
	Modified by eraser1

	Usage:
	_weaponClassName call DMS_FindSuppressor;

*/

private["_weapon","_result","_ammoName"];

_result 	= "";
_weapon 	= _this;

// Zafir accepts no suppressors :(
if (_weapon=="LMG_Zafir_F") exitWith {""};


_ammoName	= getText  (configFile >> "cfgWeapons" >> _weapon >> "displayName");


if ((_ammoName find "5.56") > -1) then
{
	_result = "muzzle_snds_M";
};

if ((_ammoName find "6.5") > -1) then
{
	_result = "muzzle_snds_H";
};

if ((_ammoName find "7.62") > -1) then
{
	_result = "muzzle_snds_H";
};

//TODO Add functionality for 9.3 and .338

_result