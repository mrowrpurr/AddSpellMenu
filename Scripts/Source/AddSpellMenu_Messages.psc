scriptName AddSpellMenu_Messages

; TODO DEPRECATE ME ;
;;;;;;;;;;;;;;;;;;;;;



function GoBack() global
    if AddSpellMenu_Forms.GetModQuestScriptv3().PreviousMenuName == "ShowMainMenu"
        ShowMainMenu()
    elseIf AddSpellMenu_Forms.GetModQuestScriptv3().PreviousMenuName == "ShowNpcMainMenu"
        ShowNpcMainMenu()
    endIf
endFunction

; Search, List Mods, Remove Spells, Options
function ShowMainMenu() global
    Debug.MessageBox("DEPRECATED MainMenu")
endFunction

; Search, List Mods, View Spells. Remove Spells, Options
function ShowNpcMainMenu(Actor npc = None) global
    Debug.MessageBox("DEPRECATED NpcMainMenu")
endFunction

function ShowNpcMainMenu_WithViewAndRemove() global
    Debug.MessageBox("DEPRECATED Npc Main Menu with spells")
endFunction

function ShowNpcMainMenu_WithoutViewAndRemove(Actor npc = None) global
    Debug.MessageBox("DEPRECATED Npc Main Menu withOUT spells")
endFunction

; Myself, Selected NPC, Options
function ShowWhenNpcInCrosshairs(Actor npc) global
    Debug.MessageBox("We don't use this menu for myself/npc anymore")
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

    Actor player = Game.GetPlayer()
    if player.HasSpell(AddSpellMenu_Forms.GetSpell()) && player.HasSpell(AddSpellMenu_Forms.GetPower())
        ShowOptions_LearnNeitherSpellNorPower()
    elseIf player.HasSpell(AddSpellMenu_Forms.GetSpell())
        ShowOptions_LearnPower()
    elseIf player.HasSpell(AddSpellMenu_Forms.GetPower())
        ShowOptions_LearnSpell()
    else
        ShowOptions_LearnSpellAndPower()
    endIf
endFunction

function ShowOptions_LearnSpellAndPower() global
    int result = AddSpellMenu_Forms.OptionsMessage_WithSpellAndPower().Show()
    int manageNpcs = 0
    int toggleSpellTomeRequirement = 1
    int toggleSpecialSpells = 2
    int learnPower = 3
    int learnSpell = 4
    int back = 5

    if result == manageNpcs
        ShowManageNpcs()
    elseIf result == toggleSpellTomeRequirement
        AddSpellMenu_Options.ToggleSpellTomeRequirement()
    elseIf result == toggleSpecialSpells
        AddSpellMenu_Options.ToggleSpecialSpells()
    elseIf result == learnPower
        AddSpellMenu_Options.TeachPower()
    elseIf result == learnSpell
        AddSpellMenu_Options.TeachSpell()
    elseif result == back
        GoBack()
        return
    endIf

    ShowOptions()
endFunction

function ShowOptions_LearnSpell() global
    int result = AddSpellMenu_Forms.OptionsMessage_WithSpell().Show()
    int manageNpcs = 0
    int toggleSpellTomeRequirement = 1
    int toggleSpecialSpells = 2
    int learnSpell = 3
    int back = 4

    if result == manageNpcs
        ShowManageNpcs()
    elseIf result == toggleSpellTomeRequirement
        AddSpellMenu_Options.ToggleSpellTomeRequirement()
    elseIf result == toggleSpecialSpells
        AddSpellMenu_Options.ToggleSpecialSpells()
    elseIf result == learnSpell
        AddSpellMenu_Options.TeachSpell()
    elseif result == back
        GoBack()
        return
    endIf

    ShowOptions()
endFunction

function ShowOptions_LearnPower() global
    int result = AddSpellMenu_Forms.OptionsMessage_WithPower().Show()
    int manageNpcs = 0
    int toggleSpellTomeRequirement = 1
    int toggleSpecialSpells = 2
    int learnPower = 3
    int back = 4

    if result == manageNpcs
        ShowManageNpcs()
    elseIf result == toggleSpellTomeRequirement
        AddSpellMenu_Options.ToggleSpellTomeRequirement()
    elseIf result == toggleSpecialSpells
        AddSpellMenu_Options.ToggleSpecialSpells()
    elseIf result == learnPower
        AddSpellMenu_Options.TeachPower()
    elseif result == back
        GoBack()
        return
    endIf

    ShowOptions()
