scriptName AddSpellMenu_QuestScript extends Quest  

string ModName = "AddSpellMenu.esp"
int AddSpellMenu_SearchTomeID = 0xd68
int AddSpellMenu_ListTomeID   = 0xd69

event OnInit()
    AddSpellTomesToPlayer()
endEvent

function AddSpellTomesToPlayer()
    Actor player = Game.GetPlayer()
    player.AddItem(GetModForm(AddSpellMenu_ListTomeID))
    player.AddItem(GetModForm(AddSpellMenu_SearchTomeID))
endFunction

Form function GetModForm(int formId)
    return Game.GetFormFromFile(formId, ModName)
endFunction