scriptName AddSpellMenu_Effect_Search extends ActiveMagicEffect

AddSpellMenu_QuestScript property ModQuest auto

event OnEffectStart(Actor target, Actor caster)
    AddSpellMenu_SearchAndList.SearchModsAndSpells(ModQuest)
endEvent
