scriptName AddSpellMenu_QuestScript extends Quest
{Represents the main quest script which initializes the mod if it has not already been initialized.
This does not have a Player Script Quest Alias (Quest v2 was added and has a Player Script)}

int property CurrentModVersion auto
int property PreviousModVersion auto

bool CurrentlySearchingForSpells = false

bool property OnlyShowSpellsWithSpellTomes
    bool function get()
        return AddSpellMenu_Forms.GetSpellTomesRequiredGlobal().GetValueInt() == 1
    endFunction
endProperty

event OnInit()
    AddSpellMenu_Versioning.FirstRun()
    AddSpellMenu_Versioning.Upgrade()
    if Game.GetPlayer().GetItemCount(AddSpellMenu_Forms.GetPackActivatorForm()) == 0
        AddItemsToPack()
        Game.GetPlayer().AddItem(AddSpellMenu_Forms.GetPackActivatorForm())
    endIf
endEvent

function AddItemsToPack()
    ObjectReference packContainer = AddSpellMenu_Forms.GetPackContainerInstance()
    packContainer.AddItem(AddSpellMenu_Forms.GetListSpellTomeForm())
    packContainer.AddItem(AddSpellMenu_Forms.GetSearchSpellTomeForm())
    packContainer.AddItem(AddSpellMenu_Forms.GetListActivatorForm())
    packContainer.AddItem(AddSpellMenu_Forms.GetSearchActivatorForm())
endFunction

event OnSpellChooserAddRemoveSpell(string eventName, string strArg, float numArg, Form sender)
    AddSpellMenu_Menu_SkyUISpellChooser.OnSpellChooserAddRemoveSpell(eventName, strArg, numArg, sender)
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

; DEPRECATED FIELDS / PROPERTIES (from v1)
GlobalVariable property AddSpellMenu_RequiresSpellTome auto ; Old property from v1 DEPRECATED
string ModName = ""                                         ; Old property from v1 DEPRECATED
int PackActivatorID = 0                                     ; Old property from v1 DEPRECATED