scriptName AddSpellMenu_Menu_Controls hidden
{Controls for the inventory UI menu}

function CloseInventoryMenu() global
    Game.DisablePlayerControls()
    Game.EnablePlayerControls()
endFunction
