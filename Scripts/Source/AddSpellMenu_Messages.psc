scriptName AddSpellMenu_Messages
{Provides references to all menu message boxes}

Message function NpcMenu_NotSaved_NoSpells() global
    return AddSpellMenu_Forms.GetModForm(0x811) as Message
endFunction

Message function NpcMenu_NotSaved_WithSpells() global
    return AddSpellMenu_Forms.GetModForm(0x81d) as Message
endFunction

Message function NpcMenu_Saved_NoSpells() global
    return AddSpellMenu_Forms.GetModForm(0x810) as Message
endFunction

Message function NpcMenu_Saved_WithSpells() global
    return AddSpellMenu_Forms.GetModForm(0x82c) as Message
endFunction
