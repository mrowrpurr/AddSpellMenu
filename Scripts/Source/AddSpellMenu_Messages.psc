scriptName AddSpellMenu_Messages hidden
{Provides references to all menu message boxes}

Message function MainMenuMessage() global
    return AddSpellMenu_Forms.GetModForm(0x82b) as Message
endFunction

Message function OptionsMessage() global
    return AddSpellMenu_Forms.GetModForm(0x81b) as Message
endFunction

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

Message function ManageNPCsMessage() global
    return AddSpellMenu_Forms.GetModForm(0x82f) as Message
endFunction
