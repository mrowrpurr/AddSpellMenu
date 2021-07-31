scriptName AddSpellMenu_Effect_List extends ActiveMagicEffect  

AddSpellMenu_QuestScript property ModQuest auto

event OnEffectStart(Actor target, Actor caster)
    string selectedMod = AddSpellMenu_Menu_ModChooser.Show()

    Spell[] spells = PO3_SKSEFunctions.GetAllSpellsInMod(selectedMod, abIsPlayable = true)

    AddSpellMenu_BarterNpc.ResetSpells()
    AddSpellMenu_BarterNpc.AddSpells(spells)
    AddSpellMenu_BarterNpc.Trade(caster, ModQuest)
endEvent