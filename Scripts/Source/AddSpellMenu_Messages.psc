scriptName AddSpellMenu_Messages

function ShowWhenNoNpcInCrosshairs() global
    (AddSpellMenu_Forms.GetModForm(0x82b) as Message).Show()
endFunction

function ShowWhenNpcInCrosshairs() global
    (AddSpellMenu_Forms.GetModForm(0x803) as Message).Show()
endFunction

function ShowWhenNpcInCrosshairsAndOthersAvailable() global
    (AddSpellMenu_Forms.GetModForm(0x800) as Message).Show()
endFunction