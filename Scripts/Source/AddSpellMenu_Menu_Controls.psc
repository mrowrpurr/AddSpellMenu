scriptName AddSpellMenu_Menu_Controls hidden

function CloseInventoryMenu() global
    Game.DisablePlayerControls()
    Game.EnablePlayerControls()
endFunction
