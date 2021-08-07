scriptName AddSpellMenu_Messages_ManageNPCs hidden

function Show() global
    AddSpellMenu_Messages_Navigation.Visit("ManageNPCs")
    Actor npc = AddSpellMenu_Npcs.GetCurrentTarget()
    if npc && npc != Game.GetPlayer()
        if AddSpellMenu_Npcs.AnyNpcsSaved()
            if AddSpellMenu_Npcs.IsSaved(npc)
                Show_WithSaves_SavedNpcSelected()
            else
                Show_WithSaves_UnsavedNpcSelected()
            endIf
        else
            Show_NoSaves_NpcSelected()
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
    AddSpellMenu_Messages_Navigation.GoBack(2)
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
        AddSpellMenu_Messages_Navigation.GoBack()
    endIf
endFunction

function Show_NoSaves_NpcSelected() global
    int result = AddSpellMenu_Forms.ManageNPCsMessage_WithNPCSelected_WithNoSaves().Show()
    if result == 0
        OnAddSelected()
    else
        AddSpellMenu_Messages_Navigation.GoBack()
    endIf
endFunction

function Show_WithSaves_UnsavedNpcSelected() global
    int result = AddSpellMenu_Forms.ManageNPCsMessage_WithNPCSelectedNotSaved_WithSavedNPCs().Show()
    if result == 0
        OnChoose()
    elseif result == 1
        OnRemove()
    elseif result == 2
        OnRename()
    elseif result == 3
        OnAddSelected()
    else
        AddSpellMenu_Messages_Navigation.GoBack()
    endIf
endFunction

function Show_WithSaves_SavedNpcSelected() global
    int result = AddSpellMenu_Forms.ManageNPCsMessage_WithNPCSelectedIsSaved_WithSavedNPCs().Show()
    if result == 0
        OnChoose()
    elseif result == 1
        OnRemove()
    elseif result == 2
        OnRename()
    elseif result == 3
        OnRemoveSelected()
    else
        AddSpellMenu_Messages_Navigation.GoBack()
    endIf
endFunction

function OnChoose() global
    Debug.MessageBox("CHOOSE")
    AddSpellMenu_Messages_Navigation.GoBack()
endFunction

function OnRemove() global
    Debug.MessageBox("REMOVE")
    AddSpellMenu_Messages_Navigation.GoBack()
endFunction

function OnRename() global
    Debug.MessageBox("RENAME")
    AddSpellMenu_Messages_Navigation.GoBack()
endFunction

function OnAddSelected() global
    Debug.MessageBox("ADD SELECTED")
    AddSpellMenu_Messages_Navigation.GoBack()
endFunction

function OnRemoveSelected() global
    Debug.MessageBox("REMOVE SELECTED")
    AddSpellMenu_Messages_Navigation.GoBack()
endFunction