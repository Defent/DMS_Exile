/*
	DMS Pre-init
	Written by eraser1 (trainwreckdayz.com)
*/

DMS_HC_Object = objNull;

DMS_CleanUpList	= [];

DMS_Version = "January 11 2015 (RC1)";


//Load main config
call compileFinal preprocessFileLineNumbers "\x\addons\dms\config.sqf";


//Load map-specific configs. Should make it easier for people with multiple servers/maps. One PBO to rule them all...
if (DMS_Use_Map_Config) then
{
	call compileFinal preprocessFileLineNumbers (format ["\x\addons\dms\map_configs\%1_config.sqf",toLower worldName]);
};

DMS_MagRange = DMS_MaximumMagCount - DMS_MinimumMagCount;

/*
	Original Functions from
	http://maca134.co.uk/portfolio/m3editor-arma-3-map-editor/

	Slightly modified by eraser1
*/

M3E_fnc_getCenter =
{
	private ['_objects', '_ax', '_ay', '_az', '_xs', '_xc', '_xz', '_ys', '_yc', '_yz', '_zs', '_zc', '_zz'];
	_objects = [_this, 0, [], [[]]] call BIS_fnc_param;
	_ax = [];
	_ay = [];
	_az = [];
	{
		private ['_position'];
		_position = getPosATL _x;
		_ax pushBack (_position select 0);
		_ay pushBack (_position select 1);
		_az pushBack (_position select 2);
	} foreach _objects;
	_xs = 0;
	_xc = {_xs = _xs + _x; true} count _ax;
	_xz = _xs / _xc;

	_ys = 0;
	_yc = {_ys = _ys + _x; true} count _ay;
	_yz = _ys / _yc;

	_zs = 0;
	_zc = {_zs = _zs + _x; true} count _az;
	_zz = _zs / _zc;

	[_xz, _yz, _zz]
};

M3E_fnc_subArr =
{
	private ['_a1', '_a2', '_a3'];
	_a1 = [_this, 0, [], [[]]] call BIS_fnc_param;
	_a2 = [_this, 1, [], [[]]] call BIS_fnc_param;
	if (count _a1 == 0 || {count _a2 == 0}) exitWith {[]};
	if (count _a1 != count _a2) exitWith {[]};
	_a3 = [];
	{
		_a3 pushBack ((_a1 select _foreachindex) - (_a2 select _foreachindex));
	} foreach _a1;
	_a3
};

DMS_fnc_setRelPositions =
{
	private ['_OK','_objects','_newCPos','_center'];

	_OK = params
	[
		["_objects", [], [[]]],
		["_newCPos", [], [[]],[3]]
	];

	if (!_OK) exitWith
	{
		diag_log format ["DMS ERROR :: Calling DMS_fnc_setRelPositions with invalid parameters: %1",_this];
	};


	_center = [_objects] call M3E_fnc_getCenter;
	{
		private ['_relpos','_objPos'];

		_relpos = (getPosATL _x) vectorDiff _center;
		_objPos = [_newCPos,_relpos] call DMS_fnc_CalcPos;

		_x setPosATL _objPos;
		//diag_log format ["Setting %1 at %2; %3 is the relpos from original center %4, reapplied to new center %5",typeOf _x,_objPos,_relpos,_center,_newCPos];
	} foreach _objects;
};

// Because I fucked up the name on first implementation and don't want to mess anybody up who didn't realize to change every occurence of "DMS_MaxSurfaceNormal" to "DMS_MinSurfaceNormal".
DMS_MaxSurfaceNormal = DMS_MinSurfaceNormal;

DMS_AttemptsUntilThrottle = DMS_AttemptsUntilThrottle + 1;


// Initialize mission variables...
call compileFinal preprocessFileLineNumbers "\x\addons\dms\missions\static_init.sqf";
call compileFinal preprocessFileLineNumbers "\x\addons\dms\missions\mission_init.sqf";
