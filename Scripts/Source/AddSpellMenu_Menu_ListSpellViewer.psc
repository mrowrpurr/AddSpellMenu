scriptName AddSpellMenu_Menu_ListSpellViewer hidden

function Show() global
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor

    uilistmenu listMenu = uiextensions.GetMenu("UIListMenu") as uilistmenu
    
    int numberOfBaseActorSpells = npc.GetActorBase().GetSpellCount()
    int numberOfNpcSpells = npc.GetSpellCount()
    int numberOfRacialSpells = 0

    if AddSpellMenu_Options.AreSpecialSpellsEnabled()
        numberOfRacialSpells = npc.GetRace().GetSpellCount()
    endIf

    if numberOfNpcSpells == 0 && numberOfRacialSpells == 0 && numberOfBaseActorSpells == 0
        Debug.MessageBox(npc.GetBaseObject().GetName() + " has no spells")
        return
    endIf

    ; Base Actor Spells
    int index = 0
    while index < numberOfBaseActorSpells
       Spell theSpell = npc.GetACtorBase().GetNthSpell(index)
       listMenu.AddEntryItem(theSpell.GetName())
       index += 1
    endWhile

    ; "Player Spells"
    index = 0
    while index < numberOfNpcSpells
        Spell theSpell = npc.GetNthSpell(index)
        listMenu.AddEntryItem(theSpell.GetName())
        index += 1
    endWhile

    if AddSpellMenu_Options.AreSpecialSpellsEnabled()
        ; Racial Spells
        index = 0
        while index < numberOfRacialSpells
            Spell theSpell = npc.GetRace().GetNthSpell(index)
            listMenu.AddEntryItem(theSpell.GetName())
            index += 1
        endWhile
    endIf

    listMenu.OpenMenu()
endFunction
