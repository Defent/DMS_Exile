/*
	Custom configs for Taviana.
	Sample by eraser1

	All of these configs exist in the main config. The configs below will simply override any config from the main config (although the majority of them are the same).
	Explanations to all of these configs also exist in the main config.
*/

DMS_findSafePosBlacklist append
[
	[[11375,16170],[14302,18600]],
	[[13300,14670],[14875,16170]]
];

// These configs are the default values from the main config. Just included here as an example.
DMS_PlayerNearBlacklist				= 2000;
DMS_SpawnZoneNearBlacklist			= 2500;
DMS_TraderZoneNearBlacklist			= 2500;
DMS_MissionNearBlacklist			= 2500;
DMS_WaterNearBlacklist				= 500;


// Making these configs below as strict as possible will help in reducing the number of attempts taken to find a valid position, and as a result, improve performance.

DMS_MinDistFromWestBorder			= 500;	// The western island is pretty close to the western border.
DMS_MinDistFromEastBorder			= 4500;	// About 4.5km of ocean from the eastern border to the edge of the main east island. Set to 6000 if you want to "cut off" most of the Taviana Zoo area.
DMS_MinDistFromSouthBorder			= 100;	// The western island almost touches the southern border so this one is tiny...
DMS_MinDistFromNorthBorder			= 3000;	// About 3km from the northern tip of the east island to the edge.
