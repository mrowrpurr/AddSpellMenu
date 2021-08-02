scriptName AddSpellMenu_Activator_Search extends ObjectReference  

AddSpellMenu_QuestScript property ModQuest auto

event OnEquipped(Actor akActor)
    AddSpellMenu_Menu_Controls.CloseInventoryMenu()
    AddSpellMenu_SearchAndList.SearchModsAndSpells(ModQuest)
endEvent