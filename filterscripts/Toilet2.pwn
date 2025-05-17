// Toilet Version 2 by Teddy
// put in filterscript amx and pwn
//server.cfg / FILTERSCRIPT put Toilet2 and restarted your server

#include <a_samp>
#include <time>
#include <dini>
#include <sscanf>

    #define SPECIAL_ACTION_PISSING 68
    #define HOLDING(%0) \
    ((newkeys & (%0)) == (%0))
    #define RELEASED(%0) \
    (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
    #define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
    #define PRESSED(%0) \
        (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
    #define IsPlayerNotInVehicle(%0) (!IsPlayerInAnyVehicle(%0))
    #define HOLDING(%0) \
        ((newkeys & (%0)) == (%0))
    #define RELEASED(%0) \
            (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
            
#define color_red                         "{F81414}"
#define color_orange                      "{FFAF00}"
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define PTP PlayerToPoint

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

new dus1;
new dus2;
new dus3;
new dus4;
new robinet1;
new robinet2;
new robinet3;
new robinet4;

public OnFilterScriptInit()
{
	new toilet = CreateObject(5846, 1408.59, -1406.66, 27.79,   0.00, 0.00, 359.62);
	SetObjectMaterialText(toilet, "{FFFFFF}Luxury Toilet", 0, OBJECT_MATERIAL_SIZE_256x128, "Georgia", 40, 1, 0, -65536, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);// reclama Toilet
	
	Create3DTextLabel(""color_red"Type in\n"color_orange"/shit\n/pee", COLOR_RED ,1287.9169, -1290.3759, 13.1246,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/shit\n/pee", COLOR_RED ,1429.1001,-1385.9902,13.8659,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/shit\n/pee", COLOR_RED ,1429.0323,-1387.7594,13.8659,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/shit\n/pee", COLOR_RED ,1428.9944,-1389.3594,13.8659,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/shit\n/pee", COLOR_RED ,1428.8752,-1390.9568,13.8659,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/shit\n/pee", COLOR_RED ,1428.8806,-1392.5747,13.8659,10.0,0); //

	Create3DTextLabel(""color_red"Type in\n"color_orange"/shower1", COLOR_RED ,1408.3599,-1386.2754,13.8659,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/shower2", COLOR_RED ,1410.7758,-1386.1471,13.8659,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/shower3", COLOR_RED ,1413.3539,-1385.8761,13.8659,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/shower4", COLOR_RED ,1415.6661,-1386.0875,13.8659,10.0,0); //

	Create3DTextLabel(""color_red"Type in\n"color_orange"/hand1", COLOR_RED ,1419.3342,-1386.3184,13.8559,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/hand2", COLOR_RED ,1420.7073,-1386.3163,13.8559,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/hand3", COLOR_RED ,1421.9170,-1386.3160,13.8659,10.0,0); //
	Create3DTextLabel(""color_red"Type in\n"color_orange"/hand4", COLOR_RED ,1423.2135,-1386.3159,13.8659,10.0,0); //


	dus1 = CreateObject(18669, 1408.73, -1385.83, -12.75,   0.00, 0.00, 0.00);
	dus2 = CreateObject(18669, 1410.77, -1385.86, -12.75,   0.00, 0.00, 0.00);
	dus3 = CreateObject(18669, 1413.36, -1385.80, -12.75,   0.00, 0.00, 0.00);
	dus4 = CreateObject(18669, 1415.86, -1385.48, -12.75,   0.00, 0.00, 0.00);

	/*dus3 =CreateObject(18669, 1415.98, -1372.92, 20.71,   -178.00, -16.00, 0.00);
	dus4 =CreateObject(18669, 1418.56, -1373.10, 20.51,   -178.00, -16.00, 0.00);
	dus2 =CreateObject(18669, 1413.61, -1372.82, 20.82,   -178.00, -16.00, 0.00);
	dus1 =CreateObject(18669, 1411.02, -1372.81, 20.94,   -178.00, -16.00, 0.00);*/

	robinet1 = CreateObject(18705, 1419.39, -1381.42, 13.86,   90.00, 0.00, 0.00);
	robinet2 = CreateObject(18705, 1423.28, -1381.42, 13.86,   90.00, 0.00, 0.00);
	robinet3 = CreateObject(18705, 1428.62, -1381.43, 13.86,   90.00, 0.00, 0.00);
	robinet4 = CreateObject(18705, 1430.58, -1381.43, 13.86,   90.00, 0.00, 0.00);

///============== Wc in ssmp versiunea 2
	CreateObject(19445, 1416.72, -1405.31, 14.88,   0.00, 0.00, 88.08);
	CreateObject(19450, 1429.66, -1399.12, 14.83,   0.00, 0.00, 177.45);
	CreateObject(19381, 1425.51, -1400.32, 12.81,   0.00, 90.00, 88.07);
	CreateObject(19388, 1406.72, -1392.79, 14.84,   0.00, 0.00, 178.18);
	CreateObject(14570, 1408.17, -1384.48, 12.71,   0.00, 0.00, 176.23);
	CreateObject(19377, 1416.47, -1400.10, 12.79,   0.00, 90.00, 88.07);
	CreateObject(19378, 1425.80, -1390.01, 12.78,   0.00, 90.00, 88.07);
	CreateObject(19375, 1416.84, -1389.63, 12.77,   0.00, 90.00, 88.07);
	CreateObject(19450, 1416.73, -1405.40, 13.71,   0.00, 0.00, 87.57);
	CreateObject(19450, 1426.21, -1405.81, 13.71,   0.00, 0.00, 87.57);
	CreateObject(19445, 1426.32, -1405.71, 14.88,   0.00, 0.00, 87.57);
	CreateObject(19450, 1429.62, -1400.39, 13.71,   0.00, 0.00, 177.45);
	CreateObject(19450, 1430.07, -1389.57, 14.83,   0.00, 0.00, 177.45);
	CreateObject(19450, 1430.05, -1389.65, 13.71,   0.00, 0.00, 177.45);
	CreateObject(19375, 1411.60, -1386.10, 12.78,   0.00, 90.00, 89.07);
	CreateObject(19381, 1411.29, -1399.81, 12.75,   0.00, 90.00, 88.07);
	CreateObject(19358, 1406.43, -1403.41, 14.85,   0.00, 0.00, 179.19);
	CreateObject(19450, 1411.23, -1405.20, 13.71,   0.00, 0.00, 87.76);
	CreateObject(19445, 1411.32, -1405.07, 14.88,   0.00, 0.00, 87.57);
	CreateObject(19450, 1406.58, -1398.35, 13.84,   0.00, 0.00, 178.58);
	CreateObject(19450, 1406.59, -1398.39, 14.83,   0.00, 0.00, 178.68);
	CreateObject(19388, 1406.67, -1392.80, 14.40,   0.00, 0.00, 178.00);
	CreateObject(19377, 1405.10, -1385.50, 12.39,   0.00, 90.00, 88.07);
	CreateObject(19380, 1404.56, -1395.87, 12.39,   0.00, 90.00, 88.07);
	CreateObject(2561, 1412.29, -1388.16, 13.39,   0.00, 0.00, 359.60);
	CreateObject(19450, 1431.67, -1391.92, 13.56,   0.00, 0.00, 87.57);
	CreateObject(19450, 1431.64, -1393.43, 13.56,   0.00, 0.00, 87.57);
	CreateObject(19450, 1431.79, -1390.31, 13.56,   0.00, 0.00, 87.57);
	CreateObject(19450, 1431.94, -1388.69, 13.56,   0.00, 0.00, 87.57);
	CreateObject(19450, 1426.12, -1385.22, 13.56,   0.00, 0.00, 90.01);
	CreateObject(19450, 1416.58, -1385.24, 13.56,   0.00, 0.00, 90.01);
	CreateObject(19450, 1411.80, -1384.07, 13.56,   0.00, 0.00, 180.67);
	CreateObject(19450, 1416.75, -1384.09, 13.55,   0.00, 0.00, 180.67);
	CreateObject(19450, 1414.29, -1384.04, 13.56,   0.00, 0.00, 180.67);
	CreateObject(2523, 1418.85, -1385.91, 13.05,   0.00, 0.00, 0.00);
	CreateObject(19450, 1406.88, -1387.05, 14.85,   0.00, 0.00, 178.64);
	CreateObject(19450, 1406.83, -1386.70, 13.85,   0.00, 0.00, 179.25);
	CreateObject(2523, 1420.13, -1385.91, 13.05,   0.00, 0.00, 0.00);
	CreateObject(2523, 1421.37, -1385.91, 13.05,   0.00, 0.00, 0.00);
	CreateObject(2523, 1422.67, -1385.91, 13.05,   0.00, 0.00, 0.00);
	CreateObject(1523, 1427.07, -1393.24, 12.53,   0.00, 0.00, 87.20);
	CreateObject(2525, 1429.36, -1392.58, 12.87,   0.00, 0.00, 266.54);
	CreateObject(2525, 1429.36, -1390.93, 12.87,   0.00, 0.00, 266.54);
	CreateObject(1523, 1427.13, -1391.72, 12.53,   0.00, 0.00, 87.20);
	CreateObject(1523, 1427.21, -1390.08, 12.53,   0.00, 0.00, 86.38);
	CreateObject(19450, 1432.00, -1387.06, 13.56,   0.00, 0.00, 87.57);
	CreateObject(1523, 1427.32, -1388.48, 12.53,   0.00, 0.00, 86.38);
	CreateObject(1523, 1427.37, -1386.80, 12.53,   0.00, 0.00, 86.38);
	CreateObject(2525, 1429.48, -1389.36, 12.87,   0.00, 0.00, 266.54);
	CreateObject(2525, 1429.51, -1387.78, 12.87,   0.00, 0.00, 266.54);
	CreateObject(2525, 1429.60, -1385.92, 12.87,   0.00, 0.00, 266.54);
	CreateObject(2561, 1407.29, -1388.12, 13.39,   0.00, 0.00, 359.60);
	CreateObject(19450, 1409.28, -1384.20, 13.56,   0.00, 0.00, 180.67);
	CreateObject(14643, 1422.61, -1404.97, 13.02,   0.00, 0.00, 176.70);
	CreateObject(19381, 1409.01, -1389.30, 12.75,   0.00, 90.00, 86.94);
	CreateObject(19380, 1404.77, -1388.91, 12.52,   0.00, 90.00, 88.07);
	CreateObject(1491, 1406.66, -1393.58, 12.76,   0.00, 0.00, 88.44);
	CreateObject(14752, 1413.10, -1387.99, 14.07,   0.00, 0.00, 89.27);
	CreateObject(14752, 1415.55, -1388.01, 14.07,   0.00, 0.00, 89.27);
	CreateObject(14752, 1410.53, -1387.96, 14.07,   0.00, 0.00, 89.27);
	CreateObject(14752, 1408.11, -1388.00, 14.08,   0.00, 0.00, 89.27);
	CreateObject(1778, 1416.96, -1385.60, 13.05,   0.00, 0.00, 84.76);
	CreateObject(1778, 1423.96, -1385.55, 13.05,   0.00, 0.00, 84.76);
	CreateObject(1709, 1417.60, -1402.25, 12.90,   0.00, 0.00, 164.52);
	CreateObject(1709, 1412.12, -1399.11, 12.90,   0.00, 0.00, 129.01);
	CreateObject(2403, 1416.07, -1399.73, 12.85,   0.00, 0.00, 192.70);
	CreateObject(2403, 1412.22, -1395.32, 12.85,   0.00, 0.00, 165.72);
	CreateObject(13644, 1418.59, -1395.10, 12.20,   0.00, 0.00, 179.86);
	CreateObject(13644, 1418.59, -1395.11, 12.41,   0.00, 0.00, 0.00);
	CreateObject(3515, 1419.55, -1404.53, 9.36,   -2.00, 26.00, 349.85);
	CreateObject(3515, 1428.37, -1401.85, 9.83,   -2.00, 30.00, 83.16);
	CreateObject(2782, 1418.42, -1395.22, 14.26,   18.00, 0.00, 269.06);
	CreateObject(2253, 1422.43, -1394.46, 13.65,   4.00, 0.00, 357.00);
	CreateObject(2251, 1418.28, -1395.30, 14.88,   4.00, 0.00, 357.00);
	CreateObject(2254, 1429.61, -1397.41, 15.54,   0.00, 0.00, 269.86);
	CreateObject(2256, 1429.48, -1399.96, 15.54,   0.00, 0.00, 269.86);
	CreateObject(2258, 1429.43, -1402.02, 15.54,   0.00, 0.00, 268.24);
	CreateObject(2267, 1429.70, -1395.23, 15.54,   0.00, 0.00, 268.24);
	CreateObject(2268, 1424.64, -1404.99, 15.54,   0.00, 0.00, 175.07);
	CreateObject(2270, 1422.56, -1404.94, 15.54,   0.00, 0.00, 175.07);
	CreateObject(2271, 1423.77, -1404.98, 15.54,   0.00, 0.00, 175.07);
	CreateObject(2273, 1420.23, -1404.80, 15.54,   0.00, 0.00, 175.07);
	CreateObject(2274, 1418.57, -1404.71, 15.54,   0.00, 0.00, 175.07);
	CreateObject(2274, 1425.86, -1405.10, 15.54,   0.00, 0.00, 175.07);
	CreateObject(2277, 1419.21, -1404.80, 15.54,   0.00, 0.00, 175.07);
	CreateObject(2280, 1421.47, -1404.88, 15.54,   0.00, 0.00, 175.07);
	CreateObject(2284, 1428.70, -1403.71, 15.54,   0.00, 0.00, 224.81);
	CreateObject(2285, 1428.00, -1404.33, 15.60,   0.00, 0.00, 222.69);
	CreateObject(2286, 1428.86, -1404.13, 15.07,   0.00, 0.00, 222.69);
	CreateObject(2286, 1427.86, -1405.02, 15.07,   0.00, 0.00, 220.21);
	CreateObject(2284, 1427.31, -1404.99, 15.54,   0.00, 0.00, 224.81);
	CreateObject(2256, 1428.83, -1404.10, 13.58,   0.00, 0.00, 221.32);
	CreateObject(2256, 1427.76, -1405.03, 13.57,   0.00, 0.00, 221.32);
	CreateObject(2270, 1428.92, -1403.40, 14.54,   1.00, 90.00, 221.23);
	CreateObject(2270, 1428.15, -1404.06, 14.54,   1.00, 90.00, 221.23);
	CreateObject(2270, 1427.39, -1404.70, 14.54,   1.00, 90.00, 221.23);
	CreateObject(2245, 1417.95, -1397.48, 13.66,   4.00, 0.00, 357.00);
	CreateObject(2249, 1421.35, -1394.60, 13.76,   4.00, 0.00, 3.61);
	CreateObject(2249, 1418.48, -1392.98, 13.76,   4.00, 0.00, 1.31);
	CreateObject(2249, 1416.16, -1395.15, 13.76,   4.00, 0.00, 96.21);
	CreateObject(2250, 1414.38, -1395.09, 13.76,   4.00, 0.00, 96.21);
	CreateObject(2250, 1415.33, -1395.85, 13.56,   4.00, 0.00, 96.21);
	CreateObject(2250, 1422.64, -1395.50, 13.76,   4.00, 0.00, 96.21);
	CreateObject(2250, 1418.74, -1391.75, 13.76,   4.00, 0.00, 96.21);
	CreateObject(2253, 1418.04, -1392.34, 13.65,   4.00, 0.00, 357.00);
	CreateObject(2245, 1419.38, -1392.39, 13.66,   4.00, 0.00, 357.00);
	CreateObject(2253, 1415.15, -1394.42, 13.65,   4.00, 0.00, 357.00);
	CreateObject(2249, 1417.66, -1398.68, 13.76,   4.00, 0.00, 3.61);
	CreateObject(2250, 1419.40, -1397.20, 13.76,   4.00, 0.00, 96.21);
	CreateObject(2253, 1419.10, -1398.60, 13.65,   4.00, 0.00, 357.00);
	CreateObject(2245, 1415.25, -1395.88, 13.66,   4.00, 0.00, 357.00);
	CreateObject(2245, 1421.54, -1395.71, 13.66,   4.00, 0.00, 357.00);
	CreateObject(2741, 1418.91, -1385.34, 14.29,   0.00, 0.00, 0.00);
	CreateObject(2741, 1420.23, -1385.41, 14.29,   0.00, 0.00, 0.00);
	CreateObject(2741, 1421.44, -1385.44, 14.29,   0.00, 0.00, 0.00);
	CreateObject(2741, 1422.77, -1385.40, 14.29,   0.00, 0.00, 0.00);
	CreateObject(2714, 1406.49, -1392.79, 15.62,   0.00, 0.00, 267.76);
	CreateObject(14719, 1414.68, -1387.34, 13.89,   0.00, 0.00, 204.88);
	CreateObject(14719, 1412.18, -1387.41, 13.89,   0.00, 0.00, 204.88);
	CreateObject(14719, 1409.58, -1387.46, 13.89,   0.00, 0.00, 204.88);
	CreateObject(14719, 1407.54, -1387.43, 13.89,   0.00, 0.00, 204.88);
	CreateObject(1689, 1402.17, -1386.91, 12.79,   0.00, 0.00, 0.00);
	CreateObject(1689, 1399.76, -1386.89, 12.79,   0.00, 0.00, 0.00);
	CreateObject(1568, 1399.82, -1400.97, 12.07,   0.00, 0.00, 0.00);
	CreateObject(1568, 1406.22, -1400.72, 12.07,   0.00, 0.00, 0.00);
	CreateObject(1568, 1403.39, -1387.65, 12.07,   0.00, 0.00, 0.00);
	CreateObject(1568, 1396.22, -1387.20, 12.07,   0.00, 0.00, 0.00);
	CreateObject(1602, 1419.45, -1404.50, 14.86,   0.00, 0.00, 0.00);
	CreateObject(1602, 1424.66, -1405.25, 14.86,   0.00, 0.00, 0.00);
	CreateObject(1602, 1428.81, -1401.69, 14.86,   0.00, 0.00, 0.00);
	CreateObject(1602, 1429.03, -1395.97, 14.86,   0.00, 0.00, 0.00);
	CreateObject(1610, 1419.79, -1396.16, 14.03,   0.00, 0.00, 0.00);
	CreateObject(1610, 1417.31, -1394.18, 14.03,   0.00, 0.00, 0.00);
	CreateObject(19450, 1411.68, -1385.26, 13.56,   0.00, 0.00, 90.01);
	CreateObject(2245, 1407.36, -1395.61, 14.77,   4.00, 0.00, 357.00);
	CreateObject(2250, 1410.02, -1399.49, 14.78,   4.00, 0.00, 96.21);
	CreateObject(1610, 1408.17, -1397.93, 14.63,   0.00, 0.00, 0.00);
	CreateObject(2249, 1415.96, -1404.62, 14.99,   4.00, 0.00, 96.21);
	CreateObject(2253, 1412.37, -1402.65, 15.09,   4.00, 0.00, 357.00);
	CreateObject(2244, 1408.82, -1398.84, 13.96,   4.00, 0.00, 357.00);
	CreateObject(1610, 1413.99, -1403.62, 14.33,   0.00, 0.00, 359.80);
	CreateObject(2253, 1410.46, -1400.42, 14.16,   4.00, 0.00, 357.00);
	CreateObject(2250, 1412.55, -1402.62, 14.17,   4.00, 0.00, 96.21);
	CreateObject(2245, 1415.38, -1404.32, 14.07,   4.00, 0.00, 357.00);
	CreateObject(19313, 1423.69, -1430.85, 14.13,   0.00, 0.00, 0.00);
	CreateObject(19313, 1409.73, -1430.88, 14.13,   0.00, 0.00, 0.00);
	CreateObject(19313, 1402.83, -1423.93, 14.13,   0.00, 0.00, 89.15);
	CreateObject(19313, 1408.31, -1405.00, 12.40,   0.00, 0.00, 356.92);
	CreateObject(19380, 1404.56006, -1395.87000, 12.39000,   0.00000, 90.00000, 88.07000);
	CreateObject(19380, 1411.69971, -1389.35400, 16.48400,   900.00000, 90.00000, 88.57260);
	CreateObject(19380, 1421.03784, -1389.60779, 16.49600,   900.00000, 90.00000, 88.57260);
	CreateObject(19380, 1430.59717, -1390.14319, 16.52000,   900.00000, 90.00000, 88.57260);
	CreateObject(19380, 1420.86060, -1400.09729, 16.50800,   900.00000, 90.00000, 88.57260);
	CreateObject(19380, 1430.38879, -1400.61414, 16.50800,   900.00000, 90.00000, 88.57260);
	
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	new strings[256], pNName[MAX_PLAYER_NAME];
    new cmd[128], idx;
	cmd = strtok(cmdtext, idx);
//================ shower On ======================================
//CreateObject(18669, 1408.73, -1385.83, 12.75,   0.00, 0.00, 0.00);
//CreateObject(18669, 1410.77, -1385.86, 12.75,   0.00, 0.00, 0.00);
//CreateObject(18669, 1413.36, -1385.80, 12.75,   0.00, 0.00, 0.00);
//CreateObject(18669, 1415.86, -1385.48, 12.75,   0.00, 0.00, 0.00);

	if(strcmp(cmd, "/shower1", true) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1408.3599,-1386.2754,13.8659))
  		{
		   	MoveObject(dus1,1408.73, -1385.83, 12.75, 3.0);
            ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.0,1,0,0,0,0);
            GetPlayerName(playerid,pNName,MAX_PLAYER_NAME);
	        format(strings,sizeof strings,"{00FFEE}%s {FFFFFF}Do {F3FF02}shower {FFFFFF}to{F81414}Luxury Toilet!",pNName);// change the language
	        SendClientMessageToAll(0xFFFFFFAA,strings);
			SendClientMessage(playerid, COLOR_GREEN, "Expected to come water, to stop the water, writes /showeroff1");// change the language
		}
	   	return 1;
	}
	if(strcmp(cmd, "/shower2", true) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1410.7758,-1386.1471,13.8659))
  		{
		   	MoveObject(dus2,1410.77, -1385.86, 12.75, 3.0);
            ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.0,1,0,0,0,0);
            GetPlayerName(playerid,pNName,MAX_PLAYER_NAME);
	        format(strings,sizeof strings,"{00FFEE}%s {FFFFFF}Do {F3FF02}shower {FFFFFF}to {F81414}Luxury Toilet!",pNName);// change the language
	        SendClientMessageToAll(0xFFFFFFAA,strings);
			SendClientMessage(playerid, COLOR_GREEN, "Expected to come water, to stop the water, writes /showeroff2");// change the language
		}
	   	return 1;
	}
	if(strcmp(cmd, "/shower3", true) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1413.3539,-1385.8761,13.8659))
  		{
		   	MoveObject(dus3,1413.36, -1385.80, 12.75, 3.0);
            ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.0,1,0,0,0,0);
            GetPlayerName(playerid,pNName,MAX_PLAYER_NAME);
	        format(strings,sizeof strings,"{00FFEE}%s {FFFFFF}Do {F3FF02}shower {FFFFFF}to {F81414}Luxury Toilet!",pNName);// change the language
	        SendClientMessageToAll(0xFFFFFFAA,strings);
			SendClientMessage(playerid, COLOR_GREEN, "Expected to come water, to stop the water, writes /showeroff3");// change the language
		}
	   	return 1;
	}
	if(strcmp(cmd, "/shower4", true) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1415.6661,-1386.0875,13.8659))
  		{
		   	MoveObject(dus4,1415.86, -1385.48, 12.75, 3.0);
            ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.0,1,0,0,0,0);
            GetPlayerName(playerid,pNName,MAX_PLAYER_NAME);
	        format(strings,sizeof strings,"{00FFEE}%s {FFFFFF}Do {F3FF02}shower {FFFFFF}to {F81414}Luxury Toilet!",pNName);// change the language
	        SendClientMessageToAll(0xFFFFFFAA,strings);
			SendClientMessage(playerid, COLOR_GREEN, "Expected to come water, to stop the water, writes /showeroff4");// change the language
		}
	   	return 1;
	}
