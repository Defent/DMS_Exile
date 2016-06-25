/*
	Custom configs for Bornholm.
	Sample by eraser1

	All of these configs exist in the main config. The configs below will simply override any config from the main config (although the majority of them are the same).
	Explanations to all of these configs also exist in the main config.
*/

// These configs are the default values from the main config. Just included here as an example.
DMS_PlayerNearBlacklist				= 2000;
DMS_SpawnZoneNearBlacklist			= 2500;
DMS_TraderZoneNearBlacklist			= 2500;
DMS_MissionNearBlacklist			= 2500;
DMS_WaterNearBlacklist				= 500;

// Bornholm seems to be fine with a greater minimum surfaceNormal.
DMS_MinSurfaceNormal				= 0.95;


// Making these configs below as strict as possible will help in reducing the number of attempts taken to find a valid position, and as a result, improve performance.

DMS_MinDistFromWestBorder			= 1000;	// About 1km of plain ocean to the west
DMS_MinDistFromEastBorder			= 4000;	// Just about 4km of ocean to the east
DMS_MinDistFromSouthBorder			= 1000;	// We get the proper landmass at about 1km from the south
DMS_MinDistFromNorthBorder			= 1500;	// Avoid getting missions at the northern "tip"
