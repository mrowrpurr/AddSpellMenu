scriptName AddSpellMenu_Effect_NPC_List extends ActiveMagicEffect  
{Represents the spell effect which shows the list of mods for spells to give to the target NPC}

event OnEffectStart(Actor target, Actor caster)
    if target
        AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = target
        AddSpellMenu_SearchAndList.ListMods()
    else
        Debug.MessageBox("No target NPC")
    endIf
endEvent