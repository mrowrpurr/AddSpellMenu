scriptName AddSpellMenu_Messages

; Search, List Mods, Remove Spells, Options
function ShowMainMenu() global
    AddSpellMenu_Forms.GetModQuestScriptv3().PreviousMenuName = "ShowMainMenu"
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = Game.GetPlayer()
    int result = AddSpellMenu_Forms.MainMenuMessage().Show()
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
function ShowNpcMainMenu(Actor npc = None) global
    if npc
        AddSpellMenu_Forms.GetModQuestScriptv3().MenuSelectedNpc = npc
    else
        npc = AddSpellMenu_Forms.GetModQuestScriptv3().MenuSelectedNpc
    endIf
    AddSpellMenu_Forms.GetModQuestScriptv3().PreviousMenuName = "ShowNpcMainMenu"
    SetMessageBoxText1(npc.GetBaseObject().GetName())

    if npc.GetSpellCount() > 0 && (AddSpellMenu_SkyUI.IsSkyUIInstalled() || AddSpellMenu_Options.AreSpecialSpellsEnabled())
        ShowNpcMainMenu_WithViewAndRemove()
    else
        ShowNpcMainMenu_WithoutViewAndRemove()
    endIf
endFunction

function ShowNpcMainMenu_WithViewAndRemove() global
    int result = AddSpellMenu_Forms.NpcMainMenuMessage().Show()
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

function ShowNpcMainMenu_WithoutViewAndRemove(Actor npc = None) global
    int result = AddSpellMenu_Forms.NpcMainMenuMessageWithoutViewAndRemove().Show()
    int search = 0
    int chooseMod = 1
    int options = 2
    if result == search
        AddSpellMenu_UI.SearchModsAndSpells()
    elseIf result == chooseMod
        AddSpellMenu_UI.ListMods()
    elseIf result == options
        ShowOptions()
    endIf
endFunction

; Myself, Selected NPC, Options
function ShowWhenNpcInCrosshairs(Actor npc) global
    SetMessageBoxText1(npc.GetBaseObject().GetName())
    int result = AddSpellMenu_Forms.ChooseSelfOrNpcMessage().Show()
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
        Debug.MessageBox("Managing NPCs not yet implemented")
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
        Debug.MessageBox("Managing NPCs not yet implemented")
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
        Debug.MessageBox("Managing NPCs not yet implemented")
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
        Debug.MessageBox("Managing NPCs not yet implemented")
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

function GoBack() global
    if AddSpellMenu_Forms.GetModQuestScriptv3().PreviousMenuName == "ShowMainMenu"
        ShowMainMenu()
    elseIf AddSpellMenu_Forms.GetModQuestScriptv3().PreviousMenuName == "ShowNpcMainMenu"
        ShowNpcMainMenu()
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
    ReferenceAlias theAlias = AddSpellMenu_Forms.GetModQuestScriptv3().GetAliasByName(questAliasName) as ReferenceAlias
    theAlias.GetReference().GetBaseObject().SetName(text)
endFunction