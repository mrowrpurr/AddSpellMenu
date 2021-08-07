scriptName AddSpellMenu_Messages_Options hidden

function Show() global
    AddSpellMenu_Messages_TextReplacement.SetTextReplacement(1, SpellTomeRequirementStatusText())
    AddSpellMenu_Messages_TextReplacement.SetTextReplacement(2, ShowSpecialSpellsStatusText())
    int result = AddSpellMenu_Forms.OptionsMessage().Show()
    AddSpellMenu_Messages_TextReplacement.ClearAll()
    if result == 0
        AddSpellMenu_Options.ToggleSpellTomeRequirement()
        Show()
    elseif result == 1
        AddSpellMenu_Options.ToggleSpecialSpells()
        Show()
    else
        AddSpellMenu_Messages_Navigation.GoBack()
    endIf
endFunction

string function SpellTomeRequirementStatusText() global
    if AddSpellMenu_Options.IsSpellTomeRequired()
        return "Enabled"
    else
        return "Disabled"
    endIf
endFunction

string function ShowSpecialSpellsStatusText() global
    if AddSpellMenu_Options.AreSpecialSpellsEnabled()
        return "Enabled"
    else
        return "Disabled"
    endIf
endFunction