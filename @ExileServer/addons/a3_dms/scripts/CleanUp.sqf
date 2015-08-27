if (DMS_DEBUG) then
{
    diag_log ("DMS:: CLEANING UP: "+str _this);
};
if !((typeName _this) isEqualTo "ARRAY") then
{
    _this = [_this];
};
if ([_this,20] call DMS_isPlayerNearbyARRAY) exitWith       //<---TODO: Improve/Replace?
{
    [30, DMS_CleanUp, _this, false] call ExileServer_system_thread_addTask;
};
{
    _x enableSimulationGlobal false;
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
    deleteVehicle _x;
    false;
} count _this;