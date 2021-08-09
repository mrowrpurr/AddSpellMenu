scriptName AddSpellMenu_Messages_ManageNPCs hidden

function Show() global
    int result = AddSpellMenu_Messages.ManageNPCsMessage().Show()
    int select = 0
    int remove = 1
    int rename = 2
    int mainMenu = 3
    if result == select
        OnChoose()
    elseif result == remove
        OnRemove()
    elseif result == rename
        OnRename()
    elseif result == mainMenu
        OnMainMenu()
    endIf
endFunction

function OnChoose() global
    Actor npc = AddSpellMenu_UI.ChooseSavedActor(includePlayer = true)
    if npc
        if npc == Game.GetPlayer()
            AddSpellMenu_Messages_MainMenu.Show()
        else
            AddSpellMenu_Npcs.SetCurrentTarget(npc)
            AddSpellMenu_Messages_NpcMenu.Show(npc)
        endIf
    else
        Show()
    endIf
endFunction

function OnRemove() global
    Actor npc = AddSpellMenu_UI.ChooseSavedActor(includePlayer = false)
    if npc
        AddSpellMenu_Npcs.RemoveSavedNPC(npc)
        Debug.MessageBox("Removed " + AddSpellMenu_Npcs.GetNpcName(npc))
    endIf
    if AddSpellMenu_Npcs.AnyNpcsSaved()
        Show()
    else
        AddSpellMenu_Messages_MainMenu.Show()
    endIf
endFunction

function OnRename() global
    Actor npc = AddSpellMenu_UI.ChooseSavedActor(includePlayer = false)
    if npc
        string newName = AddSpellMenu_UI.GetTextEntryResultForNpcName(npc)
        if newName != ""
            AddSpellMenu_Npcs.RenameSavedNPC(npc, newName)
        endIf
    endIf
    Show()
endFunction

function OnMainMenu() global
    AddSpellMenu_Messages_MainMenu.Show()
endFunction
