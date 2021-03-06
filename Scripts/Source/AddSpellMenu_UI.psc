scriptName AddSpellMenu_UI hidden
{Primary functions for triggering the mod list / spell search UI menus}

; Show the main [AddSpellMenu] (different depending on if NPC in crosshairs or not, etc)
function ShowAddSpellMenu(Actor npc = None) global
    if ! npc
        npc = Game.GetCurrentCrosshairRef() as Actor
        if npc && npc != Game.GetPlayer()
            AddSpellMenu_Messages_NpcMenu.Show(npc)
            return
        endIf
    endIf
    AddSpellMenu_Messages_MainMenu.Show()
endFunction

;;;; TODO split into multiple UI scripts for organization

; Rename, named terribly. And use NAVIGATION instead?
function ShowNpcOrPlayerSpellMenu() global
    Debug.MessageBox("No longer supporting the Myself/NPC menu")
    ; if AddSpellMenu_Npcs.GetCurrentTarget() == Game.GetPlayer()
    ;     AddSpellMenu_Messages.ShowMainMenu()
    ; else
    ;     AddSpellMenu_Messages.ShowNpcMainMenu()
    ; endIf
endFunction

function ShowSpellRemover() global
    AddSpellMenu_Menu_SpellRemover.Show()
endFunction

function ShowSpellViewer() global
    AddSpellMenu_Menu_SpellViewer.Show()
endFunction

function ListMods() global
    string selectedMod = AddSpellMenu_Menu_ModChooser.Show()
    if selectedMod != ""
        ShowSpellsInMod(selectedMod)
    else
        AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    endIf
endFunction

function SearchModsAndSpells(string searchQuery = "") global
    if searchQuery == ""
        searchQuery = AddSpellMenu_Menu_SearchBox.Show()
    endIf
    if searchQuery != ""
        string selection = AddSpellMenu_Menu_ModChooser.Show(searchQuery)
        if selection == "Search all spells"
            ShowSearchResults(searchQuery)
        elseif selection != ""
            ShowSpellsInMod(selection)
        endIf
    else
        AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    endIf
endFunction

function ShowSpellsInMod(string modName) global
    Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)

    bool anyMatchingSpells = AddSpellMenu_SpellSearch.GetAllModSpellsAndPopulateContainerWithMatches( \
        modName, \
        spellsContainer, \
        onlyShowSpellsWithSpellTomes = AddSpellMenu_Forms.GetModQuestScript().OnlyShowSpellsWithSpellTomes)

    if spellsContainer.GetSpellCount() > 0
        AddSpellMenu_Menu_SpellChooser.Show(spellsContainer)
    elseif anyMatchingSpells
        Debug.MessageBox("No spells found in: " + modName + "\nwhich the player does not already have")
        AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    else
        Debug.MessageBox("No spells found in: " + modName)
        AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    endIf
endFunction

function ShowSearchResults(string searchQuery) global
    Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)
    
    bool anyMatchingSpells = AddSpellMenu_SpellSearch.SearchAllSpellsAndPopulateContainerWithMatches( \
        searchQuery, \
        spellsContainer, \
        onlyShowSpellsWithSpellTomes = AddSpellMenu_Forms.GetModQuestScript().OnlyShowSpellsWithSpellTomes)

    if spellsContainer.GetSpellCount() > 0
        AddSpellMenu_Menu_SpellChooser.Show(spellsContainer)
    elseif anyMatchingSpells
        Debug.MessageBox("No spells found matching \"" + searchQuery + "\"\nwhich the player does not already have")
        AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    else
        Debug.MessageBox("No spells found matching \"" + searchQuery + "\"")
        AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    endIf
endFunction

string function GetTextEntryResultForNpcName(Actor npc) global
    uitextentrymenu textInput = uiextensions.GetMenu("UITextEntryMenu") as uitextentrymenu
    if AddSpellMenu_Npcs.IsSaved(npc)
        string nickname = AddSpellMenu_Npcs.GetSavedNpcNickname(npc)
        textInput.SetPropertyString("text", nickname)
    else
        textInput.SetPropertyString("text", AddSpellMenu_Npcs.GetNpcName(npc))
    endIf
    textInput.OpenMenu()
    return textInput.GetResultString()
endFunction

Actor function ChooseSavedActor(bool includePlayer = false) global
    uilistmenu listMenu = uiextensions.GetMenu("UIListMenu") as uilistmenu

    if includePlayer
        listMenu.AddEntryItem("Player")
    endIf

    Form[] actors = AddSpellMenu_Npcs.GetSavedNpcForms()
    string[] names = AddSpellMenu_Npcs.GetSavedNpcNames()

    int index = 0
    while index < actors.Length
        string nickname = names[index]
        string realName = AddSpellMenu_Npcs.GetNpcName(actors[index] as Actor)
        if nickname == realName
            listMenu.AddEntryItem(nickname)
        else
            listMenu.AddEntryItem(nickname + " (" + realName + ")")
        endIf
        index += 1
    endWhile

    listMenu.OpenMenu()

    int result = listMenu.GetResultInt()

    if result > -1
        if includePlayer
            if result == 0
                return Game.GetPlayer()
            else
                return actors[result - 1] as Actor
            endIf
        else
            return actors[result] as Actor
        endIf
    endIf
endFunction