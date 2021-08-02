scriptName AddSpellMenu_SearchAndList

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
    if AddSpellMenu_SpellSearch.GetAllModSpellsAndPopulateContainerWithMatches( \
            modName, \
            spellsContainer, \
            onlyShowSpellsWithSpellTomes = modQuest.OnlyShowSpellsWithSpellTomes)
        AddSpellMenu_Menu_SpellChooser.Show(spellsContainer, modQuest)
    else
        Debug.MessageBox("No spells found in: " + modName + " which the player does not already have")
    endIf
endFunction

function ShowSearchResults(string searchQuery, AddSpellMenu_QuestScript modQuest) global
    Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)
    if AddSpellMenu_SpellSearch.SearchAllSpellsAndPopulateContainerWithMatches( \
            ModQuest, \
            searchQuery, \
            spellsContainer, \
            onlyShowSpellsWithSpellTomes = ModQuest.OnlyShowSpellsWithSpellTomes)
        AddSpellMenu_Menu_SpellChooser.Show(spellsContainer, ModQuest)
    else
        Debug.MessageBox("No spells found matching \"" + searchQuery + "\" which the player does not already have")
    endIf
endFunction