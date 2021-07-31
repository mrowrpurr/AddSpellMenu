scriptName AddSpellMenu_Menu_ModChooser hidden

string function Show() global
    uilistmenu listMenu = uiextensions.GetMenu("UIListMenu") as uilistmenu

    int numberOfMods = Game.GetModCount()
    int index = 0
    while index < numberOfMods
        string modName = Game.GetModName(index)
        listMenu.AddEntryItem(modName)
        index += 1
    endWhile

    int numberOfLightMods = Game.GetLightModCount()
    index = 0
    while index < numberOfLightMods
        string modName = Game.GetLightModName(index)
        listMenu.AddEntryItem(modName)
        index += 1
    endWhile

    listMenu.OpenMenu()

    int selectedIndex = listMenu.GetResultInt()

    if selectedIndex > -1
        if selectedIndex < numberOfMods
            return Game.GetModName(selectedIndex)
        else
            return Game.GetLightModName(selectedIndex - numberOfMods)
        endIf
    endIf
endFunction