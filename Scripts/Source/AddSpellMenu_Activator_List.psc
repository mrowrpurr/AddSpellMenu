scriptName AddSpellMenu_Activator_List extends ObjectReference  

AddSpellMenu_QuestScript property ModQuest auto

event OnEquipped(Actor akActor)
    AddSpellMenu_Menu_Controls.CloseInventoryMenu()
    AddSpellMenu_SearchAndList.ListMods(ModQuest)
endEvent