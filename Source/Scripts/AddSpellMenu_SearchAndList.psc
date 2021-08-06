scriptName AddSpellMenu_SearchAndList hidden
{Primary functions for triggering the mod list / spell search UI menus}

function ListMods() global
    string selectedMod = AddSpellMenu_Menu_ModChooser.Show()
    if selectedMod != ""
        ShowSpellsInMod(selectedMod)
    endIf
endFunction

function SearchModsAndSpells(string searchQuery = "") global
    if searchQuery == ""
        searchQuery = AddSpellMenu_Menu_SearchBox.Show()
    endIf
    searchQuery = AddSpellMenu_Menu_SearchBox.Show()
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
    else
        Debug.MessageBox("No spells found in: " + modName)
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
    else
        Debug.MessageBox("No spells found matching \"" + searchQuery + "\"")
    endIf
endFunction