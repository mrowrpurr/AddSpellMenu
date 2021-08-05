scriptName AddSpellMenu_PlayerScript extends ReferenceAlias  

event OnPlayerLoadGame()
    Debug.Trace("ON PLAYER LOAD GAME")
    AddSpellMenu_Versioning.Upgrade()
endEvent