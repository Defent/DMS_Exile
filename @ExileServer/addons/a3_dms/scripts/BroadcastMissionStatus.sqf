if (DMS_DEBUG) then
{
	diag_log format["DMS :: Notification types: |%1| for broadcasting mission status: %2",DMS_PlayerNotificationTypes,_this];
};
{
	switch (_x) do
	{
		case "advancedHintRequest":{[_x, [_this]] call ExileServer_system_network_send_broadcast;};
		case "dynamicTextRequest":{[_x, [_this,0,DMS_dynamicText_Size,DMS_dynamicText_Color]] call ExileServer_system_network_send_broadcast;};
		case "standardHintRequest":{[_x, [_this]] call ExileServer_system_network_send_broadcast;};
		case "systemChatRequest":{[_x, [_this]] call ExileServer_system_network_send_broadcast;};
	};
	false;
} count DMS_PlayerNotificationTypes;