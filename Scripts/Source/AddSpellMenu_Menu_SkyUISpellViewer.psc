scriptName AddSpellMenu_Menu_SkyUISpellViewer hidden

function Show() global
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript()
    modQuest.RegisterForModEvent("UIMagicMenu_CloseMenu", "UnregisterUIMagicMenuEvents")
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
    Actor tempNpc = AddSpellMenu_Npcs.GetTempContainerNpc(resetSpells = true)
    tempNpc.GetBaseObject().SetName("")
    uimagicmenu magicMenu = uiextensions.GetMenu("UIMagicMenu") as uimagicmenu
    magicMenu.SetPropertyForm("receivingActor", tempNpc)
    magicMenu.SetPropertyBool("Notifications", false)
    magicMenu.SetPropertyBool("HandleAddRemoveEvents", false)
    magicMenu.OpenMenu(npc)
endFunction