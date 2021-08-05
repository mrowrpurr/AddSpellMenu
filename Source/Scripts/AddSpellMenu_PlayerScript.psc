scriptName AddSpellMenu_PlayerScript extends ReferenceAlias  

int property CurrentModVersion auto
int property PreviousModVersion auto

event OnInit()
    CurrentModVersion = 2
    AddSpellMenu_Versioning.Upgrade()
endEvent

event OnPlayerLoadGame()
    CurrentModVersion = 2
    AddSpellMenu_Versioning.Upgrade()
endEvent