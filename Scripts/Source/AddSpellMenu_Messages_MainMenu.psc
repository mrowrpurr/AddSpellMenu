scriptName AddSpellMenu_Messages_MainMenu hidden

function Show(Actor npc = None) global
    if npc
        if AddSpellMenu_Npcs.HasAnySpells(npc)
            ShowNpcMainMenu_HasSpells(npc)
        else
            ShowNpcMainMenu_NoSpells(npc)
        endIf
    else
        ShowPlayerMainMenu()
    endIf
endFunction

function ShowPlayerMainMenu() global
    AddSpellMenu_Messages_Navigation.Visit("PlayerMainMenu")
    AddSpellMenu_Npcs.SetCurrentTarget(Game.GetPlayer())
    int result = AddSpellMenu_Forms.MainMenuMessage().Show()
    if result == 0
        OnSearch()
    elseif result == 1
        OnChooseMod()
    elseif result == 2
        OnRemoveSpells()
    elseif result == 3
        OnManageNPCs()
    elseif result == 4
        OnOptions()
    else
        OnExit()
    endIf
endFunction

function ShowNpcMainMenu_NoSpells(Actor npc = None) global
    if ! npc
        npc = AddSpellMenu_Npcs.GetCurrentTarget()
        if ! npc
            ShowPlayerMainMenu()
            return
        endIf
    endIf
    AddSpellMenu_Messages_Navigation.Visit("NpcMainMenu")
    AddSpellMenu_Npcs.SetCurrentTarget(npc)
    int result = AddSpellMenu_Forms.NpcMainMenuMessage().Show()
    if result == 0
        OnSearch()
    elseif result == 1
        OnChooseMod()
    elseif result == 2
        OnManageNPCs()
    elseif result == 3
        OnOptions()
    else
        OnExit()
    endIf
endFunction

function ShowNpcMainMenu_HasSpells(Actor npc = None) global
    if ! npc
        npc = AddSpellMenu_Npcs.GetCurrentTarget()
        if ! npc
            ShowPlayerMainMenu()
            return
        endIf
    endIf
    AddSpellMenu_Messages_Navigation.Visit("NpcMainMenu")
    AddSpellMenu_Npcs.SetCurrentTarget(npc)
    int result = AddSpellMenu_Forms.NpcMainMenuMessage().Show()
    if result == 0
        OnSearch()
    elseif result == 1
        OnChooseMod()
    elseif result == 2
        OnViewSpells()
    elseif result == 3
        OnRemoveSpells()
    elseif result == 4
        OnManageNPCs()
    elseif result == 5
        OnOptions()
    else
        OnExit()
    endIf
endFunction

function OnSearch() global
    AddSpellMenu_UI.SearchModsAndSpells()
endFunction

function OnChooseMod() global
    AddSpellMenu_UI.ListMods()
endFunction

function OnRemoveSpells() global
    AddSpellMenu_UI.ShowSpellRemover()
endFunction

function OnViewSpells() global
    AddSpellMenu_UI.ShowSpellViewer()
endFunction

function OnManageNPCs() global
    AddSpellMenu_Messages_ManageNPCs.Show()
endFunction

function OnOptions() global
    AddSpellMenu_Messages_Options.Show()
endFunction

function OnExit() global
    ; Nada
endFunction