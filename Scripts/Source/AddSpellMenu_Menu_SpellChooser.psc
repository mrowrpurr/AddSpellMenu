scriptName AddSpellMenu_Menu_SpellChooser hidden

function Show(Actor spellsContainer) global
    if AddSpellMenu_SkyUI.IsSkyUIInstalled()
        AddSpellMenu_Forms.GetModQuestScriptv3().ListenForUIMagicMenuEvents()
        AddSpellMenu_Menu_SkyUISpellChooser.Show(spellsContainer)
    else
        AddSpellMenu_Menu_ListSpellChooser.Show(spellsContainer)
        AddSpellMenu_Messages_Navigation.GoBack()
    endIf
endFunction
