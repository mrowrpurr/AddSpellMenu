scriptName AddSpellMenu_Messages_ObjectsAndSpells hidden

function Show() global
    AddSpellMenu_Messages_TextReplacement.SetTextReplacement(1, PowerStatusText())
    AddSpellMenu_Messages_TextReplacement.SetTextReplacement(2, SpellStatusText())
    AddSpellMenu_Messages_TextReplacement.SetTextReplacement(3, ActivatorStatusText())
    int result = AddSpellMenu_Forms.SpellPowerActivatorMessage().Show()
    AddSpellMenu_Messages_TextReplacement.ClearAll()
    if result == 0
        OnTogglePower()
        Show()
    elseif result == 1
        OnToggleSpell()
        Show()
    elseif result == 2
        OnToggleActivator()
        Show()
    else
        AddSpellMenu_Messages_Navigation.GoBack()
    endIf
endFunction

function OnTogglePower() global
    if PowerHasBeenLearned()
        Game.GetPlayer().RemoveSpell(AddSpellMenu_Forms.GetPower())
    else
        Game.GetPlayer().AddSpell(AddSpellMenu_Forms.GetPower())
    endIf
endFunction

function OnToggleSpell() global
    if SpellHasBeenLearned()
        Game.GetPlayer().RemoveSpell(AddSpellMenu_Forms.GetSpell())
    else
        Game.GetPlayer().AddSpell(AddSpellMenu_Forms.GetSpell())
    endIf
endFunction

function OnToggleActivator() global
    if ActivatorIsInInventory()
        Game.GetPlayer().RemoveItem(AddSpellMenu_Forms.GetActivatorForm())
    else
        Game.GetPlayer().AddItem(AddSpellMenu_Forms.GetActivatorForm())
    endIf
endFunction

bool function ActivatorIsInInventory() global
    return Game.GetPlayer().GetItemCount(AddSpellMenu_Forms.GetActivatorForm()) > 0
endFunction

bool function PowerHasBeenLearned() global
    return Game.GetPlayer().HasSpell(AddSpellMenu_Forms.GetPower())
endFunction

bool function SpellHasBeenLearned() global
    return Game.GetPlayer().HasSpell(AddSpellMenu_Forms.GetSpell())
endFunction

string function PowerStatusText() global
    if PowerHasBeenLearned()
        return "Learned"
    else
        return "Not Learned"
    endIf
endFunction

string function SpellStatusText() global
    if SpellHasBeenLearned()
        return "Learned"
    else
        return "Not Learned"
    endIf
endFunction

string function ActivatorStatusText() global
    if ActivatorIsInInventory()
        return "In Inventory"
    else
        return "Not In Inventory"
    endIf
endFunction