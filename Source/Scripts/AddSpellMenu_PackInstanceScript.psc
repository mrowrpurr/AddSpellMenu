scriptName AddSpellMenu_PackInstanceScript extends ObjectReference  

event OnItemRemoved(Form item, int count, ObjectReference itemRef, ObjectReference player)
    if GetNumItems() == 0
        player.RemoveItem(AddSpellMenu_Forms.GetPackActivatorForm())
    endIf
endEvent