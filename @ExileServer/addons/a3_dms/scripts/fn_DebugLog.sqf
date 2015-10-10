/*
	DMS_fnc_DebugLog
	Created by eraser1
	
	Usage:
	_anyValue call DMS_fnc_DebugLog;

	If DMS_DEBUG is true, then it will write the passed parameter to RPT. If you have infistar, then it will also utilize the "ARMA_LOG" dll to write debug info.
*/

if (DMS_DEBUG) then
{
	_this = format ["%1 |::|::| (UpTime: %2 | %3 FPS)",_this,time,diag_fps];
	"ARMA_LOG" callExtension format ["DMS_DEBUG:%1",_this];
	diag_log format ["DMS_DEBUG :: %1",_this];
};