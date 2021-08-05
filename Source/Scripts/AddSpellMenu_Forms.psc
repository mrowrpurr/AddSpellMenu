scriptName AddSpellMenu_Forms

Form function GetModForm(int formId) global
    return Game.GetFormFromFile(formId, "AddSpellMenu.esp")
endFunction

Form function GetPackActivatorForm() global
    return GetModForm(0x808)
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
