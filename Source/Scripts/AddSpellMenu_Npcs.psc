scriptName AddSpellMenu_Npcs hidden

Actor function GetTraderContainerNpc(bool resetSpells = true) global
    Actor traderActor = AddSpellMenu_Forms.GetNPCSpellTraderInstance()
    if resetSpells
        ResetSpells(traderActor)
    endIf
    return traderActor
endFunction

Actor function GetTempContainerNpc(bool resetSpells = true, bool giveTargetActorName = true) global
    Actor tempActor = AddSpellMenu_Forms.GetNPCTempInstance()
    if resetSpells
        ResetSpells(tempActor)
    endIf
    tempActor.GetBaseObject().SetName(AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor.GetBaseObject().GetName())
    return tempActor
endFunction

function ResetSpells(Actor npc) global
    while npc.GetSpellCount() > 0
        npc.RemoveSpell(npc.GetNthSpell(0))
    endWhile
endFunction

function ViewNpcSpells() global
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
    AddSpellMenu_Menu_SpellViewer.Show()
endFunction