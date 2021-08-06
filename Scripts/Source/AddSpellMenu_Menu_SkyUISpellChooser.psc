scriptName AddSpellMenu_Menu_SkyUISpellChooser hidden

function Show(Actor spellsContainer) global
    AddSpellMenu_Forms.GetModQuestScript().RegisterForModEvent("UIMagicMenu_AddRemoveSpell", "OnSpellChooserAddRemoveSpell")
    uimagicmenu magicMenu = uiextensions.GetMenu("UIMagicMenu") as uimagicmenu
    magicMenu.SetPropertyForm("receivingActor", AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor)
    magicMenu.SetPropertyBool("Notifications", false)
    magicMenu.SetPropertyBool("Restricted", false)
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
