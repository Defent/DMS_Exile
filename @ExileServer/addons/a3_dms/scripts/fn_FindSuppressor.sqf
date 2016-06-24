/*
	DMS_fnc_FindSuppressor
	Originally from WAI
	Modified by eraser1 & Defent

	Usage:
	_weaponClassName call DMS_fnc_FindSuppressor;

*/

private _compatibleMuzzles = getArray (configfile >> "CfgWeapons" >> _this >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");

if (_compatibleMuzzles isEqualTo []) then
{
	""												// Return an empty string if there are no compatible muzzles/suppressors
}
else
{
	selectRandom _compatibleMuzzles					// Choose a random muzzle/suppressor (this is actually faster than selecting the first one)
};
