scriptName AddSpellMenu_QuestScript extends Quest  

bool AddSpellsToPlayer = true
string ModName = "AddSpellMenu.esp"
int AddSpellMenu_SearchSpellID = 0x800
int AddSpellMenu_ListSpellID   = 0x801
int AddSpellMenu_SearchTomeID = 0xd68
int AddSpellMenu_ListTomeID   = 0xd69

event OnInit()
    AddSpellTomesToPlayer()
    if AddSpellsToPlayer
        AddSpellsToPlayer()
    endIf
endEvent

function AddSpellsToPlayer()
    Actor player = Game.GetPlayer()
    player.AddSpell(GetModForm(AddSpellMenu_ListSpellID) as Spell)
    player.AddSpell(GetModForm(AddSpellMenu_SearchSpellID) as Spell)
endFunction

function AddSpellTomesToPlayer()
    Actor player = Game.GetPlayer()
    player.AddItem(GetModForm(AddSpellMenu_ListTomeID))
    player.AddItem(GetModForm(AddSpellMenu_SearchTomeID))
endFunction

Form function GetModForm(int formId)
    return Game.GetFormFromFile(formId, ModName)
endFunction