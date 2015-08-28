/*
	DMS_BroadcastMissionStatus
	Created by eraser1

	Usage:	
	_message call DMS_BroadcastMissionStatus;

	Requires "DMS_PlayerNotificationTypes".

	Notification type "dynamicTextRequest" requires "DMS_dynamicText_Size" and "DMS_dynamicText_Color".
*/


if (DMS_DEBUG) then
{
	diag_log format["DMS_DEBUG BroadcastMissionStatus :: Notification types: |%1| for broadcasting mission status: %2",DMS_PlayerNotificationTypes,_this];
};

if !((typeName _this) isEqualTo "STRING") then {
	if (DMS_DEBUG) then
	{
		diag_log format["DMS_DEBUG BroadcastMissionStatus :: Converting %1 to string...",_this];
	};
	_this = str _this;
};
{
	private "_args";

	_args =															// Only include extra parameters if using "dynamicTextRequest"
	[
		[_x, [_this]],
		[_x, [_this,0,DMS_dynamicText_Size,DMS_dynamicText_Color]]
	] select (_x isEqualTo "dynamicTextRequest");

	_args call ExileServer_system_network_send_broadcast;
	false;
} count DMS_PlayerNotificationTypes;