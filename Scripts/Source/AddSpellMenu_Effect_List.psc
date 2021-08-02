scriptName AddSpellMenu_Effect_List extends ActiveMagicEffect

AddSpellMenu_QuestScript property ModQuest auto

event OnEffectStart(Actor target, Actor caster)
    AddSpellMenu_SearchAndList.ListMods(ModQuest)
endEvent