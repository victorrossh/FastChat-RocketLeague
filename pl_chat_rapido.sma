#include <amxmodx>
#include <chatmanager>

#define PLUGIN "Rocket League - Chat Rapido"
#define VERSION "1.1"
#define AUTHOR "WESPEOOTY && ftl"

#define PREFIX_MENU "\r[FWO]"

new const szMenuInfo[][33] =
{
	"gg!",
	"Foi divertido!",
	"Deixa comigo!",
	"Preciso de impulsÃ£o!",
	"Chute!",
	"Estou na defesa!"
};

new const szMenuElogios[][33] =
{
	"Belo chute!",
	"Ã“timo passe!",
	"Bem jogado!",
	"Obrigado!",
	"Nice bump!",
	"What a save!"
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
		
	register_clcmd("radio1", "cmdInfo");
	register_clcmd("radio2", "cmdElogios");
	register_clcmd("radio3", "cmdReaction");
}

public cmdInfo(id)
{
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
		menu_destroy(menu); return PLUGIN_HANDLED;
	}
	
	new szName[32];
	get_user_name(id, szName, charsmax(szName));

	new xPrefixName[32];
	cm_get_user_prefix(id, xPrefixName, charsmax(xPrefixName));
	
	if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
		ChatColor(0, "!g%s !t%s !y: !g%s", xPrefixName, szName, szMenuInfo[item]);
	else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
		ChatColor(0, "!t%s !y: !g%s", szName, szMenuInfo[item]);
	else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
		ChatColor(0, "!g%s !t%s !y: !y%s", xPrefixName, szName, szMenuInfo[item]);
	else
		ChatColor(0, "!t%s !y: %s", szName, szMenuInfo[item]);
	
	client_cmd(id, "speak buttons/lightswitch2");
	
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

public cmdElogios(id)
{
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
		menu_destroy(menu); return PLUGIN_HANDLED;
	}
	
	new szName[32];
	get_user_name(id, szName, charsmax(szName));
	
	new xPrefixName[32];
	cm_get_user_prefix(id, xPrefixName, charsmax(xPrefixName));
	
	if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
		ChatColor(0, "!g%s !t%s !y: !g%s", xPrefixName, szName, szMenuElogios[item]);
	else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
		ChatColor(0, "!t%s !y: !g%s", szName, szMenuElogios[item]);
	else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
		ChatColor(0, "!g%s !t%s !y: !y%s", xPrefixName, szName, szMenuElogios[item]);
	else
		ChatColor(0, "!t%s !y: %s", szName, szMenuElogios[item]);

	client_cmd(id, "speak buttons/lightswitch2");
	
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

public cmdReaction(id)
{
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
		menu_destroy(menu); return PLUGIN_HANDLED;
	}
	
	new szName[32];
	get_user_name(id, szName, charsmax(szName));

	new xPrefixName[32];
	cm_get_user_prefix(id, xPrefixName, charsmax(xPrefixName));
	
	if(cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
		ChatColor(0, "!g%s !t%s !y: !g%s", xPrefixName, szName, szMenuReaction[item]);
	else if(!cm_get_user_prefix_status(id) && cm_get_user_chat_color_status(id))
		ChatColor(0, "!t%s !y: !g%s", szName, szMenuReaction[item]);
	else if(cm_get_user_prefix_status(id) && !cm_get_user_chat_color_status(id))
		ChatColor(0, "!g%s !t%s !y: !y%s", xPrefixName, szName, szMenuReaction[item]);
	else
		ChatColor(0, "!t%s !y: %s", szName, szMenuReaction[item]);
		
	client_cmd(id, "speak buttons/lightswitch2");
	
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

stock ChatColor(const id, const input[], any:...)
{
	new count = 1, players[32];
	static msg[191];
	vformat(msg, 190, input, 3);
   
	replace_all(msg, 190, "!g", "^4");	// Chat Verde
	replace_all(msg, 190, "!y", "^1");	// Chat Normal
	replace_all(msg, 190, "!t", "^3");	// Chat Do Time Tr=Vermelho Ct=Azul Spec=Branco
	replace_all(msg, 190, "!t2", "^0");	// Chat Do Time Tr=Vermelho Ct=Azul Spec=Branco
   
	if(id) players[0] = id; else get_players(players, count, "ch");
   
	for(new i = 0; i < count; i++)
	{
		if(is_user_connected(players[i]))
		{
			message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, players[i]);
			write_byte(players[i]);
			write_string(msg);
			message_end();
		}
	}
}
