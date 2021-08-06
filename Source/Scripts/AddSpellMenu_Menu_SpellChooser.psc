scriptName AddSpellMenu_Menu_SpellChooser hidden

function Show(Actor spellsContainer) global
    if Game.GetModByName("SkyUI_SE.esp") != 255
        AddSpellMenu_Menu_SkyUISpellChooser.Show(spellsContainer)
    else
        AddSpellMenu_Menu_ListSpellChooser.Show(spellsContainer)
    endIf
endFunction
