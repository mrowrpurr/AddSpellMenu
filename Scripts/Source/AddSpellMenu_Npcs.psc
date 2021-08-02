scriptName AddSpellMenu_Npcs hidden

Actor function GetTraderContainerNpc(bool resetSpells = true) global
    return GetModActor(0x5e39, resetSpells)
endFunction

Actor function GetTempContainerNpc(bool resetSpells = true, bool givePlayersName = true) global
    Actor tempActor = GetModActor(0x536f, resetSpells)
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
