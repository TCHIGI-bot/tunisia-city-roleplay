/*===================================================================================================================================
===================================================================================================================================



														_____________    _____________
														||___________   | ____________|
														||              ||           ||
														||              ||           ||
														||___________   ||           ||
														||___________   ||           ||
														||              ||           ||
														||              ||           ||
														||___________   ||___________||
														||___________   ||____________|
														
														
										                     VIP SYSTEM Version 0.1

==============
updates:
=================
VIP ARMOR FOR LVL 3 AND 4
text fix connect
VIPLIST
VIP CMD command
vip help


==============
GOALS:
=============

=============
upcoming
==================
exprie vip status 80%
car colour
vip lounge
buy weapons from location
vip party
account info

COPYRIGHT CLAIM:
**Note This is an ongoing project, thus uploading this on an other website or editing it without my peremission would not be tolerated
especially on this stage, maybe when a more stable version gets released, you would be able to use it in more circumstances,




===================================================================================================================================
===================================================================================================================================*/
#include <a_samp>
#include <ZCMD>
#include <sscanf2>
#include <YSI\y_ini>

#define FILTERSCRIPT

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" E.O VIP system by Oussama Essamadi");
	print(" Version 0.1");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" E.O VIP system by Oussama Essamadi");
	print("----------------------------------\n");
}

#endif

//==========================================================================================================================
//DATA SAVING FILE
#define VIP_PATH "/EO_VIP/%s.ini"
VIPPath(playerid) {
	new
	    str[36],
	    pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(str, sizeof(str), VIP_PATH, pname);
	return str;
}
// VIP enum
enum E_VIP_DATA {
	VIPLevel,
	VIPAcc[12],
	VIPDate,
	bool:VIPLoggedIn
}
//DIALOG enum
enum {
	DIALOG_VIPHELP
}
//new
new VIPInfo[MAX_PLAYER_NAME][E_VIP_DATA];
new VIPRank[12];

//colors//
#define GREY 0xAFAFAFAA
#define GREEN 0x33AA33AA
#define RED 0xAA3333AA
#define YELLOW 0xFFFF00AA
#define WHITE 0xFFFFFFAA
#define BLUE 0x0000BBAA
#define LIGHTBLUE 0x33CCFFAA
#define ORANGE 0xFF9900AA

//Stock//
stock ErrorMessages(playerid, errorID)
{
	if(errorID == 1)  return SendClientMessage(playerid,RED,"ERROR: You are not a VIP");
	if(errorID == 2)  return SendClientMessage(playerid,RED,"ERROR: Player is not connected");
	if(errorID == 3)  return SendClientMessage(playerid,RED,"ERROR: You need to be VIP level 2 or above to use this command");
	if(errorID == 4)  return SendClientMessage(playerid,RED,"ERROR: You need to be VIP level 3 or above to use this command");
	if(errorID == 5)  return SendClientMessage(playerid,RED,"ERROR: You need to be VIP level 4 to use this command");
	return 1;
}



//============================================================================================================================


