/*
	DMS_fnc_AddWeapon
	created by eraser1 - based off of BIS_fnc_AddWeapon

	Description:
	Add a weapon to a unit with the right magazines. Magazine class is obtained from the weapon's config.

    Usage:
    [
        _unit,              // <object> unit that is issued new equipment
        _weapon,            // <string> weapon classname
        _magazineCount,     // <scalar> number of magazines
        _magClassname       // (Optional): <scalar> index of magazine class in weapon's config (default 0) OR <string> magazine classname
    ] call DMS_fnc_AddWeapon;

	Nothing is returned
*/

if (params
[
    "_unit",
    "_weapon",
    "_magazineCount"
])
then
{
    //Add magazines
    if (_magazineCount > 0) then
    {
        private _magazine =
            if ((count _this) > 3) then
            {
                _this select 3
            }
            else
            {
                (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0
            };

		for "_i" from 1 to _magazineCount do
		{
			_unit addMagazine _magazine;
		};
    };

	//Add weapon
	_unit addWeapon _weapon;
}
else
{
    diag_log format["DMS ERROR :: Calling DMS_fnc_AddWeapon with invalid parameters: %1",_this];
};
