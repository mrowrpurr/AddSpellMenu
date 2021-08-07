scriptName AddSpellMenu_Messages_TextReplacement hidden

function SetTextReplacement(int textIndex, string text) global
    if textIndex < 1 || textIndex > 10
        Debug.Notification("[AddSpellMenu] Cannot set text replacement number " + textIndex)
        return
    endIf
    string questAliasName = "MessageBoxText" + textIndex
    ReferenceAlias theAlias = AddSpellMenu_Forms.GetModQuestScriptv3().GetAliasByName(questAliasName) as ReferenceAlias
    theAlias.GetReference().GetBaseObject().SetName(text)
endFunction

function ClearAll() global
    int index = 1
    while index < 11
        SetTextReplacement(index, "")
        index += 1
    endWhile
endFunction
