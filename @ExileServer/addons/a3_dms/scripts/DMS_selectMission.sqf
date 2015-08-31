
	private ["_sleepTime","_run","_countArray","_randomMiss","_missVar","_missionFnc","_MainArray"];

	_MainArray = ["MM1","MM2","MM3","MM4","MM5","MM6","MM7","MM8","MM9","MM10"];


	_sleepTime = (random (DMS_MisMaxTime - DMS_MisMinTime)) + DMS_MisMinTime;
	sleep _sleepTime;

	_countArray = count _MainArray;
	_slct = floor (random _countArray);
	_missVar = _MainArray select _slct;
	
	uiSleep 2;
	// Help from secret skype group. 
	call compile preprocessfilelinenumbers format["\x\addons\DMS\missions\%1.sqf",_missVar];

	