///==================================

//================ robinet ======================================
	if(strcmp(cmd, "/hand1", true) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1419.3342,-1386.3184,13.8559))
  		{
		   	MoveObject(robinet1,1419.39, -1384.09, 13.86, 3.0);
            SetTimerEx("robinet1close",20000,false,"d",playerid);
            ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
			SendClientMessage(playerid, COLOR_GREEN, "You can wash your hands, to stop water, writes /handoff1");// change the language
		}
	   	return 1;
	}
	if(strcmp(cmd, "/hand2", true) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1420.7073,-1386.3163,13.8559))
  		{
		   	MoveObject(robinet2,1420.66, -1384.09, 13.86, 3.0);
            SetTimerEx("robinet2close",20000,false,"d",playerid);
            ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
			SendClientMessage(playerid, COLOR_GREEN, "You can wash your hands, to stop water, writes /handoff2");// change the language
		}
	   	return 1;
	}
	if(strcmp(cmd, "/hand3", true) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1421.9170,-1386.3160,13.8659))
  		{
		   	MoveObject(robinet3,1421.91, -1384.09, 13.86, 3.0);
            SetTimerEx("robinet3close",20000,false,"d",playerid);
            ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
			SendClientMessage(playerid, COLOR_GREEN, "You can wash your hands, to stop water, writes /handoff3");// change the language
		}
	   	return 1;
	}
	if(strcmp(cmd, "/hand4", true) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1423.2135,-1386.3159,13.8659))
  		{
		   	MoveObject(robinet4,1423.19, -1384.06, 13.86, 3.0);
            SetTimerEx("robinet4close",20000,false,"d",playerid);
            ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
			SendClientMessage(playerid, COLOR_GREEN, "You can wash your hands, to stop water, writes /handoff4");// change the language
		}
	   	return 1;
	}
