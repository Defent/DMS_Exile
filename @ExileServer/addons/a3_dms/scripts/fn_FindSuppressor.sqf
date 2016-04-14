/*
	DMS_fnc_FindSuppressor
	Originally from WAI
	Modified by eraser1 & Defent

	Usage:
	_weaponClassName call DMS_fnc_FindSuppressor;

*/

private["_weapon","_result","_weaponName","_rnd338","_rnd93"];

_result 	= "";
_weapon 	= _this;


_weaponName	= getText  (configFile >> "cfgWeapons" >> _weapon >> "displayName");

switch (true) do
{
	case ((_weaponName find "6.5") > -1) :
	{
		if (_weapon find "LMG_Mk200" > -1) then
		{
			_result = "muzzle_snds_H_MG";
		}
		else
		{
		   _result = "muzzle_snds_H";
		};
	};

	case ((_weaponName find "5.56") > -1) : {_result = "muzzle_snds_M";};

	case ((_weaponName find "7.62") > -1) : {_result = "muzzle_snds_B";};

	case ((_weaponName find ".45") > -1) : {_result = "muzzle_snds_acp";};

	case ((_weaponName find "9 mm") > -1) : {_result = "muzzle_snds_L";};

	case ((_weaponName find ".338") > -1) : {_result = ["muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand"] call BIS_fnc_selectRandom;};

	case ((_weaponName find "9.3 mm") > -1) : {_result = ["muzzle_snds_93mmg","muzzle_snds_93mmg_tan"] call BIS_fnc_selectRandom;};
};

// Zafir accepts no suppressors :(
if ((_weapon find "Zafir")>-1) then {_result = "";};


_result