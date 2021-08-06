Scriptname AddSpellMenu_Effect_NPC extends ActiveMagicEffect  
{Show a list of options for Adding/Viewing spells for an NPC}

event OnEffectStart(Actor target, Actor caster)
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = target
    int selection = AddSpellMenu_Forms.GetNpcMessage().Show()
    int viewIndex = 0
    int searchIndex = 1
    int listIndex = 2
    int removeIndex = 3
    int cancelIndex = 4
    if selection == viewIndex
        AddSpellMenu_Npcs.ViewNpcSpells()
    elseIf selection == searchIndex
        AddSpellMenu_SearchAndList.SearchModsAndSpells()
    elseIf selection == listIndex
        AddSpellMenu_SearchAndList.ListMods()
    elseIf selection == removeIndex
        AddSpellMenu_Npcs.RemoveNpcSpells()
    endIf
endEvent