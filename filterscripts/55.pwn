#define FILTERSCRIPT
//=============================== INCLUDE ======================================
#include 				 	<a_samp>
#include 				 	<zcmd>     		// Zeex
#include				 	<YSI\y_ini> 	// Y_Less
#include 					<YSI\y_timers>	// Y_Less
//================================ COLOR =======================================
#define COLOR_RED			0xAA3333AA
#define COLOR_GREEN			0x33FF33AA
#define COLOR_YELLOW		0xFFFF00AA
//============================== Function ======================================
#define PATH 			 "Lucky Draw/%s.ini"
enum pInfo
{
	pcoin,
}
new DataPlayer[MAX_PLAYERS][pInfo];
stock LDPath(playerid)
{
    new str[128],rname[MAX_PLAYER_NAME];
    GetPlayerName(playerid,rname,sizeof(rname));
    format(str,sizeof(str),PATH,rname);
    return str;
}
new DrawOn[MAX_PLAYERS];
new Drawing = -1;
//==============================================================================
stock sscanf(string[], format[], {Float,_}:...) // Y_Less
{
	#if defined isnull
		if (isnull(string))
	#else
		if (string[0] == 0 || (string[0] == 1 && string[1] == 0))
	#endif
		{
			return format[0];
		}
	#pragma tabsize 4
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while(string[stringPos] && string[stringPos] <= ' ')
	{
		stringPos++;
	}
	while(paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = string[++stringPos];
				}
				do
				{
					stringPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					num = 0,
					ch = string[stringPos];
				do
				{
					stringPos++;
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
						{
							return -1;
						}
					}
				}
				while((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{

				new changestr[16], changepos = 0, strpos = stringPos;
				while(changepos < 16 && string[strpos] && string[strpos] != delim)
				{
					changestr[changepos++] = string[strpos++];
    				}
				changestr[changepos] = '\0';
				setarg(paramPos,0,_:floatstr(changestr));
			}
			case 'p':
			{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
			{
				new
					end = formatPos - 1,
					ch;
				while((ch = format[++end]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(string, format[formatPos], false, stringPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = stringPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while((ch = string[++end]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos, 0, id);
				}
				else
				{
					#if !defined foreach
						#define foreach(%1,%2) for(new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					string[end] = '\0';
					num = false;
					new
						ssname[MAX_PLAYER_NAME];
					id = end - stringPos;
					foreach(new i : Player)
					{
						GetPlayerName(i, ssname, sizeof (ssname));
						if (!strcmp(ssname, string[stringPos], true, id))
						{
							setarg(paramPos, 0, i);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					string[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				stringPos = end;
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while((ch = string[stringPos++]) && ch != delim)
					{
						setarg(paramPos, i++, ch);
					}
					if (!i)
					{
						return -1;
					}
				}
				else
				{
					while((ch = string[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while(string[stringPos] && string[stringPos] != delim && string[stringPos] > ' ')
		{
			stringPos++;
		}
		while(string[stringPos] && (string[stringPos] == delim || string[stringPos] <= ' '))
		{
			stringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[formatPos++]) > ' ')
		{
			if (delim == '\'')
			{
				while((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while(delim > ' ');
	return 0;
}

stock FrandomEx(minnum = cellmin, maxnum = cellmax) return random(maxnum - minnum + 1) + minnum; // Y_Less
//======================---==== Automatic Timer ================================
timer CoinHour[300000](playerid)
{
	SendClientMessage(playerid, COLOR_GREEN, "LUCKY DRAW: You've got 1 Coins that can be used in /luckydraw");
	DataPlayer[playerid][pcoin] += 1;
	new INI:File = INI_Open(LDPath(playerid));
    INI_SetTag(File,"DataPlayer");
    INI_WriteInt(File,"Coins",DataPlayer[playerid][pcoin]);
    INI_Close(File);
}
//==============================================================================
#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
	print("++++++++++++++++++++$$$$$+++++++++++++++");
	print("           LUCKY DRAW - Kucin666        ");
	print("++++++++++++++++++++#####+++++++++++++++\n");
	return 1;
}
#endif

public OnFilterScriptExit()
{
	print("++++++++++++++++++++$$$$$+++++++++++++++");
	print("           LUCKY DRAW - Kucin666        ");
	print("++++++++++++++++++++#####+++++++++++++++\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
 	DrawOn[playerid] = 0;
    repeat CoinHour(playerid);
	if(fexist(LDPath(playerid)))
	{
		INI_ParseFile(LDPath(playerid), "LoadPlayer_%s", .bExtra = true, .extra = playerid);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
 	DrawOn[playerid] = 0;
 	new INI:File = INI_Open(LDPath(playerid));
    INI_SetTag(File,"DataPlayer");
    INI_WriteInt(File,"Coins",DataPlayer[playerid][pcoin]);
    INI_Close(File);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 1998)
	{
		if(response)
		{
  			switch(listitem)
	    	{
				case 0:
				{
					new string[128], CName[MAX_PLAYER_NAME];
					GetPlayerName(playerid, CName, MAX_PLAYER_NAME);
					format(string, sizeof(string), "Coin  :  %d\n\n", DataPlayer[playerid][pcoin]);
					ShowPlayerDialog(playerid, 2000,DIALOG_STYLE_MSGBOX,"My Coins", string, "Close","");
					return 1;
				}
				case 1:
				{
					if(DrawOn[playerid] == 1) return SendClientMessage(playerid,COLOR_RED,"You're draw, wait for it to finish to do it again.");
					if(DataPlayer[playerid][pcoin] <= 5) return SendClientMessage(playerid,COLOR_RED,"Sorry, your coins are not enough to Draw (Min: 5 Coin).");
					if(Drawing == -1)
					{
         				DrawOn[playerid] = 1;
					    Drawing = 6;
					    GameTextForPlayer(playerid,"~p~Drawing...",6000,3);
						defer drawing(playerid);
						defer RandomDraw(playerid);
					}
					return 1;
				}
	            case 2:
	            {
				    new string[1500];
					strcat(string, "You will get 1 Free Coins every hour.\n");
					strcat(string, "You can use Lucky Draw if you have 5 coins.\n\n");
					strcat(string, "Prizes In Lucky Draw:\n");
					strcat(string, "- Money $ 5,000		|	- Money $ 100,000\n");
					strcat(string, "- Money $ 10,000	|  	- Money $ 250,000\n");
					strcat(string, "- Money $ 25,000	|  	- Money $ 500,000\n");
					strcat(string, "- Money $ 50,000	|  	- Money $ 700,000\n");
					strcat(string, "- Money $ 75,000	|  	- Money $ 1000,000\n");
					strcat(string, "- ZONK\n\n");
					ShowPlayerDialog(playerid, 1999,DIALOG_STYLE_MSGBOX,"Lucky Draw Help", string, "Close","");
					return 1;
	            }
			}
		}
		return 1;
	}
	return 0;
}

timer RandomDraw[6000](playerid)
{
	new string[128];
	if(IsPlayerConnected(playerid))
	{
		new CName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, CName, MAX_PLAYER_NAME);
	    new randomdraw = FrandomEx(1,13); // Replace 13 to many randomdraw + else
		if(randomdraw == 1)		//1
		{
			DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
		    SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Sorry you're out of luck (ZONK)");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have gained ZONK", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
	    else if(randomdraw == 2)//2
	    {
         	DrawOn[playerid] = 0;
	    	DataPlayer[playerid][pcoin] -= 5;
	        GivePlayerMoney(playerid, 5000);
	        SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Congratulations you have earned a prize of $5,000");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have earned a prize of $5,000", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
		else if(randomdraw == 3)//3
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
			GivePlayerMoney(playerid, 10000);
	        SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Congratulations you have earned a prize of $10,000");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have earned a prize of $10,000", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
		else if(randomdraw == 4)//4
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
			GivePlayerMoney(playerid, 25000);
	        SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Congratulations you have earned a prize of $25,000");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have earned a prize of $25,000", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
		else if(randomdraw == 5)//5
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
			GivePlayerMoney(playerid, 50000);
	        SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Congratulations you have earned a prize of $50,000");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have earned a prize of $50,000", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
		else if(randomdraw == 6)//6
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
			GivePlayerMoney(playerid, 75000);
	        SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Congratulations you have earned a prize of $75,000");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have earned a prize of $75,000", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
		else if(randomdraw == 7)//7
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
		    SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Sorry you're out of luck (ZONK)");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have gained ZONK", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
		else if(randomdraw == 8)//8
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
			GivePlayerMoney(playerid, 100000);
	        SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Congratulations you have earned a prize of $100,000");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have earned a prize of $100,000", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
		else if(randomdraw == 9)//9
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
			GivePlayerMoney(playerid, 250000);
	        SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Congratulations you have earned a prize of $250,000");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have earned a prize of $250,000", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
		else if(randomdraw == 10)//10
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
			GivePlayerMoney(playerid, 500000);
	        SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Congratulations you have earned a prize of $500,000");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have earned a prize of $500,000", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
		else if(randomdraw == 11)//11
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
			GivePlayerMoney(playerid, 700000);
	        SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Congratulations you have earned a prize of $700,000");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have earned a prize of $700,000", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
		    return 1;
		}
		else if(randomdraw == 12)//12
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
			GivePlayerMoney(playerid, 1000000);
	        SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Congratulations you have earned a prize of $1,000,000");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have earned a prize of $1,000,000", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
		    return 1;
		}
		else					//13
		{
		 	DrawOn[playerid] = 0;
			DataPlayer[playerid][pcoin] -= 5;
		    SendClientMessage(playerid,COLOR_GREEN,"[LUCKY DRAW] Sorry you're out of luck (ZONK)");
	        format(string,sizeof(string),"[LUCKY DRAW] %s have gained ZONK", CName);
	        SendClientMessageToAll(COLOR_YELLOW,string);
		    return 1;
		}
	}
 	new INI:File = INI_Open(LDPath(playerid));
    INI_SetTag(File,"DataPlayer");
    INI_WriteInt(File,"Coins",DataPlayer[playerid][pcoin]);
    INI_Close(File);
	return 0;
}

timer drawing[1000](playerid)
{
	Drawing--;
	if(Drawing == 0)
	{
		Drawing = -1;
		GameTextForPlayer(playerid, "~g~Congratulations~ r~!",1000,3);
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		return 0;
	}
	defer drawing(playerid);
	return 0;
}
//================================ Commands ====================================
CMD:givecoin(playerid, params[])
{
	new amount, ID, TargetName[MAX_PLAYER_NAME], PlayerName[MAX_PLAYER_NAME], str[128];
	if(!IsPlayerAdmin(playerid))return SendClientMessage(playerid, -1, "ERROR: You need to be an admin to use this command!");
 	if(sscanf(params, "ui", ID, amount)) return SendClientMessage(playerid, -1, "USAGE: /givecoin [playerid] [amount]");
    if(amount < 1 || amount > 100) return SendClientMessage(playerid, -1, "ERROR: Invalid Coin amount. Number must be between 1 and 100.");
    if(!IsPlayerConnected(ID))return SendClientMessage(playerid,-1,"ERROR: Player is not connected.");
    {
        GetPlayerName(ID,TargetName,MAX_PLAYER_NAME);
        GetPlayerName(playerid,PlayerName, MAX_PLAYER_NAME);
		format(str, sizeof(str), "%s Has given you %d Coin", PlayerName, amount);
        SendClientMessage(ID, -1, str);
		format(str, sizeof(str), "You have given you %s %d Coin", TargetName, amount);
        SendClientMessage(playerid, -1, str);
		DataPlayer[ID][pcoin] += amount;
		new INI:File = INI_Open(LDPath(ID));
	    INI_SetTag(File,"DataPlayer");
	    INI_WriteInt(File,"Coins",DataPlayer[ID][pcoin]);
	    INI_Close(File);
	}
	return 1;
}

CMD:luckydraw(playerid, params[])
{
    ShowPlayerDialog(playerid, 1998, DIALOG_STYLE_LIST, "Menu Commands", "My Coins\nDraw\nHelp", "Select", "Close");
    return 1;
}