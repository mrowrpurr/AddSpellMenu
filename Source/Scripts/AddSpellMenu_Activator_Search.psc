scriptName AddSpellMenu_Activator_Search extends ObjectReference  
{Represents the inventory item which activates searching for spells}

AddSpellMenu_QuestScript property ModQuest auto

event OnEquipped(Actor akActor)
    AddSpellMenu_Menu_Controls.CloseInventoryMenu()
    AddSpellMenu_SearchAndList.SearchModsAndSpells(ModQuest)
endEvent