public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("EO VIP SYSTEM");
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	VIPInfo[playerid][VIPLoggedIn] = false;
	if(fexist(VIPPath(playerid))) {
	    INI_ParseFile(VIPPath(playerid), "LoadPlayerData_VIPData", .bExtra = true, .extra = playerid);
	    return 1;
	}
	else {
	    new name[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, name, sizeof(name));
	    new INI:File = INI_Open(VIPPath(playerid));
		INI_SetTag(File, "VIPData");
		INI_WriteString(File, "Name", name);
		INI_WriteString(File, "VIPAcc", "None");
		INI_WriteInt(File, "VIPLevel", 0);
		INI_WriteInt(File, "VIPDate", 0);
		INI_Close(File);
		VIPInfo[playerid][VIPLoggedIn] = false;
	}
	return 1;
}
forward LoadPlayerData_VIPData(playerid, name[], value[]);
public LoadPlayerData_VIPData(playerid, name[], value[])
{
    INI_String("VIPAcc", VIPInfo[playerid][VIPAcc], 12);
	INI_Int("VIPLevel", VIPInfo[playerid][VIPLevel]);
	INI_Int("VIPDate", VIPInfo[playerid][VIPDate]);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
    new str[129], pname[MAX_PLAYER_NAME];
   	GetPlayerName(playerid, pname, sizeof(pname));
    format(str, sizeof(str), "Welcome %s , your VIP level is %i || account type: %s ",pname, VIPInfo[playerid][VIPLevel], VIPInfo[playerid][VIPAcc]);
    SendClientMessage(playerid, YELLOW, str);
    if(VIPInfo[playerid][VIPLevel] > 0) {
    	VIPInfo[playerid][VIPLoggedIn] = true;
    	SendClientMessage(playerid, YELLOW, "[VIP]: use /vipcmds to display a usefull collection of VIP commands, for information help use /viphelp");
    }
	if(VIPInfo[playerid][VIPLevel] == 3){
	    SendClientMessage(playerid, YELLOW, "[VIP]: your armour has been set to 40%%");
	    SetPlayerArmour(playerid, 40);
	    return 1;
	}
	else if(VIPInfo[playerid][VIPLevel] == 4){
	    SendClientMessage(playerid, YELLOW, "[VIP]: your armour has been set to 100%%");
	    SetPlayerArmour(playerid, 100);
	    return 1;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}
//=====================================
//===========COMMANDS==================
//====================================
CMD:setvip(playerid, params[]) {
	if(IsPlayerAdmin(playerid)) {
	    new
	        str[129],
	        pgiven[MAX_PLAYER_NAME],
	        aname[MAX_PLAYER_NAME],
	        vlevel,
	        pgID;
	        
	    if(sscanf(params, "ii", pgID, vlevel)) return SendClientMessage(playerid, WHITE, "USAGE: /setvip (playerid) (VIP level 0-4)") &&
	    SendClientMessage(playerid, YELLOW, "Function: Will set the Account Type of the Specific Player (0-NormalAcc,1-Silver,2-Gold,3-Platinum,4-Diamond)");
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(pgID, pgiven, sizeof(pgiven));
		if(!IsPlayerConnected(pgID) || pgID == INVALID_PLAYER_ID) return ErrorMessages(playerid, 2);
		if(vlevel > 4|| vlevel < 0) return SendClientMessage(playerid, -1, "SYSTEM: Avalaible VIP levels are (1-4)");
		if(vlevel == VIPInfo[pgID][VIPLevel]) return SendClientMessage(playerid,RED,"ERROR: Player is already have this VIP Level!");
		new day, month, year;
		new date[64];
		getdate(day, month, year);
		format(date, sizeof(date), "%s VIP status was set in: %02d %02d %02d",pgiven, day, month, year);
		printf("Your VIP status was set in: %02d %02d %02d", day, month, year);
		VIPInfo[pgID][VIPLevel] = vlevel;
		VIPInfo[pgID][VIPAcc] = VIPRank;
	 	VIPInfo[playerid][VIPLoggedIn] = true;
		VIPInfo[pgID][VIPDate] = 1;
		//VIPTime = 2592000000;//2,592,000,000 = 30 day && 3600000 = 1 hour
		//ExpiresTimer[playerid] = SetTimer("VIPExpires", 5000, true);
		//SetPVarInt(pgID, "VIPTime", VIPTime);
        switch(VIPInfo[pgID][VIPLevel])
		{
			case 1: VIPRank = "Silver";
			case 2: VIPRank = "Gold";
			case 3: VIPRank = "Platinum";
			case 4: VIPRank = "Diamond";
		}
		if(vlevel > 0) {
				format(str ,sizeof(str),"Administrator %s has set your Account Type to: %s", aname, VIPRank);
				SendClientMessage(pgID, -1, str);
				format(str, sizeof(str), "You have set %s VIP level to %i | account type: %s",pgiven, vlevel, VIPRank);
				SendClientMessage(playerid, GREEN, str);
				SendClientMessage(pgID, GREEN, "VIP: Your VIP status is available for 30 days");
				SendClientMessage(pgID, YELLOW, "[VIP]: use /vipcmds to display a usefull collection of VIP commands, for information help use /viphelp");
				new INI:File = INI_Open(VIPPath(pgID));
				INI_SetTag(File, "VIPData");
				INI_WriteString(File, "Name", pgiven);
				INI_WriteString(File, "VIPAcc", VIPRank);
				INI_WriteInt(File, "VIPLevel", VIPInfo[pgID][VIPLevel]);
				INI_WriteInt(File, "VIPDate", VIPInfo[pgID][VIPDate]);
				INI_Close(File);
				printf("%s Has been set to VIP level %i by administrator %s || account type : %s", pgiven, vlevel, aname, VIPRank);
				return 1;
		}
		if(vlevel == 0) {
				format(str, sizeof(str),"Administrator %s has removed your VIP status!", aname);
				SendClientMessage(pgID, RED, str);
				format(str, sizeof(str), "You have removed %s's VIP status",pgiven, vlevel);
				SendClientMessage(playerid, GREEN, str);
				VIPInfo[pgID][VIPLevel] = 0;
    			new name[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, name, sizeof(name));
			    new INI:File = INI_Open(VIPPath(playerid));
				INI_SetTag(File, "VIPData");
				INI_WriteString(File, "Name", name);
				INI_WriteString(File, "VIPAcc", "None");
				INI_WriteInt(File, "VIPLevel", VIPInfo[pgID][VIPLevel]);
				INI_WriteInt(File, "VIPDate", 0);
				INI_Close(File);
				VIPInfo[playerid][VIPLoggedIn] = false;
				return 1;
		}
		new INI:File = INI_Open(VIPPath(pgID));
		INI_SetTag(File, "VIPData");
		INI_WriteString(File, "Name", pgiven);
		INI_WriteString(File, "VIPAcc", VIPRank);
		INI_WriteInt(File, "VIPLevel", VIPInfo[pgID][VIPLevel]);
		INI_WriteInt(File, "VIPDate", VIPInfo[pgID][VIPDate]);
		INI_Close(File);
		printf("%s Has been set to VIP level %i by administrator %s || account type : %s", pgiven, vlevel, aname, VIPRank);
		return 1;
	}
	else {
	    SendClientMessage(playerid, RED, "ERROR: you are not authorized to use this commad");
	    return 1;
	}
}

//===========//VIP chat//========================================
CMD:vc(playerid, params[]) {

	if(VIPInfo[playerid][VIPLevel] > 0) {
		new msg[100], str[128], pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname,sizeof( pname));
		if(sscanf(params,"s",msg)) return SendClientMessage(playerid,-1,"USAGE: /vc (message)") && SendClientMessage(playerid,YELLOW,"Function: Use the VIP Chat");
		format(str,sizeof(str),"[VIP CHAT]%s: %s", pname, msg);
		for(new i; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && VIPInfo[i][VIPLevel] > 0)
 		  	{
 			  	SendClientMessage(i,GREEN,str);
 		  	}
		}
	}
	else {
	    ErrorMessages(playerid, 1);
	}
	return 1;
}

