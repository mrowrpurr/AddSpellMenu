scriptName AddSpellMenu_Menu_ListSpellViewer hidden

function Show() global
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor

    uilistmenu listMenu = uiextensions.GetMenu("UIListMenu") as uilistmenu
    
    int numberOfSpells = npc.GetSpellCount()

    if numberOfSpells == 0
        Debug.MessageBox(npc.GetBaseObject().GetName() + " has no spells")
        return
    endIf

    int index = 0
    while index < numberOfSpells
       Spell theSpell = npc.GetNthSpell(index)
       listMenu.AddEntryItem(theSpell.GetName())
       index += 1
    endWhile

    listMenu.OpenMenu()
endFunction
