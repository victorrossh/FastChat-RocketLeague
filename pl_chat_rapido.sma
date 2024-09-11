#include <amxmodx>

#define PLUGIN "Rocket League - Chat Rapido"
#define VERSION "1.0"
#define AUTHOR "WESPEOOTY && ftl"

#define PREFIX_MENU "\r[FWO]"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR);
		
	register_clcmd("say /slot1", "cmdInfo");
	register_clcmd("say /slot2", "cmdElogios");
	register_clcmd("say /slot3", "cmdReaction");
	register_clcmd("say /slot4", "cmdSorry");
}

public cmdInfo(id)
{
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wMenu de Informações", PREFIX_MENU);
	new menu = menu_create(szMenuTitle, "handInfo");

	menu_additem(menu, "Deixa comigo!", "1");
	menu_additem(menu, "Chute!", "2");
	menu_additem(menu, "Estou na defesa!", "3");

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

	switch(item)
	{
		case 0:
		{
			ChatColor(0, "!t%s !y: Deixa comigo!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 1:
		{
			ChatColor(0, "!t%s !y: Chute!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 2:
		{
			ChatColor(0, "!t%s !y: Estou na defesa!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
	}
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

public cmdElogios(id)
{
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wMenu de Elogios", PREFIX_MENU);
	new menu = menu_create(szMenuTitle, "handElogios");

	menu_additem(menu, "Belo chute!", "1");
	menu_additem(menu, "Ótimo passe!", "2");
	menu_additem(menu, "Obrigado!", "3");
	menu_additem(menu, "What a save!", "4");

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

	switch(item)
	{
		case 0:
		{
			ChatColor(0, "!t%s !y: Belo chute!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 1:
		{
			ChatColor(0, "!t%s !y: Ótimo passe!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 2:
		{
			ChatColor(0, "!t%s !y: Obrigado!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 3:
		{
			ChatColor(0, "!t%s !y: What a save!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
	}
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

public cmdReaction(id)
{
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wMenu de Reações", PREFIX_MENU);
	new menu = menu_create(szMenuTitle, "handReaction");

	menu_additem(menu, "Meu Deus!", "1");
	menu_additem(menu, "Nãããoooo!", "2");
	menu_additem(menu, "Uau!", "3");
	menu_additem(menu, "Essa foi por pouco!", "4");

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

	switch(item)
	{
		case 0:
		{
			ChatColor(0, "!t%s !y: Meu Deus!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 1:
		{
			ChatColor(0, "!t%s !y: Nãããoooo!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 2:
		{
			ChatColor(0, "!t%s !y: Uau!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 3:
		{
			ChatColor(0, "!t%s !y: Essa foi por pouco!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
	}
	menu_destroy(menu);
	return PLUGIN_HANDLED;
}

public cmdSorry(id)
{
	new szMenuTitle[128];
	formatex(szMenuTitle, charsmax(szMenuTitle), "%s \d- \wMenu de Desculpas", PREFIX_MENU);
	new menu = menu_create(szMenuTitle, "handSorry");

	menu_additem(menu, "$#@%!", "1");
	menu_additem(menu, "Sem problema!", "2");
	menu_additem(menu, "Opa...", "3");
	menu_additem(menu, "Sinto muito!", "4");

	menu_setprop(menu, MPROP_EXITNAME, "Sair");
	menu_display(id, menu, 0);

	return PLUGIN_HANDLED;
}

public handSorry(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu); return PLUGIN_HANDLED;
	}
	
	new szName[32];
	get_user_name(id, szName, charsmax(szName));

	switch(item)
	{
		case 0:
		{
			ChatColor(0, "!t%s !y: $#@%!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 1:
		{
			ChatColor(0, "!t%s !y: Sem problema!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 2:
		{
			ChatColor(0, "!t%s !y: Opa...", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
		case 3:
		{
			ChatColor(0, "!t%s !y: Sinto muito!", szName);
			client_cmd(id, "speak buttons/lightswitch2");
		}
	}
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
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1046\\ f0\\ fs16 \n\\ par }
*/
