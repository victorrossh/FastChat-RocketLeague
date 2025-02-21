#include <amxmodx>
#include <amxmisc>
#include <chatmanager>
#include <cromchat2>

#define PLUGIN "Rocket League - Chat Rapido"
#define VERSION "1.5"
#define AUTHOR "WESPEOOTY && ftl~"

#define MENU_INFO 7
#define MENU_ELOGIOS 7
#define MENU_REACTION 7

#pragma semicolon 1
#define PREFIX_MENU "\r[FWO]"

new const quickSound[] = "fwo/pl/quickchat.wav";

new cvar_countdown, cvar_sequence_message, cvar_wait_restrict;
new g_iMessageCount[33];
new Float:g_fLastMessageTime[33];

new const trFormat[][30] = 
{
	"&x04%s &x07%s &x01: &x04%s",
	"&x07%s &x01: &x04%s",
	"&x04%s &x07%s &x01: %s",
	"&x07%s &x01: %s"
};

new const ctFormat[][30] = 
{
	"&x04%s &x06%s &x01: &x04%s",
	"&x06%s &x01: &x04%s",
	"&x04%s &x06%s &x01: %s",
	"&x06%s &x01: %s"
};

new const szMenuMessages[][30] =
{
	"gg!",
	"Foi divertido!",
	"Deixa comigo!",
	"Preciso de impulsão!",
	"Chute!",
	"Estou na defesa!",
	"Fake!",
	
	"Belo chute!",
	"Ótimo passe!",
	"Bem jogado!",
	"Obrigado!",
	"Nice bump!",
	"What a save!",
	"Nice block!",
	
	"$#@%!",
	"Sem problema!",
	"Meu Deus!",
	"Nãããoooo!",
	"Uau!",
	"Essa foi por pouco!",
	"Sinto muito!"
};

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR);
	
	cvar_countdown = register_cvar("pl_chat_countdown", "3.0");
	cvar_sequence_message = register_cvar("pl_sequence_message", "3");
	cvar_wait_restrict = register_cvar("pl_wait_restrict", "2.5");
		
	register_clcmd("radio1", "cmdInfo");
	register_clcmd("radio2", "cmdElogios");
	register_clcmd("radio3", "cmdReaction");
}

public plugin_precache()
{
	precache_sound(quickSound);
}

public client_putinserver(id)
{
	g_iMessageCount[id] = 0;
	g_fLastMessageTime[id] = 0.0;
}

public resetMessageCount(arg[])
{
	new id = arg[0];
	g_iMessageCount[id] = 0;
}

