scriptName AddSpellMenu_Effect_Search extends ActiveMagicEffect  
{Represents the spell effect which activates searching for spells}

AddSpellMenu_QuestScript property ModQuest auto

event OnEffectStart(Actor target, Actor caster)
    AddSpellMenu_SearchAndList.SearchModsAndSpells(ModQuest)
endEvent
