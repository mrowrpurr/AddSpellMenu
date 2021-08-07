scriptName AddSpellMenu_Messages

; Search, List Mods, Remove Spells, Options
function ShowMainMenu() global
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = Game.GetPlayer()
    int result = (AddSpellMenu_Forms.GetModForm(0x82b) as Message).Show()
    int search = 0
    int chooseMod = 1
    int removeSpells = 2
    int options = 3
    if result == search
        AddSpellMenu_UI.SearchModsAndSpells()
    elseIf result == chooseMod
        AddSpellMenu_UI.ListMods()
    elseIf result == removeSpells
        AddSpellMenu_UI.ShowSpellRemover()
    elseIf result == options
        ShowOptions()
    endIf
endFunction

; Search, List Mods, View Spells. Remove Spells, Options
function ShowNpcMainMenu(Actor npc) global
    SetMessageBoxText1(npc.GetBaseObject().GetName())
    int result = (AddSpellMenu_Forms.GetModForm(0x82c) as Message).Show()
    int search = 0
    int chooseMod = 1
    int viewSpells = 2
    int removeSpells = 3
    int options = 3
    if result == search
        AddSpellMenu_UI.SearchModsAndSpells()
    elseIf result == chooseMod
        AddSpellMenu_UI.ListMods()
    elseIf result == viewSpells
        AddSpellMenu_UI.ShowSpellViewer()
    elseIf result == removeSpells
        AddSpellMenu_UI.ShowSpellRemover()
    elseIf result == options
        ShowOptions()
    endIf
endFunction

; Myself, Selected NPC, Options
function ShowWhenNpcInCrosshairs(Actor npc) global
    SetMessageBoxText1(npc.GetBaseObject().GetName())
    int result = (AddSpellMenu_Forms.GetModForm(0x803) as Message).Show()
    int myself = 0
    int selectedNpc = 1
    int options = 2
    if result == myself
        ShowMainMenu()
    elseIf result == selectedNpc
        AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = npc
        ShowNpcMainMenu(npc)
    elseIf result == options
        ShowOptions()
    endIf
endFunction

function ShowOptions() global
    if AddSpellMenu_Options.IsSpellTomeRequired()
        SetMessageBoxText1("ON")
    else
        SetMessageBoxText1("OFF")
    endIf

    if AddSpellMenu_Options.AreSpecialSpellsEnabled()
        SetMessageBoxText2("ON")
    else
        SetMessageBoxText2("OFF")
    endIf
    
    int result = (AddSpellMenu_Forms.GetModForm(0x81b) as Message).Show()
    int toggleSpellTomeRequirement = 0
    int toggleSpecialSpells = 1
    int back = 2
    if result == toggleSpellTomeRequirement
        AddSpellMenu_Options.ToggleSpellTomeRequirement()
        ShowOptions()
    elseIf result == toggleSpecialSpells
        AddSpellMenu_Options.ToggleSpecialSpells()
        ShowOptions()
    elseIf result == back
        ; TODO
    endIf
endFunction

; TODO
; function ShowWhenNpcInCrosshairsAndOthersAvailable() global
;     int result = (AddSpellMenu_Forms.GetModForm(0x800) as Message).Show()
; endFunction

function SetMessageBoxText1(string text) global
    SetMessageBoxText(1, text)
endFunction

function SetMessageBoxText2(string text) global
    SetMessageBoxText(2, text)
endFunction

function SetMessageBoxText(int textItemNumber, string text) global
    if textItemNumber < 1 || textItemNumber > 10
        Debug.Trace("Can only set message numbers 1 thru 10")
    else
        SetQuestAliasText("MessageBoxText" + textItemNumber, text)
    endIf
endFunction

function SetQuestAliasText(string questAliasName, string text) global
    Debug.MessageBox("Getting alias: " + questAliasName)
    ReferenceAlias theAlias = AddSpellMenu_Forms.GetModQuestScriptv3().GetAliasByName(text) as ReferenceAlias
    theAlias.GetReference().GetBaseObject().SetName(text)
endFunction