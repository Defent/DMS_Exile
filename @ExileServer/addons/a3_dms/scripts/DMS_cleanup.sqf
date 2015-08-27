private ["_pos"];
_pos = _this select 0;
{
    _this enableSimulation false;
    _this removeAllMPEventHandlers "mpkilled";
    _this removeAllMPEventHandlers "mphit";
    _this removeAllMPEventHandlers "mprespawn";
    _this removeAllEventHandlers "FiredNear";
    _this removeAllEventHandlers "HandleDamage";
    _this removeAllEventHandlers "Killed";
    _this removeAllEventHandlers "Fired";
    _this removeAllEventHandlers "GetOut";
    _this removeAllEventHandlers "GetIn";
    _this removeAllEventHandlers "Local";
     //  clearVehicleInit _this;
    deleteVehicle _this;
    deleteGroup (group _this);
    _this = nil;
    deleteMarker "DMS_MainMarker";
    deleteMarker "DMS_MainDot";

 } forEach (_pos nearObjects 50);





