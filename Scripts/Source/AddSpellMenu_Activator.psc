scriptName AddSpellMenu_Activator extends ObjectReference  
{Represents the inventory item which activates menu to search spells or list mods}

event OnEquipped(Actor player)
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = player
    AddSpellMenu_Menu_Controls.CloseInventoryMenu()
    int selection = AddSpellMenu_Forms.GetMessage().Show()
    int searchIndex = 0
    int listIndex = 1
    int cancelIndex = 2
    if selection == searchIndex
        AddSpellMenu_SearchAndList.SearchModsAndSpells()
    elseif selection == listIndex
        AddSpellMenu_SearchAndList.ListMods()
    endIf
endEvent