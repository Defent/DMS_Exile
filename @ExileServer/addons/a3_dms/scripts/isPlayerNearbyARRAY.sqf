private["_posArray","_radius","_result"];
_posArray = _this select 0;
_radius = _this select 1;
_result = false;
{
	if (_result) exitWith {};
	_plyr = _x;
	if (alive _plyr) then
	{
		{
			if (_plyr distance _x <= _radius) exitWith
			{
				_result = true;
				if (DMS_DEBUG) then
				{
					diag_log format["DMS :: %1 is within %2m of %3!",_plyr,_radius,_x];
				};
			};
			false;
		} count _posArray;
	};
	false;
} count allPlayers;
_result