///==================================
    if(strcmp(cmd, "/shit", true) == 0)
    {
	    if (PlayerToPoint(3, playerid,1287.1453, -1289.3599, 12.3758) || PlayerToPoint(20,playerid,1423.2135,-1386.3159,13.8659))
  		{
	        GetPlayerName(playerid,pNName,MAX_PLAYER_NAME);
	        format(strings,sizeof strings,"{00FFEE}%s {FFFFFF}Do {F3FF02}shit {FFFFFF}to {F81414}Luxury Toilet!",pNName);// change the language
	        SendClientMessageToAll(0xFFFFFFAA,strings);
	        SendClientMessage(playerid, COLOR_GREEN, "Now you shit, Do not forget to flush the toilet, write /shitoff");// change the language
			ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);
		}
		return 1;
    }
 	if(strcmp(cmd, "/pee", true) == 0)
    {
		if (PlayerToPoint(3, playerid,1287.1453, -1289.3599, 12.3758) || PlayerToPoint(20,playerid,1423.2135,-1386.3159,13.8659))
		{
		     GetPlayerName(playerid,pNName,MAX_PLAYER_NAME);
		     format(strings,sizeof strings,"{00FFEE}%s {FFFFFF}Do {F3FF02}pee {FFFFFF}to {F81414}Luxury Toilet!",pNName);// change the language
		     SendClientMessageToAll(0xFFFFFFAA,strings);
		     SendClientMessage(playerid, COLOR_GREEN, "Now you pee, Do not forget to flush the toilet, write  /peeoff");// change the language
			 SetPlayerSpecialAction(playerid, 68);
	    }
		return 1;
    }
