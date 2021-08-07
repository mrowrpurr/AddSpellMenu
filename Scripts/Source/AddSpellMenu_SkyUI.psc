scriptName AddSpellMenu_SkyUI

bool function IsSkyUIInstalled() global
    return Game.GetModByName("SkyUI_SE.esp") != 255
endFunction