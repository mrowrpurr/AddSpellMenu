scriptName AddSpellMenu_PlayerScript extends ReferenceAlias  
{Player script attached to v2 Quest (because v1 didn't have a Player Alias and it can't be added after someone installs the mod)
When the mod initializes with v2 Quest or when the player loads a game this triggers a mod version upgrade}

event OnInit()
    Utility.Wait(0.5) ; In some circumstances this will fire before the v1 Quest OnInit, add a delay for versioning safety
    AddSpellMenu_Versioning.Upgrade()
endEvent

event OnPlayerLoadGame()
    AddSpellMenu_Versioning.Upgrade()
endEvent