scriptName AddSpellMenu_Activator_Pack extends ObjectReference  
{Represents the AddSpellMenu Pack which is given to the player when they install the mod}

AddSpellMenu_QuestScript property ModQuest auto

event OnEquipped(Actor player)
    AddSpellMenu_Menu_Controls.CloseInventoryMenu()
    AddSpellMenu_Forms.GetPackContainerInstance().Activate(player)
endEvent
