scriptName AddSpellMenu_Npcs hidden

Actor function GetTraderContainerNpc(bool resetSpells = true) global
    return GetModActor(0x1831, resetSpells)
endFunction

Actor function GetTempContainerNpc(bool resetSpells = true, bool givePlayersName = true) global
    Actor tempActor = GetModActor(0x22f7, resetSpells)
    tempActor.GetBaseObject().SetName(Game.GetPlayer().GetBaseObject().GetName())
    return tempActor
endFunction

function ResetSpells(Actor npc) global
    while npc.GetSpellCount() > 0
        npc.RemoveSpell(npc.GetNthSpell(0))
    endWhile
endFunction

Actor function GetModActor(int actorReferenceId, bool resetSpells = false) global
    Actor theActor = Game.GetFormFromFile(actorReferenceId, "AddSpellMenu.esp") as Actor
    if theActor == None
        Debug.MessageBox("The actor is NONE for ID: " + actorReferenceId)
    endIf
    if resetSpells
        ResetSpells(theActor)
    endIf
    return theActor
endFunction


; function AddSpells(Spell[] spells) global
;     Actor npc = Get()
;     int index = 0
;     while index < spells.Length
;         npc.AddSpell(spells[index])
;         index += 1
;     endWhile
; endFunction

; function Trade(Actor secondaryActor, AddSpellMenu_QuestScript modQuest) global
;     uimagicmenu magicMenu = uiextensions.GetMenu("UIMagicMenu") as uimagicmenu
;     magicMenu.SetPropertyForm("receivingActor", secondaryActor)
;     magicMenu.SetPropertyBool("Notifications", false)
;     modQuest.RegisterForModEvent("UIMagicMenu_AddRemoveSpell", "OnBarterSpell")
;     magicMenu.OpenMenu(Get())
; endFunction

; function OnBarterSpell(string eventName, string strArg, float numArg, Form formArg) global
;     Actor player = Game.GetPlayer()
;     Spell theSpell = formArg as Spell
;     player.AddSpell(theSpell)

;     Actor tradedSpellActor = Game.GetFormFromFile(0x22f7, "AddSpellMenu.esp") as Actor
;     ResetSpells(tradedSpellActor)
;     tradedSpellActor.AddSpell(theSpell)
;     tradedSpellActor.GetBaseObject().SetName(player.GetBaseObject().GetName())
; 	UI.InvokeForm("CustomMenu", "_root.Menu_mc.MagicMenu_SetSecondaryActor", tradedSpellActor)
; endFunction