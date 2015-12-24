/*
	DMS_fnc_DebugLog
	Created by eraser1
	
	Usage:
	_anyValue call DMS_fnc_DebugLog;

	This function will write the passed parameter as well as server updtime and FPS to RPT.
	If you have infiSTAR's DLLs, then it will also utilize the "ARMA_LOG" dll to write debug info.
*/

_this = format ['%1 |::|::| (DMS_Version: "%4" | time: %2 | diag_tickTime: %5 | %3 FPS)',_this,time,diag_fps,DMS_Version,diag_tickTime];
"ARMA_LOG" callExtension format ["DMS_DEBUG:%1",_this];
diag_log format ["DMS_DEBUG :: %1",_this];

if (!isNil "MAR_fnc_log") then 			// mARMA logging
{
	[_this,"info"] call MAR_fnc_log;
};