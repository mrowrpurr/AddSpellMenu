scriptName AddSpellMenu_UI hidden
{Primary functions for triggering the mod list / spell search UI menus}

; Show the main [AddSpellMenu] (different depending on if NPC in crosshairs or not, etc)
function ShowAddSpellMenu() global
    Actor npc = Game.GetCurrentCrosshairRef() as Actor
    if npc
        ; Test by going into Skyrim and Load Game then COC and then try this (forks should be gone)
        AddSpellMenu_Messages.ShowWhenNpcInCrosshairs(npc)
    else
        AddSpellMenu_Messages.ShowMainMenu()
    endIf
endFunction

function ShowNpcOrPlayerSpellMenu() global
    if AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor == Game.GetPlayer()
        AddSpellMenu_Messages.ShowMainMenu()
    else
        AddSpellMenu_Messages.ShowNpcMainMenu()
    endIf
endFunction

function ShowSpellRemover() global
    AddSpellMenu_Menu_SpellRemover.Show()
endFunction

function ShowSpellViewer() global
    AddSpellMenu_Menu_SpellViewer.Show()
endFunction

function ListMods() global
    string selectedMod = AddSpellMenu_Menu_ModChooser.Show()
    if selectedMod != ""
        if AddSpellMenu_SkyUI.IsSkyUIInstalled()
            AddSpellMenu_Forms.GetModQuestScriptv3().ListenForUIMagicMenuEvents()
        endIf
        ShowSpellsInMod(selectedMod)
    endIf
endFunction

function SearchModsAndSpells(string searchQuery = "") global
    if searchQuery == ""
        searchQuery = AddSpellMenu_Menu_SearchBox.Show()
    endIf
    if searchQuery != ""
        string selection = AddSpellMenu_Menu_ModChooser.Show(searchQuery)
        if selection == "Search all spells"
            ShowSearchResults(searchQuery)
        elseif selection != ""
            ShowSpellsInMod(selection)
        endIf
    endIf
endFunction

function ShowSpellsInMod(string modName) global
    Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)

    bool anyMatchingSpells = AddSpellMenu_SpellSearch.GetAllModSpellsAndPopulateContainerWithMatches( \
        modName, \
        spellsContainer, \
        onlyShowSpellsWithSpellTomes = AddSpellMenu_Forms.GetModQuestScript().OnlyShowSpellsWithSpellTomes)

    if spellsContainer.GetSpellCount() > 0
        AddSpellMenu_Menu_SpellChooser.Show(spellsContainer)
    elseif anyMatchingSpells
        Debug.MessageBox("No spells found in: " + modName + "\nwhich the player does not already have")
        AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
    else
        Debug.MessageBox("No spells found in: " + modName)
        AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
    endIf
endFunction

function ShowSearchResults(string searchQuery) global
    Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)
    
    bool anyMatchingSpells = AddSpellMenu_SpellSearch.SearchAllSpellsAndPopulateContainerWithMatches( \
        searchQuery, \
        spellsContainer, \
        onlyShowSpellsWithSpellTomes = AddSpellMenu_Forms.GetModQuestScript().OnlyShowSpellsWithSpellTomes)

    if spellsContainer.GetSpellCount() > 0
        AddSpellMenu_Menu_SpellChooser.Show(spellsContainer)
    elseif anyMatchingSpells
        Debug.MessageBox("No spells found matching \"" + searchQuery + "\"\nwhich the player does not already have")
        AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
    else
        Debug.MessageBox("No spells found matching \"" + searchQuery + "\"")
        AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
    endIf
endFunction

function ShowOptionsMenu() global
    AddSpellMenu_Messages.ShowOptions()
endFunction