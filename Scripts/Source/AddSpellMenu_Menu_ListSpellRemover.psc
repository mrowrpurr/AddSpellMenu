scriptName AddSpellMenu_Menu_ListSpellRemover hidden

function Show() global
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
    while ShowSpellRemover(npc) && ((npc.GetSpellCount() > 0 || npc.GetActorBase().GetSpellCount() > 0) || (AddSpellMenu_Options.AreSpecialSpellsEnabled() && npc.GetRace().GetSpellCount() > 0))
    endWhile
endFunction

bool function ShowSpellRemover(Actor npc) global
    uilistmenu listMenu = uiextensions.GetMenu("UIListMenu") as uilistmenu
     
    int numberOfBaseActorSpells = npc.GetActorBase().GetSpellCount()
    int numberOfNpcSpells = npc.GetSpellCount()
    int numberOfRacialSpells = 0

    if AddSpellMenu_Options.AreSpecialSpellsEnabled()
        numberOfRacialSpells = npc.GetRace().GetSpellCount()
    endIf

    if numberOfNpcSpells == 0 && numberOfRacialSpells == 0 && numberOfBaseActorSpells == 0
        Debug.MessageBox(AddSpellMenu_Npcs.GetNpcName(npc) + " has no spells")
        return false
    endIf

    ; Base Actor Spells
    int index = 0
    while index < numberOfBaseActorSpells
       Spell theSpell = npc.GetActorBase().GetNthSpell(index)
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

    int selectedIndex = listMenu.GetResultInt()
    bool isBaseActorSpell = false
    bool isRacialSpell = false

    if selectedIndex > -1
        Spell selectedSpell

        if selectedIndex < numberOfBaseActorSpells
            selectedSpell = npc.GetActorBase().GetNthSpell(selectedIndex)
            isBaseActorSpell = true
        elseIf selectedIndex < numberOfBaseActorSpells + numberOfNpcSpells
            selectedSpell = npc.GetNthSpell(selectedIndex - numberOfBaseActorSpells)
        elseIf selectedIndex < numberOfBaseActorSpells + numberOfNpcSpells + numberOfRacialSpells
            selectedSpell = npc.GetRace().GetNthSpell(selectedIndex - numberOfBaseActorSpells - numberOfNpcSpells)
            isRacialSpell = true
        endIf

        bool removedOk = npc.RemoveSpell(selectedSpell)

        if isBaseActorSpell
            Debug.Notification(AddSpellMenu_Npcs.GetNpcName(npc) + " cannot unlearn starting spell " + selectedSpell.GetName())
        elseIf isRacialSpell
            Debug.Notification(AddSpellMenu_Npcs.GetNpcName(npc) + " cannot unlearn racial spell " + selectedSpell.GetName())
        elseif ! removedOk || npc.HasSpell(selectedSpell)
            Debug.Notification(AddSpellMenu_Npcs.GetNpcName(npc) + " cannot unlearn spell " + selectedSpell.GetName())
        endIf

        return true
    else
        return false
    endIf
endFunction