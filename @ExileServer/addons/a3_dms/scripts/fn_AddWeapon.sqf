/*
	DMS_fnc_AddWeapon
	created by eraser1 - based off of BIS_fnc_AddWeapon

    https://github.com/Defent/DMS_Exile/wiki/DMS_fnc_AddWeapon

	Description:
	Add a weapon to a unit with the right magazines. Magazine class is obtained from the weapon's config.

    Usage:
    [
        _unit,              // <object> The unit that is to receive the weapon (and magazines).
        _weapon,            // <string> The classname of the weapon to be added.
        _magazineCount,     // <scalar> Number of magazines to be added.
        _magClassname       // <string> (Optional) The classname of the magazine to be added.
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
                _weapon call DMS_fnc_selectMagazine
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
