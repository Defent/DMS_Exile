/*
	Custom configs for Tanoa.
	Created by eraser1

	All of these configs exist in the main config. The configs below will simply override any config from the main config.
	Explanations to all of these configs also exist in the main config.
*/


DMS_MinDistFromWestBorder			= 1300;
DMS_MinDistFromEastBorder			= 800;
DMS_MinDistFromSouthBorder			= 1500;
DMS_MinDistFromNorthBorder			= 1900;

// Plenty of slopes
DMS_MinSurfaceNormal				= 0.8;


DMS_StaticMissionsOnServerStart append
[
	"underwater_stash"
];
