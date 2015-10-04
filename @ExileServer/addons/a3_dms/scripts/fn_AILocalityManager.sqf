/*
	DMS_fnc_AILocalityManager
	Created by Defent and eraser1

	Offloads AI groups to a nearby client or HC in order to improve server performance.
*/


if (!DMS_ai_offload_to_client && {isNull DMS_HC_Object}) exitWith {};

{
	if (((count (units _x))>1) && {!((DMS_ai_offload_Only_DMS_AI && {!(_x getVariable ["DMS_SpawnedGroup",false])}) || {(_x getVariable ["DMS_LockLocality",false])})}) then
	{
		private ["_leader", "_group", "_owner"];
		_leader = leader _x;
		_group = _x;
		if ((!isNull _leader) && {(alive _leader) && {!isPlayer _leader}}) then
		{
			if (isNull DMS_HC_Object) then
			{
				if (DMS_DEBUG) then
				{
					diag_log format ["DMS_DEBUG AILocalityManager :: DMS_HC_Object is null! Finding owner for group: %1",_group];
				};
				_owner = objNull;

				{
					if ((groupOwner _group) isEqualTo (owner _x)) exitWith
					{
						_owner = _x;
					};
				} forEach allPlayers;

				if ((isNull _owner) || {(_owner distance2D _leader)>3500}) then
				{
					[_group,_leader] call DMS_fnc_SetAILocality;
				};
			}
			else
			{
				if !((groupOwner _group) isEqualTo (owner DMS_HC_Object)) then
				{
					_transferSuccess = _group setGroupOwner (owner DMS_HC_Object);
					if (DMS_DEBUG) then
					{
						diag_log format ["DMS_DEBUG AILocalityManager :: Setting ownership of group %1 to HC (%2). Success: %3",_group,DMS_HC_Object,_transferSuccess];
					};
				};
			};
		};
	};
} forEach allGroups;