//======= shower OFF ===========================
    if(!strcmp(cmdtext, "/showeroff1", true))
    {
	    if(IsPlayerConnected(playerid))
	    {
            MoveObject(dus1, 1411.0220, -1372.8068, 20.9383, 1.5);
            SendClientMessage(playerid, COLOR_GREEN, "You close the water in the shower");// change the language
            ClearAnimations(playerid);
        }
		return 1;
    }
    if(!strcmp(cmdtext, "/showeroff2", true))
    {
	    if(IsPlayerConnected(playerid))
	    {
            MoveObject(dus2, 1413.6075, -1372.8165, 20.8234, 1.5);
            SendClientMessage(playerid, COLOR_GREEN, "You close the water in the shower");// change the language
            ClearAnimations(playerid);
        }
		return 1;
    }
    if(!strcmp(cmdtext, "/showeroff3", true))
    {
	    if(IsPlayerConnected(playerid))
	    {
            MoveObject(dus3, 1415.9817, -1372.9172, 20.7112, 1.5);
            SendClientMessage(playerid, COLOR_GREEN, "You close the water in the shower");// change the language
            ClearAnimations(playerid);
        }
		return 1;
    }
    if(!strcmp(cmdtext, "/showeroff4", true))
    {
	    if(IsPlayerConnected(playerid))
	    {
            MoveObject(dus4, 1418.5574, -1373.1001, 20.5139, 1.5);
            SendClientMessage(playerid, COLOR_GREEN, "You close the water in the shower");// change the language
            ClearAnimations(playerid);
        }
		return 1;
    }
