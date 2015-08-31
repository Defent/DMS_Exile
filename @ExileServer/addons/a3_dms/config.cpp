class CfgPatches {
	class A3_dms {
		units[] = {};
		weapons[] = {};
		a3_DMS_version = 2.0;
		requiredVersion = 1.36;
		requiredAddons[] = {"exile_client","exile_server_config"};
	};
};
class CfgFunctions {
	class dms {
		class main {
			file = "\x\addons\dms";
			class DMS_preInit
			{
				preInit = 1;
			};
			class DMS_postInit {
				postInit = 1;
			};
		};
	};
};
