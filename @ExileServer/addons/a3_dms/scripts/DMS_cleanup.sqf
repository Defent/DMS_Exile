private ["_pos"];
_pos = _this select 0;
{
    _x enableSimulation false;
    _x removeAllMPEventHandlers "mpkilled";
    _x removeAllMPEventHandlers "mphit";
    _x removeAllMPEventHandlers "mprespawn";
    _x removeAllEventHandlers "FiredNear";
    _x removeAllEventHandlers "HandleDamage";
    _x removeAllEventHandlers "Killed";
    _x removeAllEventHandlers "Fired";
    _x removeAllEventHandlers "GetOut";
    _x removeAllEventHandlers "GetIn";
    _x removeAllEventHandlers "Local";
     //  clearVehicleInit _this;
    deleteVehicle _x;
    deleteGroup (group _x);
    _x = nil;
    deleteMarker "DMS_MainMarker";
    deleteMarker "DMS_MainDot";

 } forEach (_pos nearObjects 50);





