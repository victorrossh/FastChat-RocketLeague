# Rocket League - Fast Chat

## **Description**
The **Rocket League - Fast Chat** plugin for AMX Mod X is designed to facilitate quick communication in the game Counter-Strike 1.6, inspired by Rocket League's quick messages. It allows players to send predefined messages via radio commands, aiding in coordination and interaction during matches.

## **Note:** 
This plugin is not standalone. It requires integration with other plugins, such as **OciXCrom's Chat Manager [Admin Prefix & Color Chat]**, available on AlliedModders.

## **Features**
- Quick sending of predefined messages.
- Three categories of messages: Information, Compliments, and Reactions.

## **Configuration**

Configure the time between messages via the pl_chat_time cvar.
Dependencies
This plugin requires the following additional plugins to function correctly:
1. **OciXCrom's Chat Manager [Admin Prefix & Color Chat].**
2. **[INC] CromChat - a better ColorChat! (include).**

## **Cvars**
**`pl_chat_time`** - Defines the minimum time (in seconds) between sending two consecutive messages by the same player.

## **Commands**
1. **radio1** - Opens the Information messages menu.
2. **radio2** - Opens the Compliments messages menu.
3. **radio3** - Opens the Reactions messages menu.

## **Usage**
Players can use the radio commands, which are bound to the `keys Radio 1 (Z), Radio 2 (X), and Radio 3 (C)` by default, to open the quick message menus and select the desired message. 
a