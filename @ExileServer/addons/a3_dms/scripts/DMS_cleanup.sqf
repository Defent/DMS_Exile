private ["_pos","_crate"];
_pos = _this select 0;
_crate = _this select 1;
deleteMarker "DMS_MainMarker";
deleteMarker "DMS_MainDot";
uiSleep DMS_CleanUpTimer;
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
    deleteVehicle _crate;
    deleteGroup (group _x);
    _x = nil;

 } forEach (_pos nearObjects 80);

 diag_log "DMS :: Mission got cleaned up!";





