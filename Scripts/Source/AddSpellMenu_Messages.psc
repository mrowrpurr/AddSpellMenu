scriptName AddSpellMenu_Messages

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
        ; TODO
    endIf
endFunction

function ShowNpcMainMenu(Actor npc) global
    SetMessageBoxText1(npc.GetBaseObject().GetName())
    int result = (AddSpellMenu_Forms.GetModForm(0x81e) as Message).Show()
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
        ; TODO
    endIf
endFunction

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
        ; TODO
    endIf
endFunction

function ShowWhenNpcInCrosshairsAndOthersAvailable() global
    int result = (AddSpellMenu_Forms.GetModForm(0x800) as Message).Show()
endFunction

function SetMessageBoxText1(string text) global
    ReferenceAlias messageAlias1 = AddSpellMenu_Forms.GetModQuestScriptv3().GetAliasByName("MessageBoxText1") as ReferenceAlias
    messageAlias1.GetReference().GetBaseObject().SetName(text)
endFunction