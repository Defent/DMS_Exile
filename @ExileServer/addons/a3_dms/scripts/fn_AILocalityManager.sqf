/*
	DMS_fnc_AILocalityManager
	Created by Defent and eraser1

	https://github.com/Defent/DMS_Exile/wiki/DMS_fnc_AILocalityManager

	Offloads AI groups to a nearby client in order to improve server performance.
*/

if (!DMS_ai_offload_to_client) exitWith {};

{
	if (((count (units _x))>1) && {!(_x getVariable ["DMS_LockLocality",false])} && {!(DMS_ai_offload_Only_DMS_AI && {!(_x getVariable ["DMS_SpawnedGroup",false])})}) then
	{
		private _leader = leader _x;
		private _group = _x;
		if !(isPlayer _leader) then
		{
			// Ignore Exile flyovers.
			if (((side _group) isEqualTo independent) && {(count (units _group)) isEqualTo 1}) exitWith {};

			if (DMS_DEBUG) then
			{
				(format ["AILocalityManager :: Finding owner for group: %1",_group]) call DMS_fnc_DebugLog;
			};

			private _groupOwner = groupOwner _group;
			private _ownerObj = objNull;
			private _isLocal = local _group;

			if !(_isLocal) then								// Only check for the group owner in players if it doesn't belong to the server.
			{
				{
					if (_groupOwner isEqualTo (owner _x)) exitWith
					{
						_ownerObj = _x;
					};
				} forEach allPlayers;
			};

			// If the owner doesn't exist or is too far away...				Attempt to set a new player owner, and if none are found...	and if the group doesn't belong to the server...
			if (((isNull _ownerObj) || {(_ownerObj distance2D _leader)>3500}) && {!([_group,_leader] call DMS_fnc_SetAILocality)} && {!_isLocal}) then
			{
				// Reset locality to the server
				_group setGroupOwner 2;

				if (DMS_DEBUG) then
				{
					(format ["AILocalityManager :: Current owner of group %1 is too far away and no other viable owner found; resetting ownership to the server.",_group]) call DMS_fnc_DebugLog;
				};
			};
		};
	};
} forEach allGroups;
