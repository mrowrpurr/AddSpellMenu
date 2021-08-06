scriptName AddSpellMenu_Activator extends ObjectReference  
{Represents the inventory item which activates menu to search spells or list mods}

event OnEquipped(Actor player)
    ; TODO have activator default to player :) ?
    AddSpellMenu_Forms.GetModQuestScript().CurrentTargetActor = player
    AddSpellMenu_Menu_Controls.CloseAllOpenMenus()
    AddSpellMenu_UI.ShowAddSpellMenu()
endEvent