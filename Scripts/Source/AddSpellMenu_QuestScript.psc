scriptName AddSpellMenu_QuestScript extends Quest

GlobalVariable property AddSpellMenu_RequiresSpellTome auto

bool AddSpellsToPlayer = true
bool CurrentlySearchingForSpells = false

string ModName = "AddSpellMenu.esp"

int SearchSpellID = 0x800
int ListSpellID   = 0x801
int SearchTomeID  = 0xd68
int ListTomeID    = 0xd69

bool property OnlyShowSpellsWithSpellTomes
    bool function get()
        return AddSpellMenu_RequiresSpellTome.GetValueInt()
    endFunction
endProperty

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
    Game.GetPlayer().EquipSpell(GetModForm(SearchSpellID) as Spell, 1)
endFunction

function AddSpellTomesToPlayer()
    Actor player = Game.GetPlayer()
    player.AddItem(GetModForm(ListTomeID))
    player.AddItem(GetModForm(SearchTomeID))
endFunction

Form function GetModForm(int formId)
    return Game.GetFormFromFile(formId, ModName)
endFunction

event OnSpellChooserAddRemoveSpell(string eventName, string strArg, float numArg, Form sender)
    AddSpellMenu_Menu_SpellChooser.OnSpellChooserAddRemoveSpell(eventName, strArg, numArg, sender)
endEvent

function BeginSearchingNotifications()
    CurrentlySearchingForSpells = true
    RegisterForSingleUpdate(2.0)
endFunction

function EndSearchingNotifications()
    CurrentlySearchingForSpells = false
endFunction

event OnUpdate()
    if CurrentlySearchingForSpells
        Debug.Notification("Searching all spells... Please wait...")
        RegisterForSingleUpdate(2.0)
    endIf
endEvent