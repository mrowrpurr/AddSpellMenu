scriptName AddSpellMenu_Effect extends ActiveMagicEffect  
{Represents the spell effect which shows the list of mods}

event OnEffectStart(Actor target, Actor caster)
    if target
        AddSpellMenu_Messages_NpcMenu.Show(target)
    else
        AddSpellMenu_UI.ShowAddSpellMenu()
    endIf
endEvent