//========== robinet off ==============================

    if(!strcmp(cmdtext, "/handoff1", true))
    {
	    if(IsPlayerConnected(playerid))
	    {
            MoveObject(robinet1, 1419.39, -1381.42, 13.86, 1.5);
            SendClientMessage(playerid, COLOR_GREEN, "You close the water");// change the language
            ClearAnimations(playerid);
        }
		return 1;
    }
    if(!strcmp(cmdtext, "/handoff2", true))
    {
	    if(IsPlayerConnected(playerid))
	    {
            MoveObject(robinet2, 1423.28, -1381.42, 13.86, 1.5);
            SendClientMessage(playerid, COLOR_GREEN, "You close the water");// change the language
            ClearAnimations(playerid);
        }
		return 1;
    }
    if(!strcmp(cmdtext, "/handoff3", true))
    {
	    if(IsPlayerConnected(playerid))
	    {
            MoveObject(robinet3, 1428.62, -1381.43, 13.86, 1.5);
            SendClientMessage(playerid, COLOR_GREEN, "You close the water");// change the language
            ClearAnimations(playerid);
        }
		return 1;
    }
    if(!strcmp(cmdtext, "/handoff4", true))
    {
	    if(IsPlayerConnected(playerid))
	    {
            MoveObject(robinet4, 1430.58, -1381.43, 13.86, 1.5);
            SendClientMessage(playerid, COLOR_GREEN, "You close the water");// change the language
            ClearAnimations(playerid);
        }
		return 1;
    }
//======== Toilet -- pee and shit -- OFF ===============
    if(!strcmp(cmdtext, "/peeoff", true))
    {
	    if(IsPlayerConnected(playerid))
	    {
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
            SendClientMessage(playerid, COLOR_GREEN, "Flushing of the toilet");// change the language
        }
        return 1;
    }
    if(!strcmp(cmdtext, "/shitoff", true))
    {
	    if(IsPlayerConnected(playerid))
	    {
            ClearAnimations(playerid);
            SendClientMessage(playerid, COLOR_GREEN, "Flushing of the toilet");// change the language
        }
        return 1;
    }
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
