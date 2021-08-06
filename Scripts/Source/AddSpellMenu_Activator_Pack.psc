scriptName AddSpellMenu_Activator_Pack extends ObjectReference  
{Represents the AddSpellMenu Pack which is given to the player when they install the mod}

AddSpellMenu_QuestScript property ModQuest auto ; DEPRECATED

event OnEquipped(Actor player)
    AddSpellMenu_Menu_Controls.CloseAllOpenMenus()
    ObjectReference packContainer = AddSpellMenu_Forms.GetPackContainerInstance()
    if packContainer == None
        Debug.Notification("AddSpellMenu Pack container not found in the world")
    endIf
    packContainer.Activate(player)
endEvent
