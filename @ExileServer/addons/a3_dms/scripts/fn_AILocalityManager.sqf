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
		_groupOwner = groupOwner _group;
		if ((!isNull _leader) && {(alive _leader) && {!isPlayer _leader}}) then
		{
			if (isNull DMS_HC_Object) then
			{
				if (DMS_DEBUG) then
				{
					(format ["AILocalityManager :: DMS_HC_Object is null! Finding owner for group: %1",_group]) call DMS_fnc_DebugLog;
				};


				_owner = objNull;

				if !(local _group) then								// Only check for the group owner in players if it doesn't belong to the server.
				{
					{
						if (_groupOwner isEqualTo (owner _x)) exitWith
						{
							_owner = _x;
						};
					} forEach allPlayers;
				};

				if ((isNull _owner) || {(_owner distance2D _leader)>3500}) then
				{
					if !([_group,_leader] call DMS_fnc_SetAILocality) then
					{
						if !(local _group) then
						{
							_group setGroupOwner 2;

							if (DMS_DEBUG) then
							{
								(format ["AILocalityManager :: Current owner of group %1 is too far away and no other viable owner found; resetting ownership to the server.",_group]) call DMS_fnc_DebugLog;
							};
						};
					};
				};
			}
			else
			{
				if !(_groupOwner isEqualTo (owner DMS_HC_Object)) then
				{
					_transferSuccess = _group setGroupOwner (owner DMS_HC_Object);
					if (DMS_DEBUG) then
					{
						(format ["AILocalityManager :: Setting ownership of group %1 to HC (%2). Success: %3",_group,DMS_HC_Object,_transferSuccess]) call DMS_fnc_DebugLog;
					};
				};
			};
		};
	};
} forEach allGroups;