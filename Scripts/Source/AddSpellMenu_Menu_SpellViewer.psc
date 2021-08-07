scriptName AddSpellMenu_Menu_SpellViewer hidden

function Show() global
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript()
    Actor npc = modQuest.CurrentTargetActor
    if npc
        if npc.GetSpellCount() > 0
            if AddSpellMenu_SkyUI.IsSkyUIInstalled()
                AddSpellMenu_Forms.GetModQuestScriptv3().ListenForUIMagicMenuEvents()
                AddSpellMenu_Menu_SkyUISpellViewer.Show()
            else
                AddSpellMenu_Menu_ListSpellViewer.Show()
                AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
            endIf
        else
            Debug.MessageBox(npc.GetBaseObject().GetName() + " has no spells")
        endIf
    endIf
endFunction
