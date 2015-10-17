/*
	DMS_fnc_SpawnPersistentVehicle
	Created by eraser1

	Usage:
	[
		_vehicleClass,			// STRING: Vehicle classname to spawn.
		_pos,					// ARRAY (positionATL or position2d): Where the vehicle will be spawned (strict)
		_pinCode				// STRING or NUMBER: String has to be 4 digits. Number has to be between 0-9999, and will be automatically formatted.
		_spawnATL				// (OPTIONAL) BOOLEAN: Whether or not to spawn the vehicle ATL (Above Terrain Level) or ASL (Above Sea Level). Default: true (ATL)
	] call DMS_fnc_SpawnPersistentVehicle;

	Returns the created vehicle object.
*/


private ["_vehicleClass", "_pos", "_pinCode", "_vehObj"];

_OK = params
[
	["_vehicleClass","",[""]],
	["_pos",[],[[]],[2,3]],
	["_pinCode","",[0,""]]
];

_vehObj = objNull;

try
{
	if (!_OK) then
	{
		throw (format ["invalid parameters: %1",_this]);
	};

	if !(isClass (configFile >> "CfgVehicles" >> _vehicleClass)) then
	{
		throw (format ["non-existent vehicle className: %1",_vehicleClass]);
	};


	if ((count _pos) isEqualTo 2) then
	{
		_pos set [2,0];
	};


	if ((typeName _pinCode)=="SCALAR") then
	{
		if (_pinCode<0 || {_pinCode>9999}) then
		{
			throw (format ["invalid SCALAR _pinCode value (must be between 0 and 9999): %1",_pinCode]);
		};

		switch (true) do
		{
			case (_pinCode<10):
			{
				_pinCode = format ["000%1",_pinCode];
			};

			case (_pinCode<100):
			{
				_pinCode = format ["00%1",_pinCode];
			};

			case (_pinCode<1000):
			{
				_pinCode = format ["0%1",_pinCode];
			};

			default
			{
				_pinCode = str _pinCode;
			};
		};
	};

	if ((count _pinCode)!=4) then
	{
		throw (format ["invalid STRING _pinCode value (must be 4 digits): %1",_pinCode]);
	};

	_spawnATL = if ((count _this)>3) then {_this select 3} else {true};

	// Create and set the vehicle
	_vehObj = [_vehicleClass,_pos] call DMS_fnc_SpawnNonPersistentVehicle;
	
	if (_spawnATL) then
	{
		_vehObj setPosATL _pos;
	}
	else
	{
		_vehObj setPosASL _pos;
	};

	// Save vehicle on exit.
	_vehObj addEventHandler ["GetOut", { _this call ExileServer_object_vehicle_event_onGetOut}];

	// Set up vars
	_vehObj setVariable ["ExileIsPersistent", true];
	_vehObj setVariable ["ExileAccessCode", _pinCode];
	_vehObj setVariable ["ExileOwnerUID", "76561198027700602"];		// That is my (eraser1's) PUID. Just so you don't think I'm trying to be sneaky...

	// Deny access until specified to do so.
	_vehObj setVariable ["ExileIsLocked",-1];
	_vehObj setVariable ["ExileLastLockToggleAt", time];
	_vehObj setVariable ["ExileAccessDenied", true];
	_vehObj setVariable ["ExileAccessDeniedExpiresAt", 999999];
	
	if (!isNil "AVS_Version") then
	{
		_vehObj call AVS_fnc_sanitizeVehicle;
	};
}
catch
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnPersistentVehicle with %1!",_exception];
};



_vehObj