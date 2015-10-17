/*
	DMS_fnc_DebugLog
	Created by eraser1
	
	Usage:
	_anyValue call DMS_fnc_DebugLog;

	This function will write the passed parameter as well as server updtime and FPS to RPT.
	If you have infiSTAR's DLLs, then it will also utilize the "ARMA_LOG" dll to write debug info.
*/

_this = format ["%1 |::|::| (UpTime: %2 | %3 FPS)",_this,time,diag_fps];
"ARMA_LOG" callExtension format ["DMS_DEBUG:%1",_this];
diag_log format ["DMS_DEBUG :: %1",_this];