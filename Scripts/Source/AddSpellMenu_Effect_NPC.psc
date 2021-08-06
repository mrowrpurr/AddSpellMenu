Scriptname AddSpellMenu_Effect_NPC extends ActiveMagicEffect  
{Show a list of options for Adding/Viewing spells for an NPC}

event OnEffectStart(Actor target, Actor caster)
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = target
    int selection = AddSpellMenu_Forms.GetNpcMessage().Show()
    int addIndex = 0
    int viewIndex = 1
    int removeIndex = 2
    int cancelIndex = 3
    if selection == addIndex
        AddSpellMenu_SearchAndList.ShowAddSpellMenu()
    elseIf selection == viewIndex
        AddSpellMenu_Npcs.ViewNpcSpells()
    elseIf selection == removeIndex
        AddSpellMenu_Npcs.RemoveNpcSpells()
    endIf
endEvent