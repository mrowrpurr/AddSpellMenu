scriptName AddSpellMenu
{Public global functions for AddSpellMenu}

; Toggle whether only spells with associated spell tomes are shown / returned.
function SetIsSpellTomeRequired(bool isSpellTomeRequired) global
    if isSpellTomeRequired
        AddSpellMenu_Forms.GetSpellTomesRequiredGlobal().SetValueInt(1)
    else
        AddSpellMenu_Forms.GetSpellTomesRequiredGlobal().SetValueInt(0)
    endIf
endFunction

; Search for spells or mods. Text entry is shown if no spellSearchQuery is provided.
; Returns a reference to a Actor which is populated with all of the Spells returned as results.
; Note: spellRecipient is not yet used, it defaults to the Player and cannot be configured.
Actor function ShowSearch(string spellSearchQuery = "", Actor spellRecipient = None) global
    AddSpellMenu_SearchAndList.SearchModsAndSpells(AddSpellMenu_Forms.GetModQuestScript(), spellSearchQuery)
    return AddSpellMenu_Forms.GetNPCSpellTraderInstance()
endFunction

; Show the list of mods to view spells from.
; Returns a reference to a Actor which is populated with all of the Spells returned as results.
; Note: spellRecipient is not yet used, it defaults to the Player and cannot be configured.
Actor function ShowModList(Actor spellRecipient = None) global
    AddSpellMenu_SearchAndList.ListMods(AddSpellMenu_Forms.GetModQuestScript())
    return AddSpellMenu_Forms.GetNPCSpellTraderInstance()
endFunction

; Return Actor containing the spells found from the provided search query (across the base game and mods).
; Use SetIsSpellTomeRequired() to change that requirement (defaults to true)
; To access the spell list, use Actor.GetSpellCount() and Actor.GetNthSpell()
; Note: spellRecipient is not yet used, it defaults to the Player and cannot be configured.
Actor function SearchSpells(string spellSearchQuery, Actor spellRecipient = None) global
    Actor spellsContainer = AddSpellMenu_Npcs.GetTraderContainerNpc(resetSpells = true)
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript()
    AddSpellMenu_SpellSearch.SearchAllSpellsAndPopulateContainerWithMatches( \
        modQuest, \
        spellSearchQuery, \
        spellsContainer, \
        onlyShowSpellsWithSpellTomes = modQuest.OnlyShowSpellsWithSpellTomes)
    return spellsContainer
endFunction
