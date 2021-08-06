scriptName AddSpellMenu_Effect_NPC_Search extends ActiveMagicEffect  
{Represents the spell effect which activates searching for spells to give to the target NPC}

event OnEffectStart(Actor target, Actor caster)
    if target
        AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = target
        AddSpellMenu_SearchAndList.SearchModsAndSpells()
    else
        Debug.MessageBox("No target NPC")
    endIf
endEvent
