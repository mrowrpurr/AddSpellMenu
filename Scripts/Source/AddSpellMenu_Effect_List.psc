scriptName AddSpellMenu_Effect_List extends ActiveMagicEffect  

event OnEffectStart(Actor target, Actor caster)
    string selectedMod = AddSpellMenu_Menu_ModChooser.Show()

    Debug.MessageBox("You selected the mod: " + selectedMod)
    ; TODO show the spell chooser for this mod
endEvent