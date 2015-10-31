/*
	Custom configs for Panthera3 (Panthera).
	Sample by eraser1

	All of these configs exist in the main config. The configs below will simply override any config from the main config.
	Explanations to all of these configs also exist in the main config.
*/

DMS_findSafePosBlacklist =
[
	//Insert position blacklists here.
];

// Let missions spawn closer to water, since we aren't spoiled for choice with all of the steep terrain.
DMS_WaterNearBlacklist				= 200;

// Panthera is super hilly/mountain-y, so we allow a tolerance of up to a 30 degree slope.
DMS_MinSurfaceNormal = 0.85;



// Comment out the below configs if you want missions to be able to spawn on the islands surrounding the mainland.

DMS_MinDistFromWestBorder			= 1500;
DMS_MinDistFromEastBorder			= 1000;
DMS_MinDistFromSouthBorder			= 1500;
DMS_MinDistFromNorthBorder			= 2500;