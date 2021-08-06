scriptName AddSpellMenu_Menu_SpellViewer hidden

function Show() global
    if Game.GetModByName("SkyUI_SE.esp") != 255
        AddSpellMenu_Menu_SkyUISpellViewer.Show()
    else
        AddSpellMenu_Menu_ListSpellViewer.Show()
    endIf
endFunction
