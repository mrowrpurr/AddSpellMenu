scriptName AddSpellMenu_Questv3Script extends Quest  

;For supporting 'Back' in menus
string property PreviousMenuName auto ; TODO REMOVE ME
string[] property MenuHistory auto

; For tracking the NPC which is currently being managed via menus
Actor property MenuSelectedNpc auto

; For tracking saved NPCs
Form[] property SavedNPCForms auto
string[] property SavedNPCNames auto

; Listen for SkyUI / UIMagicMenu to close and then go back to NPC or Player menu
function ListenForUIMagicMenuEvents()
    RegisterForModEvent("UIMagicMenu_CloseMenu", "OnMagicMenuClose")
endFunction

event OnMagicMenuClose(string eventName, string strArg, float floatArg, Form sender)
    AddSpellMenu_Messages_Navigation.GoBackOrMainMenu()
    UnregisterForModEvent("UIMagicMenu_CloseMenu")
endEvent