/*
	DMS_FindSuppressor
	Taken from WAI
	Modified by eraser1 & Defent

	Usage:
	_weaponClassName call DMS_FindSuppressor;

*/

private["_weapon","_result","_ammoName","_rnd338","_rnd93"];

_result 	= "";
_weapon 	= _this;

// Zafir accepts no suppressors :(
if (_weapon=="LMG_Zafir_F") exitWith {""};

_rnd338 = ["muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand"];
_rnd93 = ["muzzle_snds_93mmg","muzzle_snds_93mmg_tan"];

_ammoName	= getText  (configFile >> "cfgWeapons" >> _weapon >> "displayName");


switch (_ammoName) do {

	case ((_ammoName find "6.5") > -1): {
		if (_ammoName find "LMG_Mk200" > -1) then {
				_result = "muzzle_snds_H_MG";
		   } else {
		   		_result = "muzzle_snds_H";
		   };
		};	

	case ((_ammoName find "5.56") > -1): {_result = "muzzle_snds_M";};	

	case ((_ammoName find "7.62") > -1): {_result = "muzzle_snds_H";};	

	case ((_ammoName find ".45") > -1): {_result = "muzzle_snds_acp";};	

	case ((_ammoName find "9 mm") > -1): {_result = "muzzle_snds_L";};	

	case ((_ammoName find ".338") > -1): {_result = _rnd338 call BIS_fnc_selectRandom;};

	case ((_ammoName find "9.3 mm") > -1): {_result = _rnd93 call BIS_fnc_selectRandom;};

};
_result
