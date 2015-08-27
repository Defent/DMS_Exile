class CfgPatches {
	class A3_dms {
		units[] = {};
		weapons[] = {};
		a3_DMS_version = 1.0;
		requiredVersion = 1.36;
		requiredAddons[] = {"exile_client","exile_server_config"};
	};
};
class CfgFunctions {
	class dms {
		class main {
			file = "\x\addons\dms";
			class init_dms
			{
				preInit = 1;
			};
			class start_dms {
				postInit = 1;
			};
		};
	};
};