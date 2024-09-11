#include <amxmodx>
#include <chatmanager>
#include <cromchat2>

#define PLUGIN "Rocket League - Chat Rapido"
#define VERSION "1.2"
#define AUTHOR "WESPEOOTY && ftl"

#define PREFIX_MENU "\r[FWO]"

new Float:g_fLastMessageTime[33];
new xCvarTime;

new const szMenuInfo[][33] =
{
	"gg!",
	"Foi divertido!",
	"Deixa comigo!",
	"Preciso de impulsÃ£o!",
	"Chute!",
	"Estou na defesa!",
	"Fake!"
};

new const szMenuElogios[][33] =
{
	"Belo chute!",
	"Ã“timo passe!",
	"Bem jogado!",
	"Obrigado!",
	"Nice bump!",
	"What a save!",
	"Nice block!"
};

new const szMenuReaction[][33] =
{
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

public cmdInfo(id)
{
	if(get_user_team(id) > 2)
	{
		CC_SendMessage(id, "&x04[FWO] &x01VocÃª nÃ£o pode acessar este menu estando de SPEC.");
		client_cmd(id, "speak buttons/button10");
		return PLUGIN_HANDLED;
	}
		
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wInformaÃ§Ãµes", PREFIX_MENU);
	new menu = menu_create(szMenuTitle, "handInfo");

	for(new i = 0; i < sizeof szMenuInfo; i++)
	{
		formatex(szMenuTitle, charsmax(szMenuTitle), "%s", szMenuInfo[i]);
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
		return PLUGIN_HANDLED;
	}

	new szName[32];
	get_user_name(id, szName, charsmax(szName));

	new xPrefixName[32];
	cm_get_user_prefix(id, xPrefixName, charsmax(xPrefixName));

	new Float:currentTime = get_gametime();
	new Float:timeCount = currentTime - g_fLastMessageTime[id];
	new Float:requiredTime = get_pcvar_float(xCvarTime);

	switch(get_user_team(id))
	{
		case 1:
		{
			if(timeCount >= requiredTime)
			{
				g_fLastMessageTime[id] = currentTime;
				switch(get_user_flags(id) & (ADMIN_RESERVATION | ADMIN_USER))
				{
					case ADMIN_RESERVATION:
					{
						if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x07%s &x01: &x04%s", xPrefixName, szName, szMenuInfo[item]);
						else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x07%s &x01: &x04%s", szName, szMenuInfo[item]);
						else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x07%s &x01: %s", xPrefixName, szName, szMenuInfo[item]);
						else
							CC_SendMessage(0, "&x07%s &x01: %s", szName, szMenuInfo[item]);
					}
					case ADMIN_USER:
						CC_SendMessage(0, "&x07%s &x01: %s", szName, szMenuInfo[item]);
				}
			}
			else
			{
				new Float:remainingTime = (requiredTime + 0.2) - timeCount;
				if(remainingTime > 0.0)
					CC_SendMessage(id, "&x04[FWO] &x01Espere &x04%3.1f &x01segundos...", remainingTime);
			}
		}
		case 2:
		{
			if(timeCount >= requiredTime)
			{
				g_fLastMessageTime[id] = currentTime;
				switch(get_user_flags(id) & (ADMIN_RESERVATION | ADMIN_USER))
				{
					case ADMIN_RESERVATION:
					{
						if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x06%s &x01: &x04%s", xPrefixName, szName, szMenuInfo[item]);
						else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x06%s &x01: &x04%s", szName, szMenuInfo[item]);
						else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x06%s &x01: %s", xPrefixName, szName, szMenuInfo[item]);
						else
							CC_SendMessage(0, "&x06%s &x01: %s", szName, szMenuInfo[item]);
					}
					case ADMIN_USER:
						CC_SendMessage(0, "&x06%s &x01: %s", szName, szMenuInfo[item]);
				}
			}
			else
			{
				new Float:remainingTime = (requiredTime + 0.2) - timeCount;
				if(remainingTime > 0.0)
					CC_SendMessage(id, "&x04[FWO] &x01Espere &x04%3.1f &x01segundos...", remainingTime);
			}
		}
		default:
		{
			if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
				CC_SendMessage(0, "&x04%s &x03%s &x01: &x04%s", xPrefixName, szName, szMenuInfo[item]);
			else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
				CC_SendMessage(0, "&x03%s &x01: &x04%s", szName, szMenuInfo[item]);
			else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
				CC_SendMessage(0, "&x04%s &x03%s &x01: %s", xPrefixName, szName, szMenuInfo[item]);
			else
				CC_SendMessage(0, "&x03%s &x01: %s", szName, szMenuInfo[item]);
		}
	}
	client_cmd(id, "speak buttons/lightswitch2");
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

public cmdElogios(id)
{
	if(get_user_team(id) > 2)
	{
		CC_SendMessage(id, "&x04[FWO] &x01VocÃª nÃ£o pode acessar este menu estando de SPEC.");
		client_cmd(id, "speak buttons/button10");
		return PLUGIN_HANDLED;
	}

	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wElogios", PREFIX_MENU);
	new menu = menu_create(szMenuTitle, "handElogios");

	for(new i = 0; i < sizeof szMenuElogios; i++)
	{
		formatex(szMenuTitle, charsmax(szMenuTitle), "%s", szMenuElogios[i]);
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

	new szName[32];
	get_user_name(id, szName, charsmax(szName));

	new xPrefixName[32];
	cm_get_user_prefix(id, xPrefixName, charsmax(xPrefixName));

	new Float:currentTime = get_gametime();
	new Float:timeCount = currentTime - g_fLastMessageTime[id];
	new Float:requiredTime = get_pcvar_float(xCvarTime);

	switch(get_user_team(id))
	{
		case 1:
		{
			if(timeCount >= requiredTime)
			{
				g_fLastMessageTime[id] = currentTime;
				switch(get_user_flags(id) & (ADMIN_RESERVATION | ADMIN_USER))
				{
					case ADMIN_RESERVATION:
					{
						if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x07%s &x01: &x04%s", xPrefixName, szName, szMenuElogios[item]);
						else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x07%s &x01: &x04%s", szName, szMenuElogios[item]);
						else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x07%s &x01: %s", xPrefixName, szName, szMenuElogios[item]);
						else
							CC_SendMessage(0, "&x07%s &x01: %s", szName, szMenuElogios[item]);
					}
					case ADMIN_USER:
						CC_SendMessage(0, "&x07%s &x01: %s", szName, szMenuElogios[item]);
				}
			}
			else
			{
				new Float:remainingTime = (requiredTime + 0.2) - timeCount;
				if(remainingTime > 0.0)
					CC_SendMessage(id, "&x04[FWO] &x01Espere &x04%3.1f &x01segundos...", remainingTime);
			}
		}
		case 2:
		{
			if(timeCount >= requiredTime)
			{
				g_fLastMessageTime[id] = currentTime;
				switch(get_user_flags(id) & (ADMIN_RESERVATION | ADMIN_USER))
				{
					case ADMIN_RESERVATION:
					{
						if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x06%s &x01: &x04%s", xPrefixName, szName, szMenuElogios[item]);
						else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x06%s &x01: &x04%s", szName, szMenuElogios[item]);
						else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x06%s &x01: %s", xPrefixName, szName, szMenuElogios[item]);
						else
							CC_SendMessage(0, "&x06%s &x01: %s", szName, szMenuElogios[item]);
					}
					case ADMIN_USER:
						CC_SendMessage(0, "&x06%s &x01: %s", szName, szMenuElogios[item]);
				}
			}
			else
			{
				new Float:remainingTime = (requiredTime + 0.2) - timeCount;
				if(remainingTime > 0.0)
					CC_SendMessage(id, "&x04[FWO] &x01Espere &x04%3.1f &x01segundos...", remainingTime);
			}
		}
		default:
		{
			if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
				CC_SendMessage(0, "&x04%s &x03%s &x01: &x04%s", xPrefixName, szName, szMenuElogios[item]);
			else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
				CC_SendMessage(0, "&x03%s &x01: &x04%s", szName, szMenuElogios[item]);
			else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
				CC_SendMessage(0, "&x04%s &x03%s &x01: %s", xPrefixName, szName, szMenuElogios[item]);
			else
				CC_SendMessage(0, "&x03%s &x01: %s", szName, szMenuElogios[item]);
		}
	}
	client_cmd(id, "speak buttons/lightswitch2");
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

public cmdReaction(id)
{
	if(get_user_team(id) > 2)
	{
		CC_SendMessage(id, "&x04[FWO] &x01VocÃª nÃ£o pode acessar este menu estando de SPEC.");
		client_cmd(id, "speak buttons/button10");
		return PLUGIN_HANDLED;
	}
	
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wReaÃ§Ãµes", PREFIX_MENU);
	new menu = menu_create(szMenuTitle, "handReaction");

	for(new i = 0; i < sizeof szMenuReaction; i++)
	{
		formatex(szMenuTitle, charsmax(szMenuTitle), "%s", szMenuReaction[i]);
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

	new szName[32];
	get_user_name(id, szName, charsmax(szName));

	new xPrefixName[32];
	cm_get_user_prefix(id, xPrefixName, charsmax(xPrefixName));

	new Float:currentTime = get_gametime();
	new Float:timeCount = currentTime - g_fLastMessageTime[id];
	new Float:requiredTime = get_pcvar_float(xCvarTime);

	switch(get_user_team(id))
	{
		case 1:
		{
			if(timeCount >= requiredTime)
			{
				g_fLastMessageTime[id] = currentTime;
				switch(get_user_flags(id) & (ADMIN_RESERVATION | ADMIN_USER))
				{
					case ADMIN_RESERVATION:
					{
						if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x07%s &x01: &x04%s", xPrefixName, szName, szMenuReaction[item]);
						else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x07%s &x01: &x04%s", szName, szMenuReaction[item]);
						else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x07%s &x01: %s", xPrefixName, szName, szMenuReaction[item]);
						else
							CC_SendMessage(0, "&x07%s &x01: %s", szName, szMenuReaction[item]);
					}
					case ADMIN_USER:
						CC_SendMessage(0, "&x07%s &x01: %s", szName, szMenuReaction[item]);
				}
			}
			else
			{
				new Float:remainingTime = (requiredTime + 0.2) - timeCount;
				if(remainingTime > 0.0)
					CC_SendMessage(id, "&x04[FWO] &x01Espere &x04%3.1f &x01segundos...", remainingTime);
			}
		}
		case 2:
		{
			if(timeCount >= requiredTime)
			{
				g_fLastMessageTime[id] = currentTime;
				switch(get_user_flags(id) & (ADMIN_RESERVATION | ADMIN_USER))
				{
					case ADMIN_RESERVATION:
					{
						if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x06%s &x01: &x04%s", xPrefixName, szName, szMenuReaction[item]);
						else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x06%s &x01: &x04%s", szName, szMenuReaction[item]);
						else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
							CC_SendMessage(0, "&x04%s &x06%s &x01: %s", xPrefixName, szName, szMenuReaction[item]);
						else
							CC_SendMessage(0, "&x06%s &x01: %s", szName, szMenuReaction[item]);
					}
					case ADMIN_USER:
						CC_SendMessage(0, "&x06%s &x01: %s", szName, szMenuReaction[item]);
				}
			}
			else
			{
				new Float:remainingTime = (requiredTime + 0.2) - timeCount;
				if(remainingTime > 0.0)
					CC_SendMessage(id, "&x04[FWO] &x01Espere &x04%3.1f &x01segundos...", remainingTime);
			}
		}
		default:
		{
			if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
				CC_SendMessage(0, "&x04%s &x03%s &x01: &x04%s", xPrefixName, szName, szMenuReaction[item]);
			else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
				CC_SendMessage(0, "&x03%s &x01: &x04%s", szName, szMenuReaction[item]);
			else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
				CC_SendMessage(0, "&x04%s &x03%s &x01: %s", xPrefixName, szName, szMenuReaction[item]);
			else
				CC_SendMessage(0, "&x03%s &x01: %s", szName, szMenuReaction[item]);
		}
	}
	client_cmd(id, "speak buttons/lightswitch2");
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}
