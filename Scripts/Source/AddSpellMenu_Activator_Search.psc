scriptName AddSpellMenu_Activator_Search extends ObjectReference  
{Represents the inventory item which activates searching for spells}

AddSpellMenu_QuestScript property ModQuest auto ; DEPRECATED

event OnEquipped(Actor _)
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = Game.GetPlayer()
    AddSpellMenu_Menu_Controls.CloseInventoryMenu()
    AddSpellMenu_SearchAndList.SearchModsAndSpells()
endEvent