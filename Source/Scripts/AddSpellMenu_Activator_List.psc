scriptName AddSpellMenu_Activator_List extends ObjectReference  
{Represents the inventory item which activates showing the list of mods}

AddSpellMenu_QuestScript property ModQuest auto

event OnEquipped(Actor akActor)
    AddSpellMenu_Menu_Controls.CloseInventoryMenu()
    AddSpellMenu_SearchAndList.ListMods(ModQuest)
endEvent