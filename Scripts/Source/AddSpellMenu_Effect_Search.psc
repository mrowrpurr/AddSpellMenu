scriptName AddSpellMenu_Effect_Search extends ActiveMagicEffect  

AddSpellMenu_QuestScript property ModQuest auto

event OnEffectStart(Actor target, Actor caster)
    string searchQuery = AddSpellMenu_Menu_SearchBox.Show()
    if searchQuery != ""
        Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)
        if AddSpellMenu_SpellSearch.SearchAllSpellsAndPopulateContainerWithMatches(searchQuery, spellsContainer)
            AddSpellMenu_Menu_SpellChooser.Show(spellsContainer, ModQuest)
        else
            Debug.MessageBox("No spells found matching \"" + searchQuery + "\" which the player does not already have")
        endIf
    endIf
endEvent
