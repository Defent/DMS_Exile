/*
	Custom configs for Namalsk.
	Created by Vishpala, slight adjustments by eraser1

	All of these configs exist in the main config. The configs below will simply override any config from the main config.
*/

DMS_findSafePosBlacklist append
[
	[[4866.21,7962.4],[5085.27,8157.23]],		// Sebjan Trader
	[[4890.65,6535.2],[5090.37,6714.44]],		// Object A2
	[[3908.65,8405.29],[4029.93,8542.39]]		// Object A1
];

// Namalsk is a pretty small island
DMS_WaterNearBlacklist				= 100;

// Namalsk is pretty flat
DMS_MinSurfaceNormal				= 0.85;

DMS_SpawnZoneNearBlacklist			= 500;
DMS_TraderZoneNearBlacklist			= 500;


// Making these configs below as strict as possible will help in reducing the number of attempts taken to find a valid position, and as a result, improve performance.

DMS_MinDistFromWestBorder			= 2000;	// There's at least 2km of ocean from the west edge to the first bit of land.
DMS_MinDistFromEastBorder			= 3500;	// There's over 3km of ocean from the east edge to the first bit of land.
DMS_MinDistFromSouthBorder			= 4500;	// There's about 4.8km of ocean from the south edge to the first bit of land.
DMS_MinDistFromNorthBorder			= 700;	// There's around 750m of ocean from the north edge to the first bit of land (including the island).
