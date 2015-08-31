/*
private["_mark","_name","_loop"];
_loop = true;

diag_log format ["DMS :: Marker loop script started."];

while {_loop} do 
{
	uiSleep 25;
	if (!(getMarkerColor "DMS_MainMarker" = "")) then {


	deleteMarker "DMS_MainMarker";
	deleteMarker "DMS_MainDot";
	
	_mark = createMarker ["DMS_MainMarker", DMS_Cords];
	"DMS_MainMarker" setMarkerColor "ColorRed";
	"DMS_MainMarker" setMarkerShape "ELLIPSE";
	"DMS_MainMarker" setMarkerBrush "Grid";
	"DMS_MainMarker" setMarkerSize [150,150];

	_name = createMarker ["DMS_MainDot", DMS_Cords];
	"DMS_MainDot" setMarkerColor "ColorBlack";
	"DMS_MainDot" setMarkerType "mil_dot";
	"DMS_MainDot" setMarkerText DMS_MainName;

	};
};
*/