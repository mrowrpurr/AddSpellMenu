scriptName AddSpellMenu_Menu_SpellViewer hidden

function Show() global
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript()
    Actor npc = modQuest.CurrentTargetActor
    if npc
        if npc.GetSpellCount() > 0
            if AddSpellMenu_SkyUI.IsSkyUIInstalled() && ! AddSpellMenu_Options.AreSpecialSpellsEnabled()
                AddSpellMenu_Menu_SkyUISpellViewer.Show()
            else
                AddSpellMenu_Menu_ListSpellViewer.Show()
                AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
            endIf
        elseif ! AddSpellMenu_SkyUI.IsSkyUIInstalled() && npc.GetActorBase().GetSpellCount() > 0
            AddSpellMenu_Menu_ListSpellViewer.Show()
            AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
        elseif AddSpellMenu_Options.AreSpecialSpellsEnabled() && npc.GetRace().GetSpellCount() > 0
            AddSpellMenu_Menu_ListSpellViewer.Show()
            AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
        else
            Debug.MessageBox(AddSpellMenu_Npcs.GetNpcName(npc) + " has no spells")
            AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
        endIf
    endIf
endFunction
