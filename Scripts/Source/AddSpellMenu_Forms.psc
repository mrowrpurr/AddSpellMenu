scriptName AddSpellMenu_Forms hidden
{Fetch various objects from AddSpellMenu via global functions}

Form function GetModForm(int formId) global
    return Game.GetFormFromFile(formId, "AddSpellMenu.esp")
endFunction

Form function GetPackActivatorForm() global
    return GetModForm(0x808)
endFunction

Form function GetActivatorForm() global
    return GetModForm(0x806)
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

GlobalVariable function GetSpecialSpellsEnabledGlobal() global
    return GetModForm(0x81c) as GlobalVariable
endFunction

Form function GetShoutSpellTomeForm() global
    return GetModForm(0xd69)
endFunction

Form function GetNpcSpellTomeForm() global
    return GetModForm(0x80f)
endFunction

AddSpellMenu_QuestScript function GetModQuestScript() global
    return GetModForm(0xd6a) as AddSpellMenu_QuestScript
endFunction

Quest function GetModQuestScriptv2() global
    return GetModForm(0x815) as Quest
endFunction

AddSpellMenu_Questv3Script function GetModQuestScriptv3() global
    return GetModForm(0x807) as AddSpellMenu_Questv3Script
endFunction

Spell function GetSpell() global
    return GetModForm(0x801) as Spell
endFunction

Spell function GetPower() global
    return GetModForm(0x80e) as Spell
endFunction

Message function MainMenuMessage() global
    return GetModForm(0x82b) as Message
endFunction

; DEPRECATE ----------
Message function NpcMainMenuMessage() global
    Debug.MessageBox("NPC MAIN MENU MESAGE DEPRECATED")
    return GetModForm(0x82c) as Message
endFunction
Message function NpcMainMenuMessageWithoutViewAndRemove() global
    Debug.MessageBox("NPC MAIN MENU MESAGE DEPRECATED (no view and remove)")
    return GetModForm(0x810) as Message
endFunction
; ^ DEPRECATE ----------------------------

Message function OptionsMessage() global
    return GetModForm(0x81b) as Message
endFunction
