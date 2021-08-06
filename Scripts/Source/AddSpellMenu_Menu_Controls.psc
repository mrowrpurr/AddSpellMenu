scriptName AddSpellMenu_Menu_Controls hidden
{Controls for the inventory UI menu}

function CloseAllOpenMenus() global
    Game.DisablePlayerControls()
    Game.EnablePlayerControls()
endFunction
