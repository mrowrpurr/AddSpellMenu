scriptName AddSpellMenu_Menu_ModChooser hidden

; Returns "Search all spells" if no matching mods found
; or if the user explicitly chooses to search all spells
string function Show(string searchQuery = "") global
    if searchQuery == ""
        return ShowModList()
    else
        return SearchModList(searchQuery)
    endIf
endFunction

string function ShowModList() global
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
    else
        return ""
    endIf
endFunction

string function SearchModList(string searchQuery = "") global
    string searchAllSpellsEntryText = "Search all spells"
    string[] searchModNames = new string[128]
    int searchModIndex = 0

    uilistmenu listMenu = uiextensions.GetMenu("UIListMenu") as uilistmenu

    listMenu.AddEntryItem(searchAllSpellsEntryText)
    searchModNames[0] = searchAllSpellsEntryText
    searchModIndex += 1
    
    int numberOfMods = Game.GetModCount()
    int index = 0
    while index < numberOfMods
        string modName = Game.GetModName(index)
        if StringUtil.Find(modName, searchQuery) > -1
            if searchModIndex < 128
                searchModNames[searchModIndex] = modName
                searchModIndex += 1
                listMenu.AddEntryItem(modName)
            else
                Debug.Notification("Too many mod search result, not including: " + modName)
            endIf
        endIf
        index += 1
    endWhile

    int numberOfLightMods = Game.GetLightModCount()
    index = 0
    while index < numberOfLightMods
        string modName = Game.GetLightModName(index)
        if StringUtil.Find(modName, searchQuery) > -1
            if searchModIndex < 128
                searchModNames[searchModIndex] = modName
                searchModIndex += 1
                listMenu.AddEntryItem(modName)
            else
                Debug.Notification("Too many mod search result, not including: " + modName)
            endIf
        endIf
        index += 1
    endWhile

    if searchModIndex > 1
        listMenu.OpenMenu()
        int selectedIndex = listMenu.GetResultInt()
        if selectedIndex == 0
            return searchAllSpellsEntryText
        elseif selectedIndex > 0
            return searchModNames[selectedIndex]
        endIf
    else
        return searchAllSpellsEntryText
    endIf
endFunction