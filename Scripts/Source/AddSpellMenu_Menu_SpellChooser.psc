scriptName AddSpellMenu_Menu_SpellChooser hidden

function Show(Actor spellsContainer, AddSpellMenu_QuestScript modQuest) global
    modQuest.RegisterForModEvent("UIMagicMenu_AddRemoveSpell", "OnSpellChooserAddRemoveSpell")

    uimagicmenu magicMenu = uiextensions.GetMenu("UIMagicMenu") as uimagicmenu
    magicMenu.SetPropertyForm("receivingActor", Game.GetPlayer())
    magicMenu.SetPropertyBool("Notifications", false)
    magicMenu.OpenMenu(spellsContainer)
endFunction

function OnSpellChooserAddRemoveSpell(string eventName, string strArg, float numArg, Form formArg) global
    Actor player = Game.GetPlayer()
    Spell theSpell = formArg as Spell

    if ! player.HasSpell(theSpell)
        player.AddSpell(theSpell)
        AddAsKnownSpellToSpellChooserUI(theSpell)
    endIf
endFunction

function AddAsKnownSpellToSpellChooserUI(Spell theSpell) global
    Actor tempNpc = AddSpellMenu_Npcs.GetTempContainerNpc(resetSpells = true, givePlayersName = true)
    tempNpc.AddSpell(theSpell)
    UI.InvokeForm("CustomMenu", "_root.Menu_mc.MagicMenu_SetSecondaryActor", tempNpc)
endFunction
