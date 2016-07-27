/*
	DMS_fnc_MissionParams
	Created by eraser1

	Takes input of any argument and converts it into a standard format for DMS missions.

	It will use provided mission position requirements (if they exist) and simply return a position that matches the requirements.

	If arguments provided do not have the mission position information, index 0 of the returned array will be an empty array.
	Any other passed values (other than empty array "[]") will be added to the end of the returned array.

	Usage:
	[
		_findSafePosParams,				// ARRAY: If a new mission position has to be generated, these values are passed to "DMS_fnc_FindSafePos" if the provided _missionPosition is improperly defined, or if it doesn't have to spawn at the provided position and that position is invalid.
		[
			_missionPosition,			// ARRAY (position ATL): Defines where the mission will spawn
			_forceSpawn					// (OPTIONAL) BOOL: Whether or not to force the mission to spawn at that location. Setting "_forceSpawn" to true means that the "DMS_fnc_IsValidPosition" check will be skipped, and the provided _missionPosition will be used regardless.
		],
		[
			_extraParam_1,				// (OPTIONAL) ANY: Extra parameter(s) that may be used by the mission.
			_extraParam_2,				// (OPTIONAL) ANY: Extra parameter(s) that may be used by the mission.
			...
			_extraParam_N				// (OPTIONAL) ANY: Extra parameter(s) that may be used by the mission.
		]
	] call DMS_fnc_MissionParams;

	or

	_extraParams call DMS_fnc_MissionParams;	// This will simply cause the function to use the default values for "DMS_fnc_FindSafePos" to generate a mission position. The "_extraParam" will be added to the back.

	NOTE: If you pass an array with more than 1 element as an argument, the array must be in the form of the first example or the example below, or else you may get unexpected results.
	If you want to pass some _extraParams as an array but spawn the mission at a random (valid) position, then call it as:
	[
		_findSafePosParams,
		[
			[],
		],
		_extraParams_ARRAY
	] call DMS_fnc_MissionParams;



	Returns an array in the form
	[
		_missionPos,
		_extraParams
	]
*/

private _missionPosition = [];

private _extraParams = [];

if (isNil "_this") then
{
	if (DMS_DEBUG) then
	{
		(format ["MissionParams :: Calling with nil parameter; Setting _missionPosition to generated position with default values."]) call DMS_fnc_DebugLog;
	};

	// Simply use generated position with default values.
	_missionPosition =
	[
		25,DMS_WaterNearBlacklist,DMS_MinSurfaceNormal,DMS_SpawnZoneNearBlacklist,DMS_TraderZoneNearBlacklist,DMS_MissionNearBlacklist,DMS_PlayerNearBlacklist,DMS_TerritoryNearBlacklist,DMS_ThrottleBlacklists
	] call DMS_fnc_FindSafePos;
}
else
{
	if ((_this isEqualType []) && {(count _this)>1}) then
	{
		if (params
		[
			["_findSafePosParams",[25,DMS_WaterNearBlacklist,DMS_MinSurfaceNormal,DMS_SpawnZoneNearBlacklist,DMS_TraderZoneNearBlacklist,DMS_MissionNearBlacklist,DMS_PlayerNearBlacklist,DMS_TerritoryNearBlacklist,DMS_ThrottleBlacklists],[[]]],
			["_posInfo",[],[[]],[1,2]]
		])
		then
		{
			_missionPosition = _posInfo select 0;
			private _forceSpawn = if ((count _posInfo)>1) then {_posInfo select 1} else {false};

			if (!(_missionPosition isEqualType []) || {(count _missionPosition)<2}) then
			{
				// Empty array means that you want to generate a mission position.
				if !(_missionPosition isEqualTo []) then
				{
					diag_log format ["DMS ERROR :: Calling MissionParams with invalid _missionPosition: %1 | Generating new one with _findSafePosParams: %2",_missionPosition,_findSafePosParams];
				};

				// Passed _missionPosition parameter is invalid, so we just find a position the regular way.
				_missionPosition = _findSafePosParams call DMS_fnc_FindSafePos;
			}
			else
			{
				// Make sure z-pos is defined.
				if ((count _missionPosition) isEqualTo 2) then
				{
					_missionPosition set [2,0];
				};

				if (!_forceSpawn && {!([_missionPosition,DMS_WaterNearBlacklist,DMS_MinSurfaceNormal,DMS_SpawnZoneNearBlacklist,DMS_TraderZoneNearBlacklist,DMS_MissionNearBlacklist,DMS_PlayerNearBlacklist,DMS_TerritoryNearBlacklist] call DMS_fnc_IsValidPosition)}) then
				{
					if (DMS_DEBUG) then
					{
						(format ["MissionParams :: Finding new position as provided non-mandatory _missionPosition (%1) is invalid. Finding new position.",_missionPosition]) call DMS_fnc_DebugLog;
					};
					// Passed _missionPosition parameter is not mandatory and doesn't meet requirements, so we just find a new position.
					_missionPosition = _findSafePosParams call DMS_fnc_FindSafePos;
				};
			};

			// Assign "_extraParams" if they exist.
			_extraParams = if ((count _this)>2) then {_this select 2} else {[]};
		}
		else
		{
			diag_log format ["DMS ERROR :: Calling MissionParams with invalid _findSafePosParams or _posInfo: %1 | Generating _missionPosition with _findSafePosParams params: %2. Setting _this as _extraParams: %3",_posInfo,_findSafePosParams,_this];

			_missionPosition = _findSafePosParams call DMS_fnc_FindSafePos;
			_extraParams = _this;
		};
	}
	else
	{
		_missionPosition =
		[
			5,DMS_WaterNearBlacklist,DMS_MinSurfaceNormal,DMS_SpawnZoneNearBlacklist,DMS_TraderZoneNearBlacklist,DMS_MissionNearBlacklist,DMS_PlayerNearBlacklist,DMS_TerritoryNearBlacklist,DMS_ThrottleBlacklists
		] call DMS_fnc_FindSafePos;

		_extraParams = _this;
	};
};

private _parsedParams =
[
	_missionPosition,
	_extraParams
];

if (DMS_DEBUG) then
{
	(format ["MissionParams :: Returning _parsedParams: %1 | Calling params: %2",_parsedParams,_this]) call DMS_fnc_DebugLog;
};

_parsedParams
