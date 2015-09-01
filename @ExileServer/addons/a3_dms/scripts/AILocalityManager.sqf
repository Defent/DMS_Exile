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
		};
	};
	false;
} count allGroups;