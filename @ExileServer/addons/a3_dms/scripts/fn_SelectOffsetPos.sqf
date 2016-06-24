/*
	DMS_fnc_SelectOffsetPos
	Created by eraser1

	Usage:
	[
		_origin,					// OBJECT, or POSITION (2D or 3D): Center from which the offset position will be calculated.
		_distance,					// SCALAR: Distance from the origin (meters)
		_direction					// SCALAR: Direction from the origin (degrees)
	] call DMS_fnc_SelectOffsetPos;

	Returns a new position offset from the provided position with the provided distance and direction. Position provided is at ground level in AGL

	This function has been deprecated by the new functionality of the "getPos" command (https://community.bistudio.com/wiki/getPos). This function has been updated for efficiency and retained for compatibility.

*/

if !(params
[
	"_origin",
	"_dis",
	"_dir"
])
exitWith
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SelectOffsetPos with invalid parameters: %1",_this];
	[0,0,0]
};

/*
if ((count _origin) isEqualTo 2) then
{
	_origin set [2,0];
};
*/

//_origin vectorAdd [sin(_dir)*_dis,cos(_dir)*_dis,0] <-- Old code
_origin getPos [_dis,_dir]
