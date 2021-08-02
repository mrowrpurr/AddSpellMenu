scriptName AddSpellMenu_Menu_SpellChooser hidden

function Show(Actor spellsContainer, AddSpellMenu_QuestScript modQuest) global
    if Game.GetModByName("SkyUI_SE.esp") != 255
        AddSpellMenu_Menu_SkyUISpellChooser.Show(spellsContainer, modQuest)
    else
        AddSpellMenu_Menu_ListSpellChooser.Show(spellsContainer, modQuest)
    endIf
endFunction