//============//VIPS LIST//=======================================
CMD:vips(playerid, params[]) {
	new
	    str[250],
	    Count,
	    pname[MAX_PLAYER_NAME];
 	for(new i=0; i<MAX_PLAYERS; i++){
		if(IsPlayerConnected(i) && VIPInfo[i][VIPLevel] > 0) {
			GetPlayerName(i, pname, sizeof(pname));
   			Count++;
		}
 	}
	if(Count == 0) return SendClientMessage(playerid, ORANGE, "There are no VIPs online at the moment!");
 	SendClientMessage(playerid, YELLOW,"=======================|Connected VIPs|=======================");
	format(str, sizeof(str),"%s | VIP Level: %i",pname, VIPInfo[playerid][VIPLevel]);
	SendClientMessage(playerid, ORANGE, str);
	SendClientMessage(playerid, YELLOW,"==============================================================");
	return 1;
}
//=====================//VIP COMMANDS//============================================
CMD:vipcmds(playerid, params[]) {
	if(VIPInfo[playerid][VIPLevel] > 0) {
		if(VIPInfo[playerid][VIPLevel] == 1) {
			SendClientMessage(playerid, ORANGE, "||================================|| VIP LEVEL 1 COMMANDS [SILVER] ||=================================||");
            SendClientMessage(playerid, YELLOW, "/vipcmds - Display VIP level commands || /vc (message) - Use VIP chat || /vips - List of online VIPs");
            SendClientMessage(playerid, YELLOW, "/viphelp - Display usefull information about VIP level");
            SendClientMessage(playerid, ORANGE, "||===================================================================================================||");
			return 1;
		}
		else if(VIPInfo[playerid][VIPLevel] == 2) {
   			SendClientMessage(playerid, ORANGE, "||============================|| VIP LEVEL 2 COMMANDS [GOLD] ||====================================||");
            SendClientMessage(playerid, YELLOW, "/vipcmds - Display VIP level commands || /vc (message) - Use VIP chat || /vips - List of online VIPs");
            SendClientMessage(playerid, YELLOW, "/viphelp - Display usefull information about VIP level");
            SendClientMessage(playerid, ORANGE, "||===================================================================================================||");
            return 1;
		}
		else if(VIPInfo[playerid][VIPLevel] == 3) {
   			SendClientMessage(playerid, ORANGE, "||=====================|| VIP LEVEL 3 COMMANDS [PLATINUM ||===========================================||");
            SendClientMessage(playerid, YELLOW, "/vipcmds - Display VIP level commands || /vc (message) - Use VIP chat || /vips - List of online VIPs");
            SendClientMessage(playerid, YELLOW, "/viphelp - Display usefull information about VIP level");
            SendClientMessage(playerid, ORANGE, "||===================================================================================================||");
            return 1;
		}
		else if(VIPInfo[playerid][VIPLevel] == 4) {
   			SendClientMessage(playerid, ORANGE, "||====================================|| VIP LEVEL 4 COMMANDS [DIAMOND] ||=============================||");
            SendClientMessage(playerid, YELLOW, "/vipcmds - Display VIP level commands || /vc (message) - Use VIP chat || /vips - List of online VIPs");
            SendClientMessage(playerid, YELLOW, "/viphelp - Display usefull information about VIP level");
            SendClientMessage(playerid, ORANGE, "||====================================================================================================||");
            return 1;
		}
		return 1;
	}
	else {
	    ErrorMessages(playerid, 1);
	}
	return 1;
}
//==================//VIP HELP//===================================================
CMD:viphelp(playerid, params[]) {
	if(VIPInfo[playerid][VIPLevel] > 0) {
		if(VIPInfo[playerid][VIPLevel] == 1){
		    ShowPlayerDialog(playerid, DIALOG_VIPHELP, DIALOG_STYLE_MSGBOX, "SILVER VIP Help", "Features:\n\nComing soon.","Got it!","");
		    return 1;
		}
		else if(VIPInfo[playerid][VIPLevel] == 2){
		    ShowPlayerDialog(playerid, DIALOG_VIPHELP, DIALOG_STYLE_MSGBOX, "GOLD VIP Help", "Features:\n\nComing soon.","Got it!","");
		    return 1;
		}
		else if(VIPInfo[playerid][VIPLevel] == 3){
		    ShowPlayerDialog(playerid, DIALOG_VIPHELP, DIALOG_STYLE_MSGBOX, "PLATINUM VIP Help", "Features:\n\nSpawn with 40%% of armour.","Got it!","");
			return 1;
		}
		else if(VIPInfo[playerid][VIPLevel] == 4){
		    ShowPlayerDialog(playerid, DIALOG_VIPHELP, DIALOG_STYLE_MSGBOX, "DIAMOND VIP Help", "Features:\n\nSpawn with 100%% of armour.","Got it!","");
			return 1;
		}
		return 1;
	}
	else {
	    ErrorMessages(playerid, 1);
	}
	return 1;
}

//=================================================================================
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

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

