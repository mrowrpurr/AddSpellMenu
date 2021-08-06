scriptName AddSpellMenu_Menu_SkyUISpellRemover hidden

; TODO listen for UIMagicMenu close and unregister AddRemoveSpell registration

function Show() global
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
    AddSpellMenu_Forms.GetModQuestScript().RegisterForModEvent("UIMagicMenu_AddRemoveSpell", "OnSpellChooserAddRemoveSpell")
    uimagicmenu magicMenu = uiextensions.GetMenu("UIMagicMenu") as uimagicmenu
    magicMenu.SetPropertyForm("receivingActor", npc)
    magicMenu.SetPropertyBool("Notifications", false)
    magicMenu.OpenMenu(npc)
    AddSpellMenu_Forms.GetModQuestScript().CurrentMagicMenu = magicMenu
endFunction

function OnSpellChooserAddRemoveSpell(string eventName, string strArg, float numArg, Form formArg) global
    Actor targetActor = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
    uimagicmenu magicMenu = AddSpellMenu_Forms.GetModQuestScript().CurrentMagicMenu
    Spell theSpell = formArg as Spell

    if targetActor.HasSpell(theSpell)
        targetActor.RemoveSpell(theSpell)
        magicMenu.SetPropertyForm("RemoveSpell", theSpell)
    endIf
endFunction

