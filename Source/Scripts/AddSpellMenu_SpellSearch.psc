scriptName AddSpellMenu_SpellSearch hidden

bool function SearchAllSpellsAndPopulateContainerWithMatches(AddSpellMenu_QuestScript modQuest, string searchQuery, Actor spellsContainer, bool onlyShowSpellsWithSpellTomes = true) global
    if onlyShowSpellsWithSpellTomes
        Debug.Notification("Searching spells for \"" + searchQuery + "\"...")
    else
        Debug.Notification("Searching all spells for \"" + searchQuery + "\"... This may take awhile...")
        modQuest.BeginSearchingNotifications()
    endIf
    Spell[] allSpells = PO3_SKSEFunctions.GetAllSpells(abIsPlayable = onlyShowSpellsWithSpellTomes)
    Actor player = Game.GetPlayer()

    bool anyMatchingSpells = false
    int index = 0
    while index < allSpells.Length
        Spell theSpell = allSpells[index]
        if StringUtil.Find(theSpell.GetName(), searchQuery) > -1 && ! player.HasSpell(theSpell)
            spellsContainer.AddSpell(theSpell)
            anyMatchingSpells = true
        endIf
        index += 1
    endWhile

    modQuest.EndSearchingNotifications()
    return anyMatchingSpells
endFunction

bool function GetAllModSpellsAndPopulateContainerWithMatches(string modFile, Actor spellsContainer, bool onlyShowSpellsWithSpellTomes = true) global
    Spell[] allSpells = PO3_SKSEFunctions.GetAllSpellsInMod(modFile, abIsPlayable = onlyShowSpellsWithSpellTomes)
    Actor player = Game.GetPlayer()

    bool anyMatchingSpells = false
    int index = 0
    while index < allSpells.Length
        Spell theSpell = allSpells[index]
        if ! player.HasSpell(theSpell)
            spellsContainer.AddSpell(theSpell)
            anyMatchingSpells = true
        endIf
        index += 1
    endWhile

    return anyMatchingSpells
endFunction