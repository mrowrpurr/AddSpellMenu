scriptName AddSpellMenu_Menu_ListSpellRemover hidden

function Show() global
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
    while ShowSpellChooser(npc) && npc.GetSpellCount() > 0
    endWhile
endFunction

bool function ShowSpellChooser(Actor spellsContainer) global
    uilistmenu listMenu = uiextensions.GetMenu("UIListMenu") as uilistmenu
     
     int numberOfSpells = spellsContainer.GetSpellCount()
     int index = 0
     while index < numberOfSpells
        Spell theSpell = spellsContainer.GetNthSpell(index)
        listMenu.AddEntryItem(theSpell.GetName())
        index += 1
     endWhile
     
     listMenu.OpenMenu()

     int selectedIndex = listMenu.GetResultInt()

    if selectedIndex > -1
        Spell selectedSpell = spellsContainer.GetNthSpell(selectedIndex)
        Actor targetActor = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor
        targetActor.RemoveSpell(selectedSpell)
        if targetActor.HasSpell(selectedSpell)
            Debug.Notification(targetActor.GetBaseObject().GetName() + " cannot unlearn starting spell " + selectedSpell.GetName())
        else
            spellsContainer.RemoveSpell(selectedSpell)
        endIf
        return true
    else
        return false
    endIf
endFunction