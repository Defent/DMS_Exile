/*
	DMS_AILocalityManager
	Created by Defent and eraser1

	Offloads AI groups to a nearby client in order to improve server performance.
*/


if !(DMS_ai_offload_to_client) exitWith {};

{
	// Exile already has a group cleanup system, so we'll leave empty groups for it
	if ((count (units _x))>1) then
	{
		private ["_leader", "_group", "_owner"];
		_leader = leader _x;
		_group = _x;
		if ((!isNull _leader) && {(alive _leader) && {!isPlayer _leader}}) then
		{
			if (isNull DMS_HC_Object) then
			{
				_owner = objNull;

				{
					if ((groupOwner _group) isEqualTo (owner _x)) exitWith
					{
						_owner = _x;
					};

					false;
				} count allPlayers;

				if ((isNull _owner) || {(_owner distance2D _leader)>3500}) then
				{
					[_group,_leader] call DMS_SetAILocality;
				};
			}
			else
			{
				if (DMS_DEBUG) then
				{
					diag_log format ["Setting ownership of group %1 to HC (%2)",_group,DMS_HC_Object];
				};
				_group setGroupOwner (owner DMS_HC_Object);
			};
		};
	};
	false;
} count allGroups;