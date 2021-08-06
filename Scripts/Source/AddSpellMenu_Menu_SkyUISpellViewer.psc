scriptName AddSpellMenu_Menu_SkyUISpellViewer hidden

function Show() global
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
    Actor tempNpc = AddSpellMenu_Npcs.GetTempContainerNpc(resetSpells = true)
    tempNpc.GetBaseObject().SetName("")
    uimagicmenu magicMenu = uiextensions.GetMenu("UIMagicMenu") as uimagicmenu
    magicMenu.SetPropertyForm("receivingActor", tempNpc)
    magicMenu.SetPropertyBool("Notifications", false)
    magicMenu.OpenMenu(npc)
endFunction
