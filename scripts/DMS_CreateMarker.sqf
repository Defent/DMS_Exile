
	private["_mark","_name"];
	DMS_Cords = _this select 0;
	DMS_MainName = _this select 1;

	_mark = createMarker ["DMS_MainMarker", DMS_Cords];
	"DMS_MainMarker" setMarkerColor "ColorRed";
	"DMS_MainMarker" setMarkerShape "ELLIPSE";
	"DMS_MainMarker" setMarkerBrush "Grid";
	"DMS_MainMarker" setMarkerSize [150,150];

	_name = createMarker ["DMS_MainDot", DMS_Cords];
	"DMS_MainDot" setMarkerColor "ColorBlack";
	"DMS_MainDot" setMarkerType "mil_dot";
	"DMS_MainDot" setMarkerText DMS_MainName;
