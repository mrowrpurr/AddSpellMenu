scriptName AddSpellMenu_Npcs hidden

; Uses the option for whether special spells are considered or not
bool function HasAnySpells(Actor npc) global
    int spellCount = npc.GetSpellCount()
    spellCount += npc.GetActorBase().GetSpellCount()
    if AddSpellMenu_Options.AreSpecialSpellsEnabled()
        spellCount += npc.GetRace().GetSpellCount()
    endIf
    return spellCount > 0
endFunction

Actor function GetCurrentTarget() global
    return AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
endFunction

function SetCurrentTarget(Actor target) global
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = target
endFunction

string function GetNpcName(Actor npc) global
    string name = npc.GetName()
    if name == ""
        name = npc.GetDisplayName()
        if name == ""
            name == npc.GetBaseObject().GetName()
            if name == ""
                name = npc.GetActorBase().GetName()
            endIf
        endIf
    endIf
    return name
endFunction

string function GetNpcNameWithNickname(Actor npc) global
    string nickname = GetSavedNpcNickname(npc)
    string actorName = GetNpcName(npc)
    if nickname && nickname != actorName
        return nickname + " (" + actorName + ")"
    else
        return actorName
    endIf
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

bool function SaveNPC(Actor npc, string name = "") global
    Form[] forms = GetSavedNpcForms()
    string[] names = GetSavedNpcNames()

    if name == ""
        name = AddSpellMenu_Npcs.GetNpcName(npc)
    endIf

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

bool function RemoveSavedNPC(Actor npc) global
    Form[] forms = GetSavedNpcForms()
    string[] names = GetSavedNpcNames()

    int npcIndex = -1
    int index = 0
    while index < forms.Length && npcIndex == -1
        if forms[index] == npc
            npcIndex = index
        endIf
        index += 1
    endWhile

    if npcIndex == -1
        Debug.Notification("[AddSpellMenu] Saved NPC not found: " + AddSpellMenu_Npcs.GetNpcName(npc))
        return false
    endIf

    if forms.Length == 1
        SetSavedNpcForms(None)
        SetSavedNpcNames(None)
        return true
    endIf

    Form[] newFormArray = Utility.CreateFormArray(forms.Length - 1)
    string[] newNameArray = Utility.CreateStringArray(forms.Length - 1)

    int newArraysIndex = 0
    index = 0
    while index < forms.Length
        if forms[index] == npc
            ; skip, this is the NPC we're removing
        else
            newFormArray[newArraysIndex] = forms[index]
            newNameArray[newArraysIndex] = names[index]
            newArraysIndex += 1
        endIf
        index += 1
    endWhile

    SetSavedNpcForms(newFormArray)
    SetSavedNpcNames(newNameArray)

    return true
endFunction

function RenameSavedNPC(Actor npc, string newName) global
    Form[] forms = GetSavedNpcForms()
    string[] names = GetSavedNpcNames()

    int npcIndex = -1
    int index = 0
    while index < forms.Length && npcIndex == -1
        if forms[index] == npc
            npcIndex = index
        endIf
        index += 1
    endWhile

    if npcIndex == -1
        Debug.Notification("[AddSpellMenu] Saved NPC not found: " + AddSpellMenu_Npcs.GetNpcName(npc))
        return
    endIf

    names[npcIndex] = newName
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
