Scriptname AddSpellMenu_Effect_ToggleSpellTomes extends ActiveMagicEffect  

GlobalVariable property AddSpellMenu_RequiresSpellTome auto

event OnEffectStart(Actor target, Actor caster)
    if AddSpellMenu_RequiresSpellTome.GetValueInt() == 0
        AddSpellMenu_RequiresSpellTome.SetValueInt(1)
        Debug.MessageBox("AddSpellMenu now only shows spells with associated spell tomes")
    else
        AddSpellMenu_RequiresSpellTome.SetValueInt(0)
        Debug.MessageBox("AddSpellMenu now only shows all spells\n(even those without associated spell tomes)")
    endIf
endEvent