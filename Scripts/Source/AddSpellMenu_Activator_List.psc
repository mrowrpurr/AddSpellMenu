scriptName AddSpellMenu_Activator_List extends ObjectReference  
{Represents the inventory item which activates showing the list of mods}

AddSpellMenu_QuestScript property ModQuest auto ; DEPRECATED

event OnEquipped(Actor _)
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = Game.GetPlayer()
    AddSpellMenu_Menu_Controls.CloseInventoryMenu()
    AddSpellMenu_SearchAndList.ListMods()
endEvent