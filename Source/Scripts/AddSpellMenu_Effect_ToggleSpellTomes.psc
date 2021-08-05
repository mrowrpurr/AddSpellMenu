Scriptname AddSpellMenu_Effect_ToggleSpellTomes extends ActiveMagicEffect  
{Represents the spell effect which toggles the feature of whether spell tomes are required for spells to appear in the search/list}

GlobalVariable property AddSpellMenu_RequiresSpellTome auto

event OnEffectStart(Actor target, Actor caster)
    if AddSpellMenu_RequiresSpellTome.GetValueInt() == 0
        AddSpellMenu_RequiresSpellTome.SetValueInt(1)
        Debug.MessageBox("AddSpellMenu now only shows spells with associated spell tomes")
    else
        AddSpellMenu_RequiresSpellTome.SetValueInt(0)
        Debug.MessageBox("AddSpellMenu now shows *all* spells\n(even those without associated spell tomes)")
    endIf
endEvent