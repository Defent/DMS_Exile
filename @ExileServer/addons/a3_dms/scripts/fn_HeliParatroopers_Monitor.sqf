/*
    DMS_fnc_HeliParatroopers_Monitor
    Created by eraser1

    **********!!!!NOTE!!!!**********: THIS FUNCTION IS NOT FINAL, IT IS FOR TESTING PURPOSES ONLY! Changes are planned, and the function parameters will likely change.
    In addition, this function is not behaving as expected.

    Used in Exile's thread system.
    Every heli to be used as paratroopers has an index in "DMS_HeliParatrooper_Arr".
    Every index has the values:
    [
        _heli,                      // OBJECT: The heli that holds the units.
        _dropPoint,                 // ARRAY (POSITION2D or 3D): The position (or object) to which the troopers need to be dropped near.
        _ejectFFVGunners,           // BOOLEAN: Whether or not to eject Fire-From-Vehicle (FFV) gunners.
        _remainAsGunship            // BOOLEAN: Whether or not to keep the heli flying around as a gunship.
    ]

    This function also monitors "DMS_HelisToClean", which is a list that contains all helis to be deleted (after dropping paratroopers).
*/

{
    private _heli = _x;

    if (isNull _heli) then          // Remove from list if the heli got deleted in some other way.
    {
        DMS_HelisToClean deleteAt _forEachIndex;
    }
    else
    {                               // Then check to see if it's already destroyed somehow...
        if !(alive _heli) exitWith
        {
            deleteVehicle _heli;
            DMS_HelisToClean deleteAt _forEachIndex;
        };

                                    // Otherwise check if there's a player within 1km.
        if !([_heli, 1000] call DMS_fnc_IsPlayerNearby) then
        {
            {
                deleteVehicle _x;
            } forEach ((crew _heli) + [_heli]);

            DMS_HelisToClean deleteAt _forEachIndex;
        };
    };
} forEach DMS_HelisToClean;


if (DMS_HeliParatrooper_Arr isEqualTo []) exitWith {};

{
    if !(_x params
    [
        ["_heli", objNull, [objNull]],
        ["_dropPoint", 0, [[], objNull], [2,3]],
        ["_ejectFFVGunners", false, [false]],
        ["_remainAsGunship", false, [false]]
    ])
    exitWith
    {
        diag_log format["DMS ERROR :: Invalid index (%1) in DMS_HeliParatrooper_Arr: %2", _forEachIndex, DMS_HeliParatrooper_Arr deleteAt _forEachIndex];
    };

    if (isNull _heli) exitWith
    {
        diag_log format["DMS ERROR :: Null _heli in DMS_HeliParatrooper_Arr (index %1). Parameters: %2", _forEachIndex, DMS_HeliParatrooper_Arr deleteAt _forEachIndex];
    };

    if !(alive _heli) exitWith
    {
        if (DMS_DEBUG) then
        {
            format["HeliParatroopers_Monitor :: Heli died before it could reach drop point. Parameters: %1", DMS_HeliParatrooper_Arr deleteAt _forEachIndex] call DMS_fnc_DebugLog;
        };
    };

    if ((_heli distance2D _dropPoint)<200) then
    {
        private["_groupOwner","_AIGroup"];

        _AIGroup = group _heli;

        // Grab and lock locality to control AI if necessary.
        if !(local _AIGroup) then
        {
            _groupOwner = groupOwner _AIGroup;
            _AIGroup setVariable ["DMS_LockLocality", true];
            _AIGroup setGroupOwner 2;
        };

        {
            _x params
            [
                "_unit",
                "_role",
                "_cargoIndex",
                "_turretPath",
                "_personTurret"
            ];

            if ((alive _unit) && {(_role isEqualTo "cargo") || {_ejectFFVGunners && {_personTurret}}}) then
            {
/*
                moveOut _unit;
                private ["_parachute", "_dir"];
                _parachute = createVehicle ["Steerable_Parachute_F", (getPosATL _unit), [], 0, "CAN_COLLIDE"];
                _parachute setDir (getDir _unit);
                _parachute enableSimulationGlobal true;

                _unit moveInDriver _parachute;
*/
                _unit action ["Eject", _heli];
                _unit setDestination [_dropPoint, "LEADER DIRECT", true];

                _unit setVariable ["DMS_AISpawnPos", _dropPoint];
            };
        } forEach (fullCrew _heli);

        if (_remainAsGunship) then
        {
            [
                [driver _heli],
                _AIGroup,
                _dropPoint,
                "heli",
                "COMBAT"
            ] call DMS_fnc_SetGroupBehavior_Separate;

            if (DMS_DEBUG) then
            {
                format["HeliParatroopers_Monitor :: Ordering heli (%1) to defend drop point position %2", _heli, _dropPoint] call DMS_fnc_DebugLog;
            };
        }
        else
        {
            private _pilot = driver _heli;

            [_pilot] joinSilent (createGroup (side _pilot));

            _pilot setDestination [_dropPoint getPos [2 * worldSize, random 360], "VEHICLE PLANNED", true];
            {_pilot disableAI _x} forEach ["FSM", "AUTOCOMBAT", "CHECKVISIBLE", "TARGET", "AUTOTARGET"];

            DMS_HelisToClean pushBack _heli;

            if (DMS_DEBUG) then
            {
                format["HeliParatroopers_Monitor :: Ordering heli (%1) to fly away from drop point position %2", _heli, _dropPoint] call DMS_fnc_DebugLog;
            };
        };

        DMS_HeliParatrooper_Arr deleteAt _forEachIndex;


        // Revert and unlock locality if necessary.
        if !(isNil "_groupOwner") then
        {
            _AIGroup setGroupOwner _groupOwner;
            _AIGroup setVariable ["DMS_LockLocality", false];
        };
    }
    else
    {
        (driver _heli) setDestination [_dropPoint, "VEHICLE PLANNED", true];
        _heli flyInHeight DMS_RHeli_Height;
    };
} forEach DMS_HeliParatrooper_Arr;
