scriptName AddSpellMenu_Questv3Script extends Quest  

;For supporting 'Back' in menus
string property PreviousMenuName auto

; For tracking the NPC which is currently being managed via menus
Actor property MenuSelectedNpc auto

; Listen for SkyUI / UIMagicMenu to close and then go back to NPC or Player menu
function ListenForUIMagicMenuEvents()
    RegisterForModEvent("UIMagicMenu_CloseMenu", "OnMagicMenuClose")
endFunction

event OnMagicMenuClose(string eventName, string strArg, float floatArg, Form sender)
    AddSpellMenu_UI.ShowNpcOrPlayerSpellMenu()
    UnregisterForModEvent("UIMagicMenu_CloseMenu")
endEvent