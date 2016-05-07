/*
	DMS_fnc_FindSuppressor
	Originally from WAI
	Modified by eraser1 & Defent

	Usage:
	_weaponClassName call DMS_fnc_FindSuppressor;

*/

private _weapon 	= _this;

private _weaponName	= getText  (configFile >> "cfgWeapons" >> _weapon >> "displayName");


switch (true) do
{
	// Zafir accepts no suppressors :(
	case ((_weapon find "Zafir")>-1) : {""};

	case ((_weaponName find "6.5") > -1) :
	{
		if (_weapon find "LMG_Mk200" > -1) then
		{
			"muzzle_snds_H_MG";
		}
		else
		{
		   "muzzle_snds_H";
		};
	};

	case ((_weaponName find "5.56") > -1) : {"muzzle_snds_M"};

	case ((_weaponName find "7.62") > -1) : {"muzzle_snds_B"};

	case ((_weaponName find ".45") > -1) : {"muzzle_snds_acp"};

	case ((_weaponName find "9 mm") > -1) : {"muzzle_snds_L"};

	case ((_weaponName find ".338") > -1) : {selectRandom ["muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand"]};

	case ((_weaponName find "9.3 mm") > -1) : {selectRandom ["muzzle_snds_93mmg","muzzle_snds_93mmg_tan"]};
};
