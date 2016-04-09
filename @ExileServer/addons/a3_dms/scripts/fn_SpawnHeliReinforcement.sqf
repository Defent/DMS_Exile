/*
    DMS_fnc_SpawnHeliReinforcement
    Created by eraser1

    **********!!!!NOTE!!!!**********: THIS FUNCTION IS NOT FINAL, IT IS FOR TESTING PURPOSES ONLY! Changes are planned, and the function parameters will likely change.

    This function will create a heli/aircraft within "DMS_RHeli_MinDistFromDrop" to "DMS_RHeli_MaxDistFromDrop" meters and drop units at "_dropPoint".

    Usage:
    [
        _AIGroup,                       // GROUP: The group to which the heli will be assigned.
        _class,                         // STRING: The class of AI to spawn in the heli.
        _difficulty,                    // STRING: The difficulty of the AI to spawn in the heli.
        _side,                          // STRING: The "side" that the AI are on.
        _dropPoint,                     // OBJECT or ARRAY (Position2D or 3D): The location to drop the reinforcements at.
        _ejectFFVGunners,               // BOOLEAN: Whether or not to eject Fire-From-Vehicle (FFV) gunners.
        _remainAsGunship,               // BOOLEAN: Whether or not to keep the heli flying around as a gunship.
        _heliClass,                     // STRING (OPTIONAL): The classname of the heli to spawn.
        _spawnPos                       // ARRAY (OPTIONAL - Position2D or 3D): The position for the heli to spawn at.
    ] call DMS_fnc_SpawnHeliReinforcement;

    Returns the index of the paratrooper info in "DMS_HeliParatrooper_Arr", -1 on error.
*/

private ["_heliClass", "_groupOwner", "_spawnPos", "_heli", "_pilot", "_units", "_crewCount", "_paratrooperCount", "_unit", "_cargoIndex"];


if !(params
[
    ["_AIGroup", 0, [grpNull]],
    ["_class", 0, [""]],
    ["_difficulty", 0, [""]],
    ["_side", 0, [""]],
    ["_dropPoint", 0, [[],objNull], [2,3]],
    ["_ejectFFVGunners", 0, [false]],
    ["_remainAsGunship", 0, [false]]
])
exitWith
{
    diag_log format["DMS ERROR :: Calling DMS_fnc_SpawnHeliReinforcement with invalid parameters: %1",_this];
    -1
};

if (isNull _AIGroup) exitWith
{
    diag_log format["DMS ERROR :: Calling DMS_fnc_SpawnHeliReinforcement with null ""_AIGroup""! _this: %1 ",_this];
    -1
};

_heliClass = if ((count _this)>7) then {_this param [7, "", [""]]} else {selectRandom DMS_ReinforcementHelis};

// Make the AI group local to add passengers.
if !(local _AIGroup) then
{
    _groupOwner = groupOwner _AIGroup;
    _AIGroup setGroupOwner 2;
};

// Get the spawn position for the heli
_spawnPos =
    if ((count _this)>8) then
    {
        _this param [8, "", [[]], [2,3]]
    }
    else
    {
        [
            _dropPoint,
            DMS_RHeli_MinDistFromDrop,
            DMS_RHeli_MaxDistFromDrop,
            [
                0,
                0,
                0,
                0,
                0,
                0,
                DMS_RHeli_MinDistFromPlayers,
                true,
                false
            ]
        ] call DMS_fnc_FindSafePos_InRange
    };
_spawnPos set [2,DMS_RHeli_Height];



// Spawn the heli
_heli = createVehicle [_heliClass, _spawnPos, [], 0, "FLY"];
_heli setFuel 1;
_heli engineOn true;
_heli lock 2;

_AIGroup addVehicle _heli;


// Spawn the AI paratroopers
_units = [];
_paratrooperCount = 0;
_crewCount =
{
    _x params
    [
        "_unit",
        "_role",
        "_cargoIndex",
        "_turretPath",
        "_personTurret"
    ];

    switch (_role) do
    {
        case "driver":
        {
            _unit = [_AIGroup,_spawnPos,_class,_difficulty,_side,"Vehicle"] call DMS_fnc_SpawnAISoldier;
            _unit moveInDriver _heli;
            _unit setVariable ["DMS_AssignedVeh",_heli];
            _pilot = _unit;
        };

        case "commander";
        case "gunner";
        case "turret":
        {
            if (_ejectFFVGunners && {_personTurret}) then
            {
                _unit = [_AIGroup,_spawnPos,_class,_difficulty,_side,"Paratroopers"] call DMS_fnc_SpawnAISoldier;
                _paratrooperCount = _paratrooperCount + 1;
            }
            else
            {
            	_unit = [_AIGroup,_spawnPos,_class,_difficulty,_side,"Vehicle"] call DMS_fnc_SpawnAISoldier;
            	_unit setVariable ["DMS_AssignedVeh",_heli];
            };
        	_unit moveInTurret [_heli, _x];
        };

        case "cargo":
        {
            _unit = [_AIGroup,_spawnPos,_class,_difficulty,_side,"Paratroopers"] call DMS_fnc_SpawnAISoldier;
            _unit moveInCargo [_heli, _cargoIndex];
            _paratrooperCount = _paratrooperCount + 1;
        };
    };
    _units pushBack _unit;

    true
} count (fullCrew [_heli, "", true]);


// Set the heli pilot's behavior.
_pilot setDestination [_dropPoint, "VEHICLE PLANNED", true];
_heli flyInHeight DMS_RHeli_Height;


_units joinSilent _AIGroup;

// Reset ownership if needed.
if !(isNil "_groupOwner") then
{
    _AIGroup setGroupOwner _groupOwner;
};

if (DMS_DEBUG) then
{
	(format ["SpawnHeliReinforcement :: Created a %1 heli (%2) with %3 crew members at %4 with %5 difficulty to group %6, going to %7. Units: %8",_side,_heliClass,_crewCount+1,_spawnPos,_difficulty,_AIGroup,_dropPoint,_units]) call DMS_fnc_DebugLog;
};

// Add the necessary information to the monitor.
DMS_HeliParatrooper_Arr pushBack [_heli, _dropPoint, _ejectFFVGunners, _remainAsGunship];
