scriptName AddSpellMenu_Activator_Pack extends ObjectReference  

AddSpellMenu_QuestScript property ModQuest auto

event OnEquipped(Actor player)
    AddSpellMenu_Menu_Controls.CloseInventoryMenu()
    AddSpellMenu_Forms.GetPackContainerInstance().Activate(player)
endEvent
