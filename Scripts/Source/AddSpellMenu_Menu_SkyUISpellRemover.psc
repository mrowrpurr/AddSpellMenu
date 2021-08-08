scriptName AddSpellMenu_Menu_SkyUISpellRemover hidden

; TODO listen for UIMagicMenu close and unregister AddRemoveSpell registration

function Show() global
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript()
    Actor npc = modQuest.CurrentTargetActor
    Actor tempNpc = AddSpellMenu_Npcs.GetTempContainerNpc(resetSpells = true)
    tempNpc.GetBaseObject().SetName("")
    modQuest.RegisterForModEvent("UIMagicMenu_AddRemoveSpell", "OnSpellRemoverAddRemoveSpell")
    modQuest.RegisterForModEvent("UIMagicMenu_CloseMenu", "UnregisterUIMagicMenuEvents")
    uimagicmenu magicMenu = uiextensions.GetMenu("UIMagicMenu") as uimagicmenu
    magicMenu.SetPropertyForm("receivingActor", tempNpc)
    magicMenu.SetPropertyBool("Notifications", false)
    magicMenu.OpenMenu(npc)
endFunction

function OnSpellRemoverAddRemoveSpell(string eventName, string strArg, float numArg, Form formArg) global
    Actor targetActor = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
    Spell theSpell = formArg as Spell
    if targetActor.HasSpell(theSpell)
        targetActor.RemoveSpell(theSpell)
        if targetActor.HasSpell(theSpell)
            Debug.MessageBox(targetActor.GetBaseObject().GetName() + " cannot unlearn starting spell " + theSpell.GetName())
        else
            UI.InvokeForm("CustomMenu", "_root.Menu_mc.MagicMenu_RemoveSpell", theSpell)
            if (targetActor.GetSpellCount() == 0 && targetActor.GetActorBase().GetSpellCount() == 0) || (AddSpellMenu_Options.AreSpecialSpellsEnabled() && targetActor.GetRace().GetSpellCount() == 0 && targetActor.GetSpellCount() == 0 && targetActor.GetActorBase().GetSpellCount() == 0)
                Input.TapKey(1) ; Simulate the Escape key
                AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
            endIf
        endIf
    endIf
endFunction

