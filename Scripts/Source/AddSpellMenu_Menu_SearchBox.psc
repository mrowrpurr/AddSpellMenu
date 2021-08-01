scriptName AddSpellMenu_Menu_SearchBox hidden

string function Show() global
    uitextentrymenu textEntryMenu = uiextensions.GetMenu("UITextEntryMenu") as uitextentrymenu
    textEntryMenu.OpenMenu()
    return textEntryMenu.GetResultString()
endFunction