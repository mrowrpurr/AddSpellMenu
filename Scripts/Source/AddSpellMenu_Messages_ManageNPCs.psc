scriptName AddSpellMenu_Messages_ManageNPCs hidden

function Show() global
    Actor npc = AddSpellMenu_Npcs.GetCurrentTarget()
    if npc && npc != Game.GetPlayer()
        if AddSpellMenu_Npcs.AnyNpcsSaved()
            if AddSpellMenu_Npcs.IsSaved(npc)
                Show_WithSaves_SavedNpcSelected(npc)
            else
                Show_WithSaves_UnsavedNpcSelected(npc)
            endIf
        else
            Show_NoSaves_NpcSelected(npc)
        endIf
    else
        if AddSpellMenu_Npcs.AnyNpcsSaved()
            Show_WithSaves_NpcNotSelected()
        else
            Show_NoSaves_NpcNotSelected()
        endIf
    endIf
endFunction

function Show_NoSaves_NpcNotSelected() global
    AddSpellMenu_Forms.ManageNPCsMessage_WithNoSelectedNPC_AndNoSavedNPCs().Show()
    AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
endFunction

function Show_WithSaves_NpcNotSelected() global
    int result = AddSpellMenu_Forms.ManageNPCsMessage_WithNoNpcSelected_WithSavedNPCs().Show()
    if result == 0
        OnChoose()
    elseIf result == 2
        OnRemove()
    elseIf result == 3
        OnRename()
    else
        AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    endIf
endFunction

function Show_NoSaves_NpcSelected(Actor npc) global
    AddSpellMenu_Messages_TextReplacement.SetTextReplacement(1, AddSpellMenu_Npcs.GetNpcName(npc))
    int result = AddSpellMenu_Forms.ManageNPCsMessage_WithNPCSelected_WithNoSaves().Show()
    AddSpellMenu_Messages_TextReplacement.ClearAll()
    if result == 0
        OnAddSelected(npc)
    else
        AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    endIf
endFunction

function Show_WithSaves_UnsavedNpcSelected(Actor npc) global
    AddSpellMenu_Messages_TextReplacement.SetTextReplacement(1, AddSpellMenu_Npcs.GetNpcName(npc))
    int result = AddSpellMenu_Forms.ManageNPCsMessage_WithNPCSelectedNotSaved_WithSavedNPCs().Show()
    AddSpellMenu_Messages_TextReplacement.ClearAll()
    if result == 0
        OnChoose()
    elseif result == 1
        OnRemove()
    elseif result == 2
        OnRename()
    elseif result == 3
        OnAddSelected(npc)
    else
        AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    endIf
endFunction

function Show_WithSaves_SavedNpcSelected(Actor npc) global
    AddSpellMenu_Messages_TextReplacement.SetTextReplacement(1, AddSpellMenu_Npcs.GetNpcName(npc))
    string nickname = AddSpellMenu_Npcs.GetSavedNpcNickname(npc)
    if nickname != AddSpellMenu_Npcs.GetNpcName(npc)
        AddSpellMenu_Messages_TextReplacement.SetTextReplacement(2, "\nSaved as: " + nickname)
    endIf
    int result = AddSpellMenu_Forms.ManageNPCsMessage_WithNPCSelectedIsSaved_WithSavedNPCs().Show()
    AddSpellMenu_Messages_TextReplacement.ClearAll()
    if result == 0
        OnChoose()
    elseif result == 1
        OnRemove()
    elseif result == 2
        OnRename()
    elseif result == 3
        OnRemoveSelected(npc)
    else
        AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    endIf
endFunction

function OnChoose() global
    Actor npc = AddSpellMenu_UI.ChooseSavedActor(includePlayer = true)
    AddSpellMenu_Npcs.SetCurrentTarget(npc)
    AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
endFunction

function OnRemove() global
    Actor npc = AddSpellMenu_UI.ChooseSavedActor(includePlayer = false)
    if npc
        AddSpellMenu_Npcs.RemoveSavedNPC(npc)
    endIf
    Show()
endFunction

function OnRename() global
    Actor npc = AddSpellMenu_UI.ChooseSavedActor(includePlayer = false)
    if npc
        string newName = AddSpellMenu_UI.GetTextEntryResultForNpcName(npc)
        if newName != ""
            AddSpellMenu_Npcs.RenameSavedNPC(npc, newName)
        endIf
    endIf
    Show()
endFunction

function OnAddSelected(Actor npc) global
    string nickname = AddSpellMenu_UI.GetTextEntryResultForNpcName(npc)
    AddSpellMenu_Npcs.SaveNPC(npc, nickname)
    Show()
endFunction

function OnRemoveSelected(Actor npc) global
    AddSpellMenu_Npcs.RemoveSavedNPC(npc)
    Show()
endFunction