scriptName AddSpellMenu_Activator extends ObjectReference  
{Represents the inventory item which activates menu to search spells or list mods}

event OnEquipped(Actor player)
    AddSpellMenu_Messages_Navigation.Clear()
    AddSpellMenu_Npcs.SetCurrentTarget(player)
    AddSpellMenu_Menu_Controls.CloseAllOpenMenus()
    AddSpellMenu_UI.ShowAddSpellMenu(player)
endEvent