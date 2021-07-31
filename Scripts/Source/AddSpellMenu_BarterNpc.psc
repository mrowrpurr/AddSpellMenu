;
; Consider renaming to _Menu_SpellTrade or something :)
;

;
; TODO: Don't add spells that we already have to the Barter NPC
; TODO: Don't handle AddRemove click if you already have the spell
;

scriptName AddSpellMenu_BarterNpc hidden

Actor function Get() global
    int BarterNpcID = 0x1831
    return Game.GetFormFromFile(BarterNpcID, "AddSpellMenu.esp") as Actor
endFunction

; Actor function GetTradedSpellNpc() global
;     int TradedSpellNpcID = 0x22f7
;     return Game.GetFormFromFile(0x22f7, "AddSpellMenu.esp") as Actor
; endFunction

function ResetSpells(Actor npc = None) global
    if npc == None
        npc = Get()
    endIf
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
    magicMenu.SetPropertyBool("Notifications", false)
    modQuest.RegisterForModEvent("UIMagicMenu_AddRemoveSpell", "OnBarterSpell")
    magicMenu.OpenMenu(Get())
endFunction

function OnBarterSpell(string eventName, string strArg, float numArg, Form formArg) global
    Actor player = Game.GetPlayer()
    Spell theSpell = formArg as Spell
    player.AddSpell(theSpell)

    Actor tradedSpellActor = Game.GetFormFromFile(0x22f7, "AddSpellMenu.esp") as Actor
    ResetSpells(tradedSpellActor)
    tradedSpellActor.AddSpell(theSpell)
    tradedSpellActor.GetBaseObject().SetName(player.GetBaseObject().GetName())
	UI.InvokeForm("CustomMenu", "_root.Menu_mc.MagicMenu_SetSecondaryActor", tradedSpellActor)
endFunction