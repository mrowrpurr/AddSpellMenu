scriptName AddSpellMenu_PackInstanceScript extends ObjectReference  

event OnItemRemoved(Form item, int count, ObjectReference itemRef, ObjectReference theContainer)
    if GetNumItems() == 0
        Form packActivatorForm = Game.GetFormFromFile(0x639c, "AddSpellMenu.esp")
        theContainer.RemoveItem(packActivatorForm)
    endIf
endEvent