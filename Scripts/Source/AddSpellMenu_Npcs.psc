scriptName AddSpellMenu_Npcs hidden

Actor function GetCurrentTarget() global
    return AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
endFunction

function SetCurrentTarget(Actor target) global
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = target
endFunction

bool function AnyNpcsSaved() global
    return AddSpellMenu_Forms.GetModQuestScriptv3().SavedNPCForms.Length > 0
endFunction

string function GetSavedNpcNickname(Actor npc) global
    Form[] forms = GetSavedNpcForms()
    string[] names = GetSavedNpcNames()
    int index = 0
    while index < forms.Length
        if forms[index] == npc
            return names[index]
        endIf
        index += 1
    endWhile
endFunction

bool function IsSaved(Actor npc) global
    Form[] forms = GetSavedNpcForms()
    int index = 0
    while index < forms.Length
        if forms[index] == npc
            return true
        endIf
        index += 1
    endWhile
    return false
endFunction

bool function SaveNPC(Actor npc, string name) global
    Form[] forms = GetSavedNpcForms()
    string[] names = GetSavedNpcNames()

    if forms.Length == 128
        Debug.MessageBox("You cannot save more than 128 NPCs")
        return false
    endIf

    forms = Utility.ResizeFormArray(forms, forms.Length + 1)
    names = Utility.ResizeStringArray(names, names.Length + 1)
    forms[forms.Length - 1] = npc
    names[names.Length - 1] = name
    
    SetSavedNpcForms(forms)
    SetSavedNpcNames(names)

    return true
endFunction

Form[] function GetSavedNpcForms() global
    return AddSpellMenu_Forms.GetModQuestScriptv3().SavedNPCForms
endFunction

string[] function GetSavedNpcNames() global
    return AddSpellMenu_Forms.GetModQuestScriptv3().SavedNPCNames
endFunction

function SetSavedNpcForms(Form[] forms) global
    AddSpellMenu_Forms.GetModQuestScriptv3().SavedNPCForms = forms
endFunction

function SetSavedNpcNames(string[] names) global
    AddSpellMenu_Forms.GetModQuestScriptv3().SavedNPCNames = names
endFunction

Actor function GetTraderContainerNpc(bool resetSpells = true) global
    Actor traderActor = AddSpellMenu_Forms.GetNPCSpellTraderInstance()
    if resetSpells
        ResetSpells(traderActor)
    endIf
    return traderActor
endFunction

Actor function GetTempContainerNpc(bool resetSpells = true, bool giveTargetActorName = true) global
    Actor tempActor = AddSpellMenu_Forms.GetNPCTempInstance()
    if resetSpells
        ResetSpells(tempActor)
    endIf
    tempActor.GetBaseObject().SetName(AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor.GetBaseObject().GetName())
    return tempActor
endFunction

function ResetSpells(Actor npc) global
    while npc.GetSpellCount() > 0
        npc.RemoveSpell(npc.GetNthSpell(0))
    endWhile
endFunction
