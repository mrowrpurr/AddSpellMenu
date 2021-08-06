scriptName AddSpellMenu_Menu_SkyUISpellViewer hidden

function Show() global
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
    uimagicmenu magicMenu = uiextensions.GetMenu("UIMagicMenu") as uimagicmenu
    magicMenu.SetPropertyForm("receivingActor", npc)
    magicMenu.SetPropertyBool("Notifications", false)
    magicMenu.OpenMenu(npc)
endFunction
