scriptName AddSpellMenu_Effect_List extends ActiveMagicEffect  
{Represents the spell effect which shows the list of mods}

AddSpellMenu_QuestScript property ModQuest auto

event OnEffectStart(Actor target, Actor caster)
    AddSpellMenu_SearchAndList.ListMods(ModQuest)
endEvent