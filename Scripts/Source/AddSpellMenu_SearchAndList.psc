scriptName AddSpellMenu_SearchAndList

function ListMods(AddSpellMenu_QuestScript modQuest) global
    string selectedMod = AddSpellMenu_Menu_ModChooser.Show()
    if selectedMod != ""
        Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)
        if AddSpellMenu_SpellSearch.GetAllModSpellsAndPopulateContainerWithMatches( \
                selectedMod, \
                spellsContainer, \
                onlyShowSpellsWithSpellTomes = modQuest.OnlyShowSpellsWithSpellTomes)
            AddSpellMenu_Menu_SpellChooser.Show(spellsContainer, modQuest)
        else
            Debug.MessageBox("No spells found in: " + selectedMod + " which the player does not already have")
        endIf
    endIf
endFunction

function SearchSpells(AddSpellMenu_QuestScript modQuest) global
    string searchQuery = AddSpellMenu_Menu_SearchBox.Show()
    if searchQuery != ""
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
    endIf
endFunction