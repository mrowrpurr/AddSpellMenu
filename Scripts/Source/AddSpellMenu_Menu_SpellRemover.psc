scriptName AddSpellMenu_Menu_SpellRemover hidden

function Show() global
    if Game.GetModByName("SkyUI_SE.esp") != 255
        AddSpellMenu_Menu_SkyUISpellRemover.Show()
    else
        AddSpellMenu_Menu_ListSpellRemover.Show()
    endIf
endFunction
