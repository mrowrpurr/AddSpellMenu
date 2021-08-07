scriptName AddSpellMenu_UI hidden
{Primary functions for triggering the mod list / spell search UI menus}

; Show the main [AddSpellMenu] (different depending on if NPC in crosshairs or not, etc)
function ShowAddSpellMenu() global
    AddSpellMenu_Messages_MainMenu.Show(Game.GetCurrentCrosshairRef() as Actor)
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
        if AddSpellMenu_SkyUI.IsSkyUIInstalled()
            AddSpellMenu_Forms.GetModQuestScriptv3().ListenForUIMagicMenuEvents()
        endIf
        ShowSpellsInMod(selectedMod)
    else
        AddSpellMenu_Messages_Navigation.GoBack()
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
        AddSpellMenu_Messages_Navigation.GoBack()
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
        AddSpellMenu_Messages_Navigation.GoBack()
    else
        Debug.MessageBox("No spells found in: " + modName)
        AddSpellMenu_Messages_Navigation.GoBack()
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
        AddSpellMenu_Messages_Navigation.GoBack()
    else
        Debug.MessageBox("No spells found matching \"" + searchQuery + "\"")
        AddSpellMenu_Messages_Navigation.GoBack()
    endIf
endFunction

function ShowOptionsMenu() global
    AddSpellMenu_Messages.ShowOptions()
endFunction

string function GetTextEntryResultForNpcName(Actor npc) global
    uitextentrymenu textInput = uiextensions.GetMenu("UITextEntryMenu") as uitextentrymenu
    textInput.SetPropertyString("text", npc.GetBaseObject().GetName())
    textInput.OpenMenu()
    return textInput.GetResultString()
endFunction

Actor function ChooseSavedActor() global
    uilistmenu listMenu = uiextensions.GetMenu("UIListMenu") as uilistmenu

    listMenu.AddEntryItem("Player")

    Form[] actors = AddSpellMenu_Npcs.GetSavedNpcForms()
    string[] names = AddSpellMenu_Npcs.GetSavedNpcNames()

    int index = 0
    while index < actors.Length
        string nickname = names[index]
        string realName = (actors[index] as Actor).GetBaseObject().GetName()
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
        if result == 0
            return Game.GetPlayer()
        else
            return actors[result + 1] as Actor
        endIf
    endIf
endFunction