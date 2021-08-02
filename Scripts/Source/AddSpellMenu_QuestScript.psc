scriptName AddSpellMenu_QuestScript extends Quest

GlobalVariable property AddSpellMenu_RequiresSpellTome auto

string ModName = "AddSpellMenu.esp"

int PackActivatorID = 0x639c

bool CurrentlySearchingForSpells = false

bool property OnlyShowSpellsWithSpellTomes
    bool function get()
        return AddSpellMenu_RequiresSpellTome.GetValueInt()
    endFunction
endProperty

event OnInit()
    Game.GetPlayer().AddItem(GetModForm(PackActivatorID))
endEvent

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