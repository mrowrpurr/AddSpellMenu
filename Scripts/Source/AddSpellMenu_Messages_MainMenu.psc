scriptName AddSpellMenu_Messages_MainMenu hidden

function Show() global
    AddSpellMenu_Messages_Navigation.Visit("PlayerMainMenu")
    AddSpellMenu_Npcs.SetCurrentTarget(Game.GetPlayer())
    int result = AddSpellMenu_Messages.MainMenuMessage().Show()
    int search = 0
    int choose = 1
    int remove = 2
    int manageNpcs = 3
    int options = 4
    int exit = 5
    if result == search
        OnSearch()
    elseif result == choose
        OnChooseMod()
    elseif result == remove
        OnRemoveSpells()
    elseif result == manageNpcs
        OnManageNPCs()
    elseif result == options
        OnOptions()
    elseif result == exit
        ; Nada
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
    if AddSpellMenu_Npcs.AnyNpcsSaved()
        AddSpellMenu_Messages_ManageNPCs.Show()
    else
        Debug.MessageBox("Use the [AddSpellMenu - NPC] spell to save NPCs")
        Show()
    endIf
endFunction

function OnOptions() global
    AddSpellMenu_Messages_Options.Show()
endFunction
