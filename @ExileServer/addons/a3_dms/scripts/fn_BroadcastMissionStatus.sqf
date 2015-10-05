/*
	DMS_fnc_BroadcastMissionStatus
	Created by eraser1

	Usage:	
	_message call DMS_fnc_BroadcastMissionStatus;

	Requires "DMS_PlayerNotificationTypes".

	Notification type "dynamicTextRequest" requires "DMS_dynamicText_Size" and "DMS_dynamicText_Color".
*/


private ["_missionName", "_messageInfo", "_titleColor", "_message"];

_OK = params
[
	["_missionName","",[""]],
	["_messageInfo",[],[[]],[2]]
];

if (!_OK) exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_BroadcastMissionStatus with invalid parameters: %1",_this];
};

_messageInfo params
[
	["_titleColor","#FFFF00",[""]],
	["_message","",[""]]
];

if (DMS_DEBUG) then
{
	diag_log format["DMS_DEBUG BroadcastMissionStatus :: Notification types: |%1| for broadcasting mission status: %2",DMS_PlayerNotificationTypes,_message];
};

if ((typeName _message) != "STRING") then
{
	_message = str _message;
};

{
	private "_args";

	switch (toLower _x) do
	{ 
		case "systemchatrequest":
		{
			[_x, [format ["%1: %2",toUpper _missionName,_message]]] call ExileServer_system_network_send_broadcast;
		};

		case "standardhintrequest":
		{
			[_x, [format ["<t color='%1' size='1.25'>%2</t><br/> %3",_titleColor,_missionName,_message]]] call ExileServer_system_network_send_broadcast;
		};

		case "dynamictextrequest":
		{
			(format
			[	
				'<t color="%1" size="1" >%2</t><br/><t color="%3" size="%4" >%5</t>',
				_titleColor,
				_missionName,
				DMS_dynamicText_Color,
				DMS_dynamicText_Size,_message
			])
			remoteExecCall ["DMS_CLIENT_fnc_spawnDynamicText", -2];
		};

		default { diag_log format ["DMS ERROR :: Unsupported Notification Type in DMS_PlayerNotificationTypes: %1 | Calling parameters: %2",_x,_this]; };
	};
} forEach DMS_PlayerNotificationTypes;