public cmdSayMessage(id, menu, item)
{
    new szName[32];
    get_user_name(id, szName, charsmax(szName));

    new xPrefixName[32];
    cm_get_user_prefix(id, xPrefixName, charsmax(xPrefixName));
    
    new arg[1];
    arg[0] = id;
    
    new Float:currentTime = get_gametime();
    new Float:timeCount = currentTime - g_fLastMessageTime[id];
    new Float:requiredTime = get_pcvar_float(cvar_countdown);
    new sequenceMessage = get_pcvar_num(cvar_sequence_message);
    
    new userTeam = get_user_team(id);
    if(userTeam > 0 && userTeam < 3)
    {
        if(g_iMessageCount[id] < sequenceMessage)
        {
            switch(get_user_flags(id) & (ADMIN_RESERVATION | ADMIN_USER))
            {
				case ADMIN_RESERVATION:
				{
					if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
				    	CC_SendMessage(0, userTeam == 1 ? trFormat[0] : ctFormat[0], xPrefixName, szName, szMenuMessages[item]);
					else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
						CC_SendMessage(0, userTeam == 1 ? trFormat[1] : ctFormat[1], szName, szMenuMessages[item]);
				    else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
						CC_SendMessage(0, userTeam == 1 ? trFormat[2] : ctFormat[2], xPrefixName, szName, szMenuMessages[item]);
				    else
					CC_SendMessage(0, userTeam == 1 ? trFormat[3] : ctFormat[3], szName, szMenuMessages[item]);
				}
				case ADMIN_USER:
					CC_SendMessage(0, userTeam == 1 ? trFormat[3] : ctFormat[3], szName, szMenuMessages[item]);
			}
			g_iMessageCount[id]++;
			if(!task_exists(id))
				set_task_ex(get_pcvar_float(cvar_wait_restrict), "resetMessageCount",id, arg, sizeof(arg), SetTask_Once);
			else
			{
				remove_task(id);
				set_task_ex(get_pcvar_float(cvar_wait_restrict), "resetMessageCount",id, arg, sizeof(arg), SetTask_Once);
			}
			client_cmd(0, "spk ^"%s^"", quickSound);
		}
		else
		{
		if(g_fLastMessageTime[id] == 0.0) 
				g_fLastMessageTime[id] = currentTime;
            
			timeCount = currentTime - g_fLastMessageTime[id];
			if(timeCount >= requiredTime) 
			{
				g_fLastMessageTime[id] = 0.0;
				g_iMessageCount[id] = 0;

				remove_task(id);
				cmdSayMessage(id, menu, item);
				return PLUGIN_HANDLED;
			} 

			remove_task(id);
			new Float:remainingTime = requiredTime - timeCount;     
			CC_SendMessage(id, "&x04[FWO] &x01Espere &x07%3.1f &x01segundos para enviar outro &x07Quick-Chat&x01.", remainingTime);
			client_cmd(id, "speak buttons/lightswitch2");
		}
	}
	else
	{
		CC_SendMessage(id, "&x04[FWO] &x01Você não pode enviar &x07Quick-Chat &x01estando de SPEC.");
		client_cmd(id, "speak buttons/button10");
	}
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

public cmdInfo(id)
{	
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wInformações", PREFIX_MENU);
	new menu = menu_create(szMenuTitle, "handInfo");

	for(new i = 0; i < MENU_INFO; i++)
	{
		formatex(szMenuTitle, charsmax(szMenuTitle), "%s", szMenuMessages[i]);
		menu_additem(menu, szMenuTitle, "");
	}

	menu_setprop(menu, MPROP_EXITNAME, "Sair");
	menu_display(id, menu, 0);

	return PLUGIN_HANDLED;
}

public handInfo(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu); 
		return  PLUGIN_HANDLED;
	}
	cmdSayMessage(id, menu, item);
	return PLUGIN_HANDLED;
}

public cmdElogios(id)
{
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wElogios", PREFIX_MENU);
	new menu = menu_create(szMenuTitle, "handElogios");

	for(new i = MENU_INFO; i < MENU_ELOGIOS + MENU_INFO; i++)
	{
		formatex(szMenuTitle, charsmax(szMenuTitle), "%s", szMenuMessages[i]);
		menu_additem(menu, szMenuTitle, "");
	}

	menu_setprop(menu, MPROP_EXITNAME, "Sair");
	menu_display(id, menu, 0);

	return PLUGIN_HANDLED;
}

public handElogios(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_HANDLED;
	}
	cmdSayMessage(id, menu, item + MENU_INFO);
	return PLUGIN_HANDLED;
}

public cmdReaction(id)
{
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wReações", PREFIX_MENU);
	new menu = menu_create(szMenuTitle, "handReaction");

	for(new i = MENU_ELOGIOS + MENU_INFO; i < MENU_REACTION + MENU_ELOGIOS + MENU_INFO; i++)
	{
		formatex(szMenuTitle, charsmax(szMenuTitle), "%s", szMenuMessages[i]);
		menu_additem(menu, szMenuTitle, "");
	}
    
	menu_setprop(menu, MPROP_EXITNAME, "Sair");
	menu_display(id, menu, 0);

	return PLUGIN_HANDLED;
}

public handReaction(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_HANDLED;
	}
	cmdSayMessage(id, menu, item + MENU_ELOGIOS + MENU_INFO);
	return PLUGIN_HANDLED;
}