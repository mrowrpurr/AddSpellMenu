;
; Consider renaming to _Menu_SpellTrade or something :)
;

scriptName AddSpellMenu_BarterNpc hidden

Actor function Get() global
    int BarterNpcID = 0x1831
    return Game.GetFormFromFile(BarterNpcID, "AddSpellMenu.esp") as Actor
endFunction

function ResetSpells() global
    Actor npc = Get()
    while npc.GetSpellCount() > 0
        npc.RemoveSpell(npc.GetNthSpell(0))
    endWhile
endFunction

function AddSpells(Spell[] spells) global
    Actor npc = Get()
    int index = 0
    while index < spells.Length
        npc.AddSpell(spells[index])
        index += 1
    endWhile
endFunction

function Trade(Actor secondaryActor, AddSpellMenu_QuestScript modQuest) global
    uimagicmenu magicMenu = uiextensions.GetMenu("UIMagicMenu") as uimagicmenu
    magicMenu.SetPropertyForm("receivingActor", secondaryActor)
    modQuest.RegisterForModEvent("UIMagicMenu_AddRemoveSpell", "OnBarterSpell")
    magicMenu.OpenMenu(Get())
endFunction

function OnBarterSpell(string eventName, string strArg, float numArg, Form formArg) global
    Spell theSpell = formArg as Spell
    Game.GetPlayer().AddSpell(theSpell)
endFunction