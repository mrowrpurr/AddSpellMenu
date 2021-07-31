scriptName AddSpellMenu_QuestScript extends Quest

bool AddSpellsToPlayer = true

string ModName = "AddSpellMenu.esp"

int SearchSpellID = 0x800
int ListSpellID   = 0x801
int SearchTomeID  = 0xd68
int ListTomeID    = 0xd69

event OnInit()
    AddSpellTomesToPlayer()
    if AddSpellsToPlayer
        AddSpellsToPlayer()
    endIf
endEvent

function AddSpellsToPlayer()
    Actor player = Game.GetPlayer()
    player.AddSpell(GetModForm(ListSpellID) as Spell)
    player.AddSpell(GetModForm(SearchSpellID) as Spell)
    Game.GetPlayer().EquipSpell(GetModForm(ListSpellID) as Spell, 0)
    Game.GetPlayer().EquipSpell(GetModForm(ListSpellID) as Spell, 1)
endFunction

function AddSpellTomesToPlayer()
    Actor player = Game.GetPlayer()
    player.AddItem(GetModForm(ListTomeID))
    player.AddItem(GetModForm(SearchTomeID))
endFunction

Form function GetModForm(int formId)
    return Game.GetFormFromFile(formId, ModName)
endFunction

event OnBarterSpell(string eventName, string strArg, float numArg, Form sender)
    AddSpellMenu_BarterNpc.OnBarterSpell(eventName, strArg, numArg, sender)
endEvent