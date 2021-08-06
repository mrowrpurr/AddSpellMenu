Scriptname AddSpellMenu_Effect_NPC extends ActiveMagicEffect  
{Show a list of options for Adding/Viewing spells for an NPC}

event OnEffectStart(Actor target, Actor caster)
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = target
    AddSpellMenu_UI.ShowNpcAddSpellMenu()
endEvent