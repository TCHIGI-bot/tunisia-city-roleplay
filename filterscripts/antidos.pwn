// [FS] AntiDoS by Ildar
// ������ � 0.2
#include <a_samp>
// ����������
const   Menu:@INVALID_MENU = Menu:INVALID_MENU;
#undef  INVALID_MENU
#define INVALID_MENU @INVALID_MENU
#define MAX_MESSAGES 3000 // ������������ ���������� �����������!
// ���� ������
forward CheckPing (playerid);
#define DIALOG_PINGKICKER (1000)
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_GREY 0xAFAFAFAA
#define MAX_PING (250) // ������������ ���� 250 ! ����� ��������!)
#define PING_CHECK_TIME (6) // 6 seconds
#define MAX_PING_WARNINGS (3)
// ���� ������
new
	pl_PingWarnings [MAX_PLAYERS] = 0,
	pl_PingResults [MAX_PING_WARNINGS] = 0,
	pl_PingChecked [MAX_PLAYERS] = 0,
	pl_PingTimer [MAX_PLAYERS] = -1;
// New s
new antifakekill[MAX_PLAYERS];
new IsMessageSent[MAX_PLAYERS];
new interval = 3;// ��� ����� � �������� ���� �����, ������ �� ����
// Forwards
forward AntiFakeKill(playerid);
forward NetworkUpdate();
forward CheckPing(playerid);
forward ClearChat();
forward TimerFlood(playerid);
// =============== ���� PizDos Bot ===============
public OnFilterScriptInit()
{
    SetTimer("ClearChat", 1000000, true); // ������ ������� ����.
	print("\n-------------------------------------------");
	print("* AntiDoS by Ildar - ������� �������� *");
	print("-------------------------------------------\n");
	return 1;
}
public OnPlayerText(playerid, text[])
{
   if(IsMessageSent[playerid] == 1){
   SendClientMessage(playerid,COLOR_GREY, "��������� ����� ������ ��� � 3 �������");
   return 0;}
   else{
   IsMessageSent[playerid] = 1;
   SetTimerEx("TimerFlood",interval*1000,0,"d",playerid);}
   return 0;
}
// =============== ���� ������� ���� ===========
public ClearChat()
{
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"");
         SendClientMessageToAll(COLOR_WHITE,"��� ��� �������������� �������!");
         return 0;
}
public TimerFlood(playerid)
{
         IsMessageSent[playerid] = 0;
         return true;
}
// =============== ���� FakeKill ===============
public OnPlayerDeath(playerid, killerid, reason)
{
    antifakekill[playerid] ++;
    SetTimerEx("antifakekill", 1000,false,"i",playerid);
    return 1;
}
public AntiFakeKill(playerid)
{
    antifakekill[playerid] --;
    if(antifakekill[playerid] > 5)
    {
        SendClientMessage(playerid, 0xFF0000AA, "�� ���� ������� �� ���������� � FakeKill");
        Kick(playerid);
        print("[!] ��� ������������ FakeKill [!]");
    }
    return 1;
}
// ���� ������
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid )
	{
		case DIALOG_PINGKICKER:
		{
			SendClientMessage(playerid, -1, "�� ���� ������� �� ������� ����!");
			Kick (playerid);
		}
	}
	return 1;
}
// ���� �����
public OnPlayerExitedMenu(playerid)
{
    if(playerid == INVALID_PLAYER_ID) return Kick(playerid);
    print("[!] ��� ������������ Lager [!]");
    new Menu:current = GetPlayerMenu(playerid);
    if(GetPlayerMenu(playerid) == INVALID_MENU) return Kick(playerid);
    HideMenuForPlayer(current,playerid);
    return TogglePlayerControllable(playerid,true);
}
// ���� ��� ��������!
public NetworkUpdate()
{
	new stats[300], idx, pos, msgs;
	for(new i; i<MAX_PLAYERS; i++)
	{
       if(IsPlayerConnected(i))
       {
          idx = 0;
	      GetPlayerNetworkStats(i, stats, sizeof(stats));
	      pos = strfind(stats, "Messages received: ", false, 209);
	      msgs = strval(strtok(stats[pos+19], idx));
	      new OtherMessages[MAX_PLAYERS]; // New
	      new MessagesCount[MAX_PLAYERS]; // New
	      if(msgs - MessagesCount[i] - OtherMessages[i] > MAX_MESSAGES && msgs > 2000)
	      {
             print("[!] ���� ������������� ����� ��������! [!]");
             BanEx(i, "�� ���� �������� �� ���� ��������!");
          }
	      MessagesCount[i] = msgs;
	      OtherMessages[i] = 0;
       }
    }
}
stock strtok(const string[], &index)
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
// ���� ������
public CheckPing(playerid)
{
	new
		pl_Ping = GetPlayerPing (playerid);

	if( pl_Ping > MAX_PING )
	{
		new
			string [128];

		pl_PingWarnings [playerid] ++;
		pl_PingResults [ pl_PingChecked[playerid] ] = pl_Ping;

		format(string, sizeof(string), "��������� ���� ����������� � ���������� (Ping: %d)", pl_Ping );
		SendClientMessage(playerid, -1, string );
	}

	if( pl_PingChecked [playerid] >= MAX_PING_WARNINGS )
	{
		KillTimer (pl_PingTimer [playerid]);
	}

	if( pl_PingWarnings [playerid] >= MAX_PING_WARNINGS )
	{
		new
			string [128],
			dstring [256];

		format(string, sizeof(string), "��� ������� �� ������� ����! -\n\n� ��� ��� ����:\n");
		strcat(dstring, string);

		for( new i; i < MAX_PING_WARNINGS; i ++ )
		{
			format(string, sizeof(string), "* %d\n", pl_PingResults [i]);
			strcat(dstring, string);
		}

		ShowPlayerDialog(playerid, DIALOG_PINGKICKER, DIALOG_STYLE_MSGBOX, "�� ��������� ������� ������� (����)", dstring, "OK", "");
		TogglePlayerControllable(playerid, false);
	}

	pl_PingChecked [playerid] ++;
	return 1;
}
public OnPlayerConnect (playerid)
{
    IsMessageSent[playerid] = 0;
	pl_PingTimer [playerid] = SetTimerEx ( "CheckPing", PING_CHECK_TIME * 1000, true, "i", playerid );
	return 1;
}
