#include <sourcemod>
#include <sdktools>

ConVar g_DiscordLink;

public Plugin myinfo =
{
    name = "Discord Link System",
    author = "-R3d RuSh.",
    description = "",
    version = "",
    url = "https://steamcommunity.com/id/r3drush/"
};

public void OnPluginStart()
{
    g_DiscordLink = CreateConVar("discord_link", "discord.gg/Link-Ul Tau", "Link-ul de la server-ul tau de Discord", FCVAR_NONE);

    RegConsoleCmd("sm_discord", Command_Discord);

    HookConVarChange(g_DiscordLink, OnDiscordLinkChanged);

    AutoExecConfig(true, "discord_link");
}

public void OnPluginEnd()
{
    UnhookConVarChange(g_DiscordLink, OnDiscordLinkChanged);
}

public Action Command_Discord(int client, int args)
{
    char discordLink[256];
    GetConVarString(g_DiscordLink, discordLink, sizeof(discordLink));

    PrintToChat(client, "» \x0CDiscord Link\x01: %s", discordLink);

    Menu menu = CreateMenu(MenuHandler_Discord);
    
    SetMenuTitle(menu, "★ Discord Link ★");
    AddMenuItem(menu, "1", discordLink, ITEMDRAW_DISABLED);
    DisplayMenu(menu, client, 0);

    return Plugin_Handled;
}

public void OnDiscordLinkChanged(ConVar convar, const char[] oldValue, const char[] newValue)
{
    PrintToServer("Ai schimbat link-ul server-ului de Discord din %s in %s.", oldValue, newValue);
}

public int MenuHandler_Discord(Menu menu, MenuAction action, int param1, int param2)
{
    if (action == MenuAction_End)
    {
        CloseHandle(menu);
    }
    return 0;
}