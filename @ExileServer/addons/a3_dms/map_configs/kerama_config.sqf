/*
	Custom configs for Kerama.
	Created by InsertCoins

	All of these configs exist in the main config. The configs below will simply override any config from the main config.
*/

// Kerama is a pretty small island
DMS_WaterNearBlacklist				= 100;

// Kerama is not super flat
DMS_MinSurfaceNormal				= 0.75;

DMS_SpawnZoneNearBlacklist			= 500;
DMS_TraderZoneNearBlacklist			= 500;


// Making these configs below as strict as possible will help in reducing the number of attempts taken to find a valid position, and as a result, improve performance.
// Distances set up to ignore the small islands and the military islands in the north

DMS_MinDistFromWestBorder			= 7500;	// There's at least 7.5km of ocean from the west edge to the first bit of land.
DMS_MinDistFromEastBorder			= 7300;	// There's over 7.3km of ocean from the east edge to the first bit of land.
DMS_MinDistFromSouthBorder			= 4800;	// There's about 4.8km of ocean from the south edge to the first bit of land.
DMS_MinDistFromNorthBorder			= 4600;	// There's around 4.6km of ocean from the north edge to the first bit of land (including the island).
