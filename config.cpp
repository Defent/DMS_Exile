class CfgPatches {
	class A3_dms {
		units[] = {};
		weapons[] = {};
		a3_DMS_version = 1.0;
		requiredVersion = 1.36;
		requiredAddons[] = {};
	};
};
class CfgFunctions {
	class dms {
		class main {
			file = "\x\addons\dms";
			class start_dms {
				postInit = 1;
			};
		};
	};
};