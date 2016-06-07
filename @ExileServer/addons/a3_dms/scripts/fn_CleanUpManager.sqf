/*
	DMS_fnc_CleanUpManager
	Created by eraser1

	Objects to be cleaned up together have an entry in "DMS_CleanUpList"
	The list is formatted as:
	[
		[
			_objectToClean1,
			_objectToClean2,
			...
			_objectToCleanN
		],
		_timeAddedToList,
		_timeUntilClean
	]

	A single object can also be used for (_this select 0)
*/

{
	if (DMS_DEBUG) then
	{
		(format ["CleanUpManager :: Checking Cleaning Status for: %1",_x]) call DMS_fnc_DebugLog;
	};


	if !(_x params
	[
		"_objs",
		"_timeAddedToList",
		"_timeUntilClean"
	])
	then
	{
		diag_log format ["DMS ERROR :: Invalid parameters for DMS_fnc_CleanUpManager: %1 replaced with %2",_x,[_objs,_timeAddedToList,_timeUntilClean]];
	};

	if ((diag_tickTime-_timeAddedToList)>=_timeUntilClean) then
	{
		_objs call DMS_fnc_CleanUp;
		DMS_CleanUpList deleteAt _forEachIndex;
	}
	else
	{
		if (DMS_DEBUG) then
		{
			(format ["CleanUpManager :: %1 is not yet ready to clean!",_x]) call DMS_fnc_DebugLog;
		};
	};
} forEach DMS_CleanUpList;
