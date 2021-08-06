scriptName AddSpellMenu_SpellSearch hidden
{Performs the spell searching!}

; Returns whether *any* matching spells were found, regardless of whether the player has the spell or not.
; Check the container to see whether there were any spells which the player did not already have.
bool function SearchAllSpellsAndPopulateContainerWithMatches(string searchQuery, Actor spellsContainer, bool onlyShowSpellsWithSpellTomes = true) global
    if onlyShowSpellsWithSpellTomes
        Debug.Notification("Searching spells for \"" + searchQuery + "\"...")
    else
        Debug.Notification("Searching all spells for \"" + searchQuery + "\"... This may take awhile...")
        AddSpellMenu_Forms.GetModQuestScript().BeginSearchingNotifications()
    endIf

    Spell[] allSpells = PO3_SKSEFunctions.GetAllSpells(abIsPlayable = onlyShowSpellsWithSpellTomes)
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor

    bool anyMatchingSpells = false
    int index = 0
    while index < allSpells.Length
        Spell theSpell = allSpells[index]
        if StringUtil.Find(theSpell.GetName(), searchQuery) > -1
            anyMatchingSpells = true
            if ! npc.HasSpell(theSpell)
                spellsContainer.AddSpell(theSpell)
            endIf
        endIf
        index += 1
    endWhile

    AddSpellMenu_Forms.GetModQuestScript().EndSearchingNotifications()

    return anyMatchingSpells
endFunction

; Returns whether *any* matching spells were found, regardless of whether the player has the spell or not.
; Check the container to see whether there were any spells which the player did not already have.
bool function GetAllModSpellsAndPopulateContainerWithMatches(string modFile, Actor spellsContainer, bool onlyShowSpellsWithSpellTomes = true) global
    Spell[] allSpells = PO3_SKSEFunctions.GetAllSpellsInMod(modFile, abIsPlayable = onlyShowSpellsWithSpellTomes)
    Actor npc = AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor

    int index = 0
    while index < allSpells.Length
        Spell theSpell = allSpells[index]
        if ! npc.HasSpell(theSpell)
            spellsContainer.AddSpell(theSpell)
        endIf
        index += 1
    endWhile

    return allSpells.Length > 0
endFunction