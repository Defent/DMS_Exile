/*
	DMS_fnc_BroadcastMissionStatus
	Created by eraser1

	https://github.com/Defent/DMS_Exile/wiki/DMS_fnc_BroadcastMissionStatus

	Usage:
	[
		_messageTitle,								// <string> The title of the message
		[
			_titleColor,							// <string> The color of the message (in hex colors)
			_message,								// <any>	The actual message. Usually a string.
			_status									// <string> (OPTIONAL) The mission status. eg "win" or "lose". Currently only used on Exile Toasts.
		]
	] call DMS_fnc_BroadcastMissionStatus;

	Returns nothing
*/

if !(params
[
	"_messageTitle",
	"_messageInfo"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_BroadcastMissionStatus with invalid parameters: %1",_this];
};

_messageInfo params
[
	"_titleColor",
	"_message"
];

if (DMS_DEBUG) then
{
	(format["BroadcastMissionStatus :: Notification types: |%1| for broadcasting mission status: %2",DMS_PlayerNotificationTypes,_message]) call DMS_fnc_DebugLog;
};

if !(_message isEqualType "") then
{
	_message = str _message;
};

private _status =
	if ((count _messageInfo)>2) then
	{
		_messageInfo select 2
	}
	else
	{
		"start"
	};

{
	switch (toLower _x) do
	{
		case "systemchatrequest":
		{
			format["%1: %2",toUpper _messageTitle,_message] remoteExecCall ["systemChat",-2];
		};

		case "exiletoasts":
		{
			private _toast_type =
				switch (_status) do
				{
					case "win": {"SuccessEmpty"};
					case "lose": {"ErrorEmpty"};
					default {"InfoEmpty"};		// case "start":
				};

			[
			    "toastRequest",
			    [
			        _toast_type,
			        [
			            format
			            [
			                "<t color='%1' size='%2' font='%3'>%4</t><br/><t color='%5' size='%6' font='%7'>%8</t>",
			                _titleColor,
			                DMS_ExileToasts_Title_Size,
			                DMS_ExileToasts_Title_Font,
			                _messageTitle,
			                DMS_ExileToasts_Message_Color,
			                DMS_ExileToasts_Message_Size,
			                DMS_ExileToasts_Message_Font,
			                _message
			            ]
			        ]
			    ]
			] call ExileServer_system_network_send_broadcast;
		};

		case "standardhintrequest":
		{
			format
			[
				"<t color='%1' size='%2' font='%3'>%4</t><br/><t color='%5' size='%6' font='%7'>%8</t>",
				_titleColor,
				DMS_standardHint_Title_Size,
				DMS_standardHint_Title_Font,
				_messageTitle,
				DMS_standardHint_Message_Color,
				DMS_standardHint_Message_Size,
				DMS_standardHint_Message_Font,
				_message
			] remoteExecCall ["DMS_CLIENT_fnc_hintSilent",-2];
		};

		case "dynamictextrequest":
		{
			(format
			[
				"<t color='%1' size='%2' font='%3'>%4</t><br/><t color='%5' size='%6' font='%7'>%8</t>",
				_titleColor,
				DMS_dynamicText_Title_Size,
				DMS_dynamicText_Title_Font,
				_messageTitle,
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
				_messageTitle,
				DMS_textTiles_Message_Color,
				DMS_textTiles_Message_Size,
				DMS_textTiles_Message_Font,
				_message
			]) remoteExecCall ["DMS_CLIENT_fnc_spawnTextTiles", -2];
		};

		default { diag_log format ["DMS ERROR :: Unsupported Notification Type in DMS_PlayerNotificationTypes: %1 | Calling parameters: %2",_x,_this]; };
	};
} forEach DMS_PlayerNotificationTypes;
