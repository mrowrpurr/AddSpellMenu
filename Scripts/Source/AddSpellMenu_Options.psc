scriptName AddSpellMenu_Options

function ToggleSpellTomeRequirement() global
    GlobalVariable variable = AddSpellMenu_Forms.GetSpellTomesRequiredGlobal()
    if variable.GetValueInt() == 0
        variable.SetValueInt(1)
    else
        variable.SetValueInt(0)
    endIf
endFunction

bool function IsSpellTomeRequired() global
    return AddSpellMenu_Forms.GetSpellTomesRequiredGlobal().GetValueInt() == 1
endFunction

function ToggleSpecialSpells() global
    GlobalVariable variable = AddSpellMenu_Forms.GetSpecialSpellsEnabledGlobal()
    if variable.GetValueInt() == 0
        variable.SetValueInt(1)
    else
        variable.SetValueInt(0)
    endIf
endFunction

bool function AreSpecialSpellsEnabled() global
    return AddSpellMenu_Forms.GetSpecialSpellsEnabledGlobal().GetValueInt() == 1
endFunction
