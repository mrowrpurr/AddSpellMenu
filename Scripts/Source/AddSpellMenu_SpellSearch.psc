scriptName AddSpellMenu_SpellSearch hidden

bool function SearchAllSpellsAndPopulateContainerWithMatches(string searchQuery, Actor spellsContainer) global
    Spell[] allSpells = PO3_SKSEFunctions.GetAllSpells(abIsPlayable = true) ; <--- switch abIsPlayable to a Quest variable (later) for configuration
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

    return anyMatchingSpells
endFunction

bool function GetAllModSpellsAndPopulateContainerWithMatches(string modFile, Actor spellsContainer) global
    Spell[] allSpells = PO3_SKSEFunctions.GetAllSpellsInMod(modFile, abIsPlayable = true)
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