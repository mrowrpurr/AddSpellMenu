scriptName AddSpellMenu_UI hidden
{Primary functions for triggering the mod list / spell search UI menus}

; Show the main [AddSpellMenu]
function ShowAddSpellMenu() global
    Actor actorRef = Game.GetCurrentCrosshairRef() as Actor
    if actorRef
        ; Test by going into Skyrim and Load Game then COC and then try this (forks should be gone)
        ReferenceAlias messageAlias1 = AddSpellMenu_Forms.GetModQuestScriptv3().GetAliasByName("MessageBoxText1") as ReferenceAlias
        messageAlias1.GetReference().GetBaseObject().SetName(actorRef.GetBaseObject().GetName())
        AddSpellMenu_Messages.ShowWhenNpcInCrosshairs()
    else
        AddSpellMenu_Messages.ShowWhenNoNpcInCrosshairs()
    endIf
endFunction

; int selection = AddSpellMenu_Forms.GetMessage().Show()
; int searchIndex = 0
; int listIndex = 1
; int removeIndex = 2
; int cancelIndex = 3
; if selection == searchIndex
;     AddSpellMenu_UI.SearchModsAndSpells()
; elseif selection == listIndex
;     AddSpellMenu_UI.ListMods()
; elseif selection == removeIndex
;     AddSpellMenu_Menu_SpellRemover.Show()
; endIf

function ShowNpcAddSpellMenu() global
    int selection = AddSpellMenu_Forms.GetNpcMessage().Show()
    int addIndex = 0
    int viewIndex = 1
    int removeIndex = 2
    int cancelIndex = 3
    if selection == addIndex
        AddSpellMenu_UI.ShowAddSpellMenu()
    elseIf selection == viewIndex
        AddSpellMenu_Menu_SpellViewer.Show()
    elseIf selection == removeIndex
        AddSpellMenu_Menu_SpellRemover.Show()
    endIf
endFunction

function ListMods() global
    string selectedMod = AddSpellMenu_Menu_ModChooser.Show()
    if selectedMod != ""
        ShowSpellsInMod(selectedMod)
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
    else
        Debug.MessageBox("No spells found in: " + modName)
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
    else
        Debug.MessageBox("No spells found matching \"" + searchQuery + "\"")
    endIf
endFunction