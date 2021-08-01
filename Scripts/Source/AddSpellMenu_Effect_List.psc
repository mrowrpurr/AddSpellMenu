scriptName AddSpellMenu_Effect_List extends ActiveMagicEffect  

AddSpellMenu_QuestScript property ModQuest auto

event OnEffectStart(Actor target, Actor caster)
    string selectedMod = AddSpellMenu_Menu_ModChooser.Show()
    if selectedMod != ""
        Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)
        if AddSpellMenu_SpellSearch.GetAllModSpellsAndPopulateContainerWithMatches(selectedMod, spellsContainer)
            AddSpellMenu_Menu_SpellChooser.Show(spellsContainer, ModQuest)
        else
            Debug.MessageBox("No spells found in: " + selectedMod + " which the player does not already have")
        endIf
    endIf
endEvent