endFunction

function ShowOptions_LearnNeitherSpellNorPower() global
    int result = AddSpellMenu_Forms.OptionsMessage_WithNeitherSpellNorPower().Show()
    int manageNpcs = 0
    int toggleSpellTomeRequirement = 1
    int toggleSpecialSpells = 2
    int back = 3

    if result == manageNpcs
        ShowManageNpcs()
    elseIf result == toggleSpellTomeRequirement
        AddSpellMenu_Options.ToggleSpellTomeRequirement()
    elseIf result == toggleSpecialSpells
        AddSpellMenu_Options.ToggleSpecialSpells()
    elseif result == back
        GoBack()
        return
    endIf

    ShowOptions()
endFunction

function ShowManageNpcs() global

endFunction

function ShowNPCsMessage_WithNPCSelected_WithSavedNPCs(Actor npc) global
    bool npcIsSaved = AddSpellMenu_Npcs.IsSaved(npc)
    int choose = 0
    int remove = 1
    int rename = 2
    int addOrRemove = 3

    int addSelected = 3 ; TODO Add should NOT show up if already added! only Remove
    int removeSelected = 4 ; or this will be Back if the NPC is not saved

    int result
    Actor selectedActor

    if npcIsSaved
        string nickname = AddSpellMenu_Npcs.GetSavedNpcNickname(npc)
        if nickname != npc.GetBaseObject().GetName()
            SetMessageBoxText2("\nNickname: " + nickname)
        endIf
        result = AddSpellMenu_Forms.ManageNPCsMessage_WithNPCSelectedIsSaved_WithSavedNPCs().Show()
    else
        result = AddSpellMenu_Forms.ManageNPCsMessage_WithNPCSelectedNotSaved_WithSavedNPCs().Show()
    endIf

    if result == choose
        selectedActor = AddSpellMenu_UI.ChooseSavedActor()
        if selectedActor
            AddSpellMenu_Npcs.SetCurrentTarget(selectedActor)
            ShowNpcMainMenu(selectedActor)
            return
        endIf
    elseIf result == remove

    elseIf result == rename

    elseIf result == addSelected
        string chosenName = AddSpellMenu_UI.GetTextEntryResultForNpcName(npc)
        if chosenName != ""
            AddSpellMenu_Npcs.SaveNPC(npc, chosenName)
        endIf
        ShowManageNpcs()
    elseIf result == removeSelected && npcIsSaved

    else
        ShowOptions()
    endIf
endFunction

function ShowNPCsMessage_WithNPCSelected(Actor npc) global
    int result = AddSpellMenu_Forms.ManageNPCsMessage_WithNPCSelected().Show()
    int addSelected = 0
    int back = 1

    if result == addSelected
        string chosenName = AddSpellMenu_UI.GetTextEntryResultForNpcName(npc)
        if chosenName != ""
            AddSpellMenu_Npcs.SaveNPC(npc, chosenName)
        endIf
        ShowManageNpcs()
    elseIf result == back
        ShowOptions()
    endIf
endFunction

function ShowNPCsMessage_WithSavedNPCs(Actor npc) global
    int choose = 0
    int remove = 1
    int rename = 2

    int result = AddSpellMenu_Forms.ManageNPCsMessage_WithSavedNPCs().Show()

    if result == choose
        ACtor selectedActor = AddSpellMenu_UI.ChooseSavedActor()
        if selectedActor
            AddSpellMenu_Npcs.SetCurrentTarget(selectedActor)
            ShowNpcMainMenu(selectedActor)
            return
        endIf
    elseIf result == remove

    elseIf result == rename

    else
        ShowOptions()
    endIf
endFunction

function ShowNPCsMessage_WithNoSelectedNPC_AndNoSavedNPCs(Actor npc) global
    Debug.MessageBox("Nothing")
    AddSpellMenu_Forms.ManageNPCsMessage_WithNoSelectedNPC_AndNoSavedNPCs().Show()
    Debug.MessageBox("Going back to options...")
    ShowOptions()
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
    ReferenceAlias theAlias = AddSpellMenu_Forms.GetModQuestScriptv3().GetAliasByName(questAliasName) as ReferenceAlias
    theAlias.GetReference().GetBaseObject().SetName(text)
endFunction