/*
    DMS_fnc_SpawnHeliReinforcement
    Created by eraser1

    This function will create a heli/aircraft within "DMS_RHeli_MinDistFromDrop" to "DMS_RHeli_MaxDistFromDrop" meters and drop units at "_dropPoint".

    Usage:
    [
        _AIGroup,                       // GROUP: The group to which the heli will be assigned.
        _class,                         // STRING: The class of AI to spawn in the heli.
        _difficulty,                    // STRING: The difficulty of the AI to spawn in the heli.
        _side,                          // STRING: The "side" that the AI are on.
        _dropPoint,                     // OBJECT or ARRAY (Position2D or 3D): The location to drop the reinforcements at.
        _ejectFFVGunners,               // BOOLEAN: Whether or not to eject Fire-From-Vehicle (FFV) gunners.
        _maxJumpers,                    // SCALAR: Maximum number of AI to eject from the aircraft. Set to a really high # to ignore (like 999).
        _remainAsGunship,               // BOOLEAN: Whether or not to keep the heli flying around as a gunship.
        _heliClass,                     // STRING (OPTIONAL): The classname of the heli to spawn.
        _spawnPos                       // ARRAY (OPTIONAL - Position2D or 3D): The position for the heli to spawn at.
    ] call DMS_fnc_SpawnHeliReinforcement;

    Returns the index of the paratrooper info in "DMS_HeliParatrooper_Arr", -1 on error.
*/

if !(params
[
    "_AIGroup",
    "_class",
    "_difficulty",
    "_side",
    "_dropPoint",
    "_ejectFFVGunners",
    "_maxJumpers",
    "_remainAsGunship"
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

private _heliClass = param [8, selectRandom DMS_ReinforcementHelis, [""]];

// Make the AI group local to add passengers.
if !(local _AIGroup) then
{
    _groupOwner = groupOwner _AIGroup;
    _AIGroup setGroupOwner 2;
};

// Get the spawn position for the heli
private _spawnPos =
    if ((count _this)>9) then
    {
        _this param [9, [0,0,0], [[]], [2,3]]
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
                0,
                false
            ]
        ] call DMS_fnc_FindSafePos_InRange
    };
_spawnPos set [2,DMS_RHeli_Height];



// Spawn the heli
private _heli = createVehicle [_heliClass, _spawnPos, [], 0, "FLY"];
_heli setFuel 1;
_heli engineOn true;
_heli lock 2;

_AIGroup addVehicle _heli;


// Spawn the AI paratroopers
private _paratrooperCount = 0;
private _units = (fullCrew [_heli, "", true]) apply
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
            _unit setDestination [_dropPoint, "VEHICLE PLANNED", true];
        };

        case "commander";
        case "gunner";
        case "turret":
        {
            if (_ejectFFVGunners && {_personTurret} && {_paratrooperCount < _maxJumpers}) then
            {
                _unit = [_AIGroup,_spawnPos,_class,_difficulty,_side,"Paratroopers"] call DMS_fnc_SpawnAISoldier;

                _unit setVariable ["DMS_Paratrooper", true];
                _paratrooperCount = _paratrooperCount + 1;
            }
            else
            {
            	_unit = [_AIGroup,_spawnPos,_class,_difficulty,_side,"Vehicle"] call DMS_fnc_SpawnAISoldier;
            	_unit setVariable ["DMS_AssignedVeh",_heli];
            };

        	_unit moveInTurret [_heli, _turretPath];
        };

        case "cargo":
        {
            if (_paratrooperCount < _maxJumpers) then
            {
                _unit = [_AIGroup,_spawnPos,_class,_difficulty,_side,"Paratroopers"] call DMS_fnc_SpawnAISoldier;
                _unit moveInCargo [_heli, _cargoIndex];

                _unit setVariable ["DMS_Paratrooper", true];
                _paratrooperCount = _paratrooperCount + 1;
            };
        };
    };

    _unit
};


// Set the heli pilot's behavior.
_heli flyInHeight DMS_RHeli_Height;


_units joinSilent _AIGroup;

// Reset ownership if needed.
if !(isNil "_groupOwner") then
{
    _AIGroup setGroupOwner _groupOwner;
};

if (DMS_DEBUG) then
{
	(format ["SpawnHeliReinforcement :: Created a %1 heli (%2) with %3 crew members at %4 with %5 difficulty to group %6, going to %7. Units: %8",_side,_heliClass,count _units,_spawnPos,_difficulty,_AIGroup,_dropPoint,_units]) call DMS_fnc_DebugLog;
};

// Add the necessary information to the monitor.
DMS_HeliParatrooper_Arr pushBack [_heli, _dropPoint, _remainAsGunship];
