scriptName AddSpellMenu_Effect extends ActiveMagicEffect  
{Represents the spell effect which shows the list of mods}

event OnEffectStart(Actor target, Actor caster)
    AddSpellMenu_UI.ShowAddSpellMenu()
endEvent