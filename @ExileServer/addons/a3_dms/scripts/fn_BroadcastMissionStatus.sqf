/*
	DMS_fnc_BroadcastMissionStatus
	Created by eraser1

	Usage:	
	[
		_messageTitle,
		[
			_messageColor,
			_message
		]
	] call DMS_fnc_BroadcastMissionStatus;

	Returns nothing
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
	(format["BroadcastMissionStatus :: Notification types: |%1| for broadcasting mission status: %2",DMS_PlayerNotificationTypes,_message]) call DMS_fnc_DebugLog;
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
			[_x, [format ["%1: %2",toUpper _missionName,_message]], "-1"] call ExileServer_system_network_send_broadcast;
		};

		case "standardhintrequest":
		{
			[
				_x,
				[
					format
					[
						"<t color='%1' size='%2' font='%3'>%4</t><br/><t color='%5' size='%6' font='%7'>%8</t>",
						_titleColor,
						DMS_standardHint_Title_Size,
						DMS_standardHint_Title_Font,
						_missionName,
						DMS_standardHint_Message_Color,
						DMS_standardHint_Message_Size,
						DMS_standardHint_Message_Font,
						_message
					]
				],
				"-1"
			] call ExileServer_system_network_send_broadcast;
		};

		case "dynamictextrequest":
		{
			(format
			[
				"<t color='%1' size='%2' font='%3'>%4</t><br/><t color='%5' size='%6' font='%7'>%8</t>",
				_titleColor,
				DMS_dynamicText_Title_Size,
				DMS_dynamicText_Title_Font,
				_missionName,
				DMS_dynamicText_Message_Color,
				DMS_dynamicText_Message_Size,
				DMS_dynamicText_Message_Font,
				_message
			]) remoteExecCall ["DMS_CLIENT_fnc_spawnDynamicText", -2];
		};

		case "texttilesrequest":
		{
			(format
			[
				"<t color='%1' size='%2' font='%3' align='center'>%4</t><br/><t color='%5' size='%6' font='%7' align='center'>%8</t>",
				_titleColor,
				DMS_textTiles_Title_Size,
				DMS_textTiles_Title_Font,
				_missionName,
				DMS_textTiles_Message_Color,
				DMS_textTiles_Message_Size,
				DMS_textTiles_Message_Font,
				_message
			]) remoteExecCall ["DMS_CLIENT_fnc_spawnTextTiles", -2];
		};

		default { diag_log format ["DMS ERROR :: Unsupported Notification Type in DMS_PlayerNotificationTypes: %1 | Calling parameters: %2",_x,_this]; };
	};
} forEach DMS_PlayerNotificationTypes;