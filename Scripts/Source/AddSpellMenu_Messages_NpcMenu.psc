scriptName AddSpellMenu_Messages_NpcMenu

function Show(Actor npc) global
    AddSpellMenu_Messages_Navigation.Visit("NpcMenu")
    AddSpellMenu_npcs.SetCurrentTarget(npc)
    AddSpellMenu_Messages_TextReplacement.SetTextReplacement(1, AddSpellMenu_Npcs.GetNpcName(npc))
    if AddSpellMenu_Npcs.IsSaved(npc)
        if AddSpellMenu_Npcs.HasAnySpells(npc)
            NpcMenu_Saved_WithSpells(npc)
        else
            NpcMenu_Saved_NoSpells(npc)
        endIf
    else
        if AddSpellMenu_Npcs.HasAnySpells(npc)
            NpcMenu_NotSaved_WithSpells(npc)
        else
            NpcMenu_NotSaved_NoSpells(npc)
        endIf
    endIf
endFunction

function NpcMenu_Saved_WithSpells(Actor npc) global
    int result = AddSpellMenu_Messages.NpcMenu_Saved_WithSpells().Show()
    int search = 0
    int listMods = 1
    int viewNpcSpells = 2
    int mainMenu = 3
    int exit = 4

    if result == search
        OnSearch()
    elseif result == listMods
        OnChooseMod()
    elseif result == viewNpcSpells
        OnViewSpells()
    elseif result == mainMenu
        OnMainMenu()
    else
    endIf
endFunction

function NpcMenu_Saved_NoSpells(Actor npc) global
    int result = AddSpellMenu_Messages.NpcMenu_Saved_NoSpells().Show()
    int search = 0
    int listMods = 1
    int mainMenu = 2
    int exit = 3

    if result == search
        OnSearch()
    elseif result == listMods
        OnChooseMod()
    elseif result == mainMenu
        OnMainMenu()
    endIf
endFunction

function NpcMenu_NotSaved_WithSpells(Actor npc) global
    int result = AddSpellMenu_Messages.NpcMenu_NotSaved_WithSpells().Show()
    int search = 0
    int listMods = 1
    int viewNpcSpells = 2
    int saveNpc = 3
    int mainMenu = 4
    int exit = 5

    if result == search
        OnSearch()
    elseif result == listMods
        OnChooseMod()
    elseif result == viewNpcSpells
        OnViewSpells()
    elseif result == saveNpc
        OnSaveNpc(npc)
    elseif result == mainMenu
        OnMainMenu()
    endIf
endFunction

function NpcMenu_NotSaved_NoSpells(Actor npc) global
    int result = AddSpellMenu_Messages.NpcMenu_NotSaved_NoSpells().Show()
    int search = 0
    int listMods = 1
    int saveNpc = 2
    int mainMenu = 3
    int exit = 4

    if result == search
        OnSearch()
    elseif result == listMods
        OnChooseMod()
    elseif result == saveNpc
        OnSaveNpc(npc)
    elseif result == mainMenu
        OnMainMenu()
    endIf
endFunction

function OnSearch() global
    AddSpellMenu_UI.SearchModsAndSpells()
endFunction

function OnChooseMod() global
    AddSpellMenu_UI.ListMods()
endFunction

function OnViewSpells() global
    AddSpellMenu_UI.ShowSpellRemover()
endFunction

function OnMainMenu() global
    AddSpellMenu_Messages_Navigation.Clear()
    AddSpellMenu_Messages_MainMenu.Show()
endFunction

function OnSaveNpc(Actor npc) global
    AddSpellMenu_Npcs.SaveNPC(npc)
    Debug.MessageBox("Saved NPC " + AddSpellMenu_Npcs.GetNpcName(npc))
    Show(npc)
endFunction

function OnExit() global
    ; Nada
endFunction