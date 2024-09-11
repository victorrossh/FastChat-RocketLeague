#include <amxmodx>
#include <chatmanager>
#include <cromchat2>

#define PLUGIN "Rocket League - Chat Rapido"
#define VERSION "1.4"
#define AUTHOR "WESPEOOTY && ftl"

#define MENU_INFO 7
#define MENU_ELOGIOS 7
#define MENU_REACTION 7

#define PREFIX_MENU "\r[FWO]"

new Float:g_fLastMessageTime[33];
new xCvarTime;

new const trFormat[][30] = 
{
	"&x04%s &x07%s &x01: &x04%s",
	"&x07%s &x01: &x04%s",
	"&x04%s &x07%s &x01: %s",
	"&x07%s &x01: %s"
}

new const ctFormat[][30] = 
{
	"&x04%s &x06%s &x01: &x04%s",
	"&x06%s &x01: &x04%s",
	"&x04%s &x06%s &x01: %s",
	"&x06%s &x01: %s"
}

new const szMenuMessages[][30] =
{
	"gg!",
	"Foi divertido!",
	"Deixa comigo!",
	"Preciso de impulsÃ£o!",
	"Chute!",
	"Estou na defesa!",
	"Fake!",
	
	"Belo chute!",
	"Ã“timo passe!",
	"Bem jogado!",
	"Obrigado!",
	"Nice bump!",
	"What a save!",
	"Nice block!",
	
	"$#@%!",
	"Sem problema!",
	"Meu Deus!",
	"NÃ£Ã£Ã£oooo!",
	"Uau!",
	"Essa foi por pouco!",
	"Sinto muito!"
};

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR);
	
	xCvarTime = register_cvar("pl_chat_time", "1.5");
		
	register_clcmd("radio1", "cmdInfo");
	register_clcmd("radio2", "cmdElogios");
	register_clcmd("radio3", "cmdReaction");
}

public client_putinserver(id)
{
	g_fLastMessageTime[id] = 0.0;
}

public cmdSayMessage(id, menu, item)
{
	new szName[32];
	get_user_name(id, szName, charsmax(szName));

	new xPrefixName[32];
	cm_get_user_prefix(id, xPrefixName, charsmax(xPrefixName));

	new Float:currentTime = get_gametime();
	new Float:timeCount = currentTime - g_fLastMessageTime[id];
	new Float:requiredTime = get_pcvar_float(xCvarTime);
	
	new userTeam = get_user_team(id);
	
	if(userTeam > 0 && userTeam < 3)
	{
		if(timeCount >= requiredTime)
		{
			g_fLastMessageTime[id] = currentTime;
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
			}
			else
			{
				new Float:remainingTime = (requiredTime + 0.2) - timeCount;
				if(remainingTime > 0.0)
					CC_SendMessage(id, "&x04[FWO] &x01Espere &x04%3.1f &x01segundos...", remainingTime);
			}
	}
	else
	{
		if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
			CC_SendMessage(0, "&x04%s &x03%s &x01: &x04%s", xPrefixName, szName, szMenuMessages[item]);
		else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
			CC_SendMessage(0, "&x03%s &x01: &x04%s", szName, szMenuMessages[item]);
		else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
			CC_SendMessage(0, "&x04%s &x03%s &x01: %s", xPrefixName, szName, szMenuMessages[item]);
		else
			CC_SendMessage(0, "&x03%s &x01: %s", szName,szMenuMessages[item]);
	}
	
	client_cmd(id, "speak buttons/lightswitch2");
	menu_destroy(menu);
}

public cmdInfo(id)
{
	if(get_user_team(id) > 2)
	{
		CC_SendMessage(id, "&x04[FWO] &x01VocÃƒÂª nÃƒÂ£o pode acessar este menu estando de SPEC.");
		client_cmd(id, "speak buttons/button10");
		return PLUGIN_HANDLED;
	}
		
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wInformaÃ§Ãµes", PREFIX_MENU);
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
	if(get_user_team(id) > 2)
	{
		CC_SendMessage(id, "&x04[FWO] &x01VocÃƒÂª nÃƒÂ£o pode acessar este menu estando de SPEC.");
		client_cmd(id, "speak buttons/button10");
		return PLUGIN_HANDLED;
	}

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
	if(get_user_team(id) > 2)
	{
		CC_SendMessage(id, "&x04[FWO] &x01VocÃƒÂª nÃƒÂ£o pode acessar este menu estando de SPEC.");
		client_cmd(id, "speak buttons/button10");
		return PLUGIN_HANDLED;
	}
	
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wReaÃ§Ãµes", PREFIX_MENU);
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
