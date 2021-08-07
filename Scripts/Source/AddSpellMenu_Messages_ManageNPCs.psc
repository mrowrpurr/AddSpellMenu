scriptName AddSpellMenu_Messages_ManageNPCs hidden

function Show() global
    AddSpellMenu_Messages_Navigation.Visit("ManageNPCs")
    Actor npc = AddSpellMenu_Npcs.GetCurrentTarget()
    if npc && npc != Game.GetPlayer()
        if AddSpellMenu_Npcs.AnyNpcsSaved()
            if AddSpellMenu_Npcs.IsSaved(npc)
                Show_Saves_SavedNpcSelected()
            else
                Show_Saves_UnsavedNpcSelected()
            endIf
        else
            Show_NoSaves_NpcSelected()
        endIf
    else
        if AddSpellMenu_Npcs.AnyNpcsSaved()
            Show_Saves_NpcNotSelected()
        else
            Show_NoSaves_NpcNotSelected()
        endIf
    endIf
endFunction

function Show_NoSaves_NpcNotSelected() global
endFunction

function Show_Saves_NpcNotSelected() global
endFunction

function Show_NoSaves_NpcSelected() global
endFunction

function Show_Saves_UnsavedNpcSelected() global
endFunction

function Show_Saves_SavedNpcSelected() global
endFunction