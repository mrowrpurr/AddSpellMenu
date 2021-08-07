scriptName AddSpellMenu_Menu_SpellRemover hidden

function Show() global
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript()
    Actor npc = modQuest.CurrentTargetActor
    if npc
        if npc.GetSpellCount() > 0
            if AddSpellMenu_SkyUI.IsSkyUIInstalled() && ! AddSpellMenu_Options.AreSpecialSpellsEnabled()
                AddSpellMenu_Forms.GetModQuestScriptv3().ListenForUIMagicMenuEvents()
                AddSpellMenu_Menu_SkyUISpellRemover.Show()
            else
                AddSpellMenu_Menu_ListSpellRemover.Show()
                AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
            endIf
        elseif ! AddSpellMenu_SkyUI.IsSkyUIInstalled() && npc.GetActorBase().GetSpellCount() > 0
            AddSpellMenu_Menu_ListSpellRemover.Show()
            AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
        elseif AddSpellMenu_Options.AreSpecialSpellsEnabled() && npc.GetRace().GetSpellCount() > 0
            AddSpellMenu_Menu_ListSpellRemover.Show()
            AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
        else
            Debug.MessageBox(npc.GetBaseObject().GetName() + " has no spells")
            AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
        endIf
    endIf
endFunction
