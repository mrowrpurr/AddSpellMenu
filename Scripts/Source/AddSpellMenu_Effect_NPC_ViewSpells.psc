Scriptname AddSpellMenu_Effect_NPC_ViewSpells extends ActiveMagicEffect  
{View all of the target NPC's current spells}

event OnEffectStart(Actor target, Actor caster)
    if target
        AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = target
        AddSpellMenu_Npcs.ViewNpcSpells()
    else
        Debug.MessageBox("No target NPC")
    endIf
endEvent