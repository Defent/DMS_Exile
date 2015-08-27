// The content of the boxes.
private ["_type","_crate"];
	_type = _this select 0;
	_crate = _this select 1;

	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearItemCargoGlobal _crate;	

	switch (_type) do 
	{
		// Intermediate loot
		case 1: 
		{
			_crate addMagazineCargoGlobal ["Exile_Item_WoodWallKit",6];
			_crate addMagazineCargoGlobal ["Exile_Item_WoodWallHalfKit",2];
			_crate addMagazineCargoGlobal ["Exile_Item_DoorwayKit",1];
			_crate addMagazineCargoGlobal ["Exile_Item_PlasticBottleFreshWater",5];
			_crate addWeaponCargoGlobal ["Exile_Melee_Axe",2];
			_crate addMagazineCargoGlobal ["Exile_Item_BBQ_Sandwich",2];
			_crate addMagazineCargoGlobal ["Exile_Item_Beer",3];
			_crate addMagazineCargoGlobal ["Exile_Item_CamoTentKit",3];
			_crate addMagazineCargoGlobal ["Exile_Item_CampFireKit",5];
			_crate addMagazineCargoGlobal ["Exile_Item_InstaDoc",5];
			_crate addMagazineCargoGlobal ["Exile_Item__JunkMetal",2];
			_crate addMagazineCargoGlobal ["Exile_Item_SafeKit",1];			
			_crate addMagazineCargoGlobal ["Exile_Item_MetalBoard",2];
			_crate addMagazineCargoGlobal ["Exile_Item_DuctTape",2];
			_crate addMagazineCargoGlobal ["Exile_Item_ExtensionCord",2];
			_crate addMagazineCargoGlobal ["Exile_Item_PortableGeneratorkit",1];

		};
		// Much loot
		case 2:
		{
			_crate addMagazineCargoGlobal ["Exile_Item_WoodWallKit",5];
			_crate addMagazineCargoGlobal ["Exile_Item_WoodWallHalfKit",5];
			_crate addMagazineCargoGlobal ["Exile_Item_DoorwayKit",1];
			_crate addMagazineCargoGlobal ["Exile_Item_PlasticBottleFreshWater",5];
			_crate addWeaponCargoGlobal ["Exile_Melee_Axe",5];
			_crate addMagazineCargoGlobal ["Exile_Item_BBQ_Sandwich",5];
			_crate addMagazineCargoGlobal ["Exile_Item_Beer",5];
			_crate addMagazineCargoGlobal ["Exile_Item_CamoTentKit",5];
			_crate addMagazineCargoGlobal ["Exile_Item_CampFireKit",5];
			_crate addMagazineCargoGlobal ["Exile_Item_InstaDoc",5];
			_crate addMagazineCargoGlobal ["Exile_Item__JunkMetal",5];
			_crate addMagazineCargoGlobal ["Exile_Item_SafeKit",5];		
			_crate addMagazineCargoGlobal ["Exile_Item_MetalBoard",5];
			_crate addMagazineCargoGlobal ["Exile_Item_DuctTape",5];
			_crate addMagazineCargoGlobal ["Exile_Item_ExtensionCord",5];
			_crate addMagazineCargoGlobal ["Exile_Item_PortableGeneratorkit",5];

		};
		// add more cases if you want.
	};
		