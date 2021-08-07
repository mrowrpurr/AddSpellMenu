scriptName AddSpellMenu_Menu_SpellChooser hidden

function Show(Actor spellsContainer) global
    if Game.GetModByName("SkyUI_SE.esp") != 255
        AddSpellMenu_Forms.GetModQuestScriptv3().ListenForUIMagicMenuEvents()
        AddSpellMenu_Menu_SkyUISpellChooser.Show(spellsContainer)
    else
        AddSpellMenu_Menu_ListSpellChooser.Show(spellsContainer)
        AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
    endIf
endFunction
