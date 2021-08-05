scriptName AddSpellMenu_SearchAndList hidden
{Primary functions for triggering the mod list / spell search UI menus}

function ListMods(AddSpellMenu_QuestScript modQuest) global
    string selectedMod = AddSpellMenu_Menu_ModChooser.Show()
    if selectedMod != ""
        ShowSpellsInMod(selectedMod, modQuest)
    endIf
endFunction

function SearchModsAndSpells(AddSpellMenu_QuestScript modQuest) global
    string searchQuery = AddSpellMenu_Menu_SearchBox.Show()
    if searchQuery != ""
        string selection = AddSpellMenu_Menu_ModChooser.Show(searchQuery)
        if selection == "Search all spells"
            ShowSearchResults(searchQuery, modQuest)
        elseif selection != ""
            ShowSpellsInMod(selection, modQuest)
        endIf
    endIf
endFunction

function ShowSpellsInMod(string modName, AddSpellMenu_QuestScript modQuest) global
    Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)

    bool anyMatchingSpells = AddSpellMenu_SpellSearch.GetAllModSpellsAndPopulateContainerWithMatches( \
        modName, \
        spellsContainer, \
        onlyShowSpellsWithSpellTomes = modQuest.OnlyShowSpellsWithSpellTomes)

    if spellsContainer.GetSpellCount() > 0
        AddSpellMenu_Menu_SpellChooser.Show(spellsContainer, modQuest)
    elseif anyMatchingSpells
        Debug.MessageBox("No spells found in: " + modName + "\nwhich the player does not already have")
    else
        Debug.MessageBox("No spells found in: " + modName)
    endIf
endFunction

function ShowSearchResults(string searchQuery, AddSpellMenu_QuestScript modQuest) global
    Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)
    
    bool anyMatchingSpells = AddSpellMenu_SpellSearch.SearchAllSpellsAndPopulateContainerWithMatches( \
        ModQuest, \
        searchQuery, \
        spellsContainer, \
        onlyShowSpellsWithSpellTomes = ModQuest.OnlyShowSpellsWithSpellTomes)

    if spellsContainer.GetSpellCount() > 0
        AddSpellMenu_Menu_SpellChooser.Show(spellsContainer, ModQuest)
    elseif anyMatchingSpells
        Debug.MessageBox("No spells found matching \"" + searchQuery + "\"\nwhich the player does not already have")
    else
        Debug.MessageBox("No spells found matching \"" + searchQuery + "\"")
    endIf
endFunction