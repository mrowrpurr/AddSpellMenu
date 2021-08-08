scriptName AddSpellMenu_Forms hidden
{Fetch various objects from AddSpellMenu via global functions}

Form function GetModForm(int formId) global
    return Game.GetFormFromFile(formId, "AddSpellMenu.esp")
endFunction

Form function GetPackActivatorForm() global
    return GetModForm(0x808)
endFunction

Form function GetListActivatorForm() global
    return GetModForm(0x806)
endFunction

Form function GetSearchActivatorForm() global
    return GetModForm(0x807)
endFunction

ObjectReference function GetPackContainerInstance() global
    return GetModForm(0x80d) as ObjectReference
endFunction

Actor function GetNPCSpellTraderInstance() global
    return GetModForm(0x80c) as Actor
endFunction

Actor function GetNPCTempInstance() global
    return GetModForm(0x80b) as Actor
endFunction

GlobalVariable function GetSpellTomesRequiredGlobal() global
    return GetModForm(0x802) as GlobalVariable
endFunction

Form function GetListSpellTomeForm() global
    return GetModForm(0xd69)
endFunction

Form function GetSearchSpellTomeForm() global
    return GetModForm(0xd68)
endFunction

AddSpellMenu_QuestScript function GetModQuestScript() global
    return GetModForm(0xd6a) as AddSpellMenu_QuestScript
endFunction

Quest function GetModQuestScriptv2() global
    return GetModForm(0x811) as Quest
endFunction

Spell function GetListSpell() global
    return GetModForm(0x801) as Spell
endFunction

Spell function GetSearchSpell() global
    return GetModForm(0x800) as Spell
endFunction