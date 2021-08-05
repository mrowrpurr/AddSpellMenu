scriptName AddSpellMenu_PlayerScript extends ReferenceAlias  
{Player script attached to v2 Quest (because v1 didn't have a Player Alias and it can't be added after someone installs the mod)
When the mod initializes with v2 Quest or when the player loads a game this triggers a mod version upgrade}

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