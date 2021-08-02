scriptName AddSpellMenu_Menu_ModChooser hidden

; Returns "Search all spells" if no matching mods found
; or if the user explicitly chooses to search all spells
string function Show(string searchQuery = "") global
    string searchAllSpellsEntryText = "Search all spells"
    string[] searchModNames = new string[128]
    int searchModIndex = 0

    uilistmenu listMenu = uiextensions.GetMenu("UIListMenu") as uilistmenu

    if searchQuery != "" ; Try this with: if searchQuery
        listMenu.AddEntryItem(searchAllSpellsEntryText)
        searchModNames[0] = searchAllSpellsEntryText
        searchModIndex += 1
    endIf
    
    int numberOfMods = Game.GetModCount()
    int index = 0
    while index < numberOfMods
        string modName = Game.GetModName(index)
        if searchQuery != ""
            if StringUtil.Find(modName, searchQuery) > -1
                if searchModIndex < 128
                    searchModNames[searchModIndex] = modName
                    searchModIndex += 1
                    listMenu.AddEntryItem(modName)
                else
                    Debug.Notification("Too many mod search result, not including: " + modName)
                endIf
            endIf
        else
            listMenu.AddEntryItem(modName)
        endIf
        index += 1
    endWhile

    int numberOfLightMods = Game.GetLightModCount()
    index = 0
    while index < numberOfLightMods
        string modName = Game.GetLightModName(index)
        if searchQuery != ""
            if StringUtil.Find(modName, searchQuery) > -1
                if searchModIndex < 128
                    searchModNames[searchModIndex] = modName
                    searchModIndex += 1
                    listMenu.AddEntryItem(modName)
                else
                    Debug.Notification("Too many mod search result, not including: " + modName)
                endIf
            endIf
        else
            listMenu.AddEntryItem(modName)
        endIf
        index += 1
    endWhile

    if searchQuery != ""
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
    else
        listMenu.OpenMenu()
        int selectedIndex = listMenu.GetResultInt()
        if selectedIndex > -1
            if selectedIndex < numberOfMods
                return Game.GetModName(selectedIndex)
            else
                return Game.GetLightModName(selectedIndex - numberOfMods)
            endIf
        endIf
    endIf
endFunction