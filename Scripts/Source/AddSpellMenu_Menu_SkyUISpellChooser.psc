scriptName AddSpellMenu_Menu_SkyUISpellChooser hidden

function Show(Actor spellsContainer) global
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript()
    modQuest.RegisterForModEvent("UIMagicMenu_AddRemoveSpell", "OnSpellChooserAddRemoveSpell")
    modQuest.RegisterForModEvent("UIMagicMenu_CloseMenu", "UnregisterUIMagicMenuEvents")
    uimagicmenu magicMenu = uiextensions.GetMenu("UIMagicMenu") as uimagicmenu
    magicMenu.SetPropertyForm("receivingActor", modQuest.CurrentTargetActor)
    magicMenu.SetPropertyBool("Notifications", false)
    magicMenu.SetPropertyBool("Restricted", false)
    magicMenu.SetPropertyBool("HandleAddRemoveEvents", true)
    magicMenu.OpenMenu(spellsContainer)
endFunction

function OnSpellChooserAddRemoveSpell(string eventName, string strArg, float numArg, Form formArg) global
    Actor targetActor = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
    Spell theSpell = formArg as Spell

    if ! targetActor.HasSpell(theSpell)
        targetActor.AddSpell(theSpell)
        AddAsKnownSpellToSpellChooserUI(theSpell)
    endIf
endFunction

function AddAsKnownSpellToSpellChooserUI(Spell theSpell) global
    Actor tempNpc = AddSpellMenu_Npcs.GetTempContainerNpc(resetSpells = true, giveTargetActorName = true)
    tempNpc.AddSpell(theSpell)
    UI.InvokeForm("CustomMenu", "_root.Menu_mc.MagicMenu_SetSecondaryActor", tempNpc)
endFunction
