scriptName AddSpellMenu_Activator_Pack extends ObjectReference  

AddSpellMenu_QuestScript property ModQuest auto

event OnEquipped(Actor player)
    ObjectReference packContainer = ModQuest.GetModForm(0x5373) as ObjectReference
    AddSpellMenu_Menu_Controls.CloseInventoryMenu()
    packContainer.Activate(player)
endEvent
