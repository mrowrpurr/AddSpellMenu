scriptName AddSpellMenu_QuestScript extends Quest
{Represents the main quest script which initializes the mod if it has not already been initialized.
This does not have a Player Script Quest Alias (Quest v2 was added and has a Player Script)}

; The actor to give spells to, e.g. the player or a targetted NPC
Actor property CurrentTargetActor auto

; Properties for mod versioning
int property CurrentModVersion auto
int property PreviousModVersion auto

; Properties for Actors and ObjectReferences (so Skyrim won't clean up these resources)
Actor property _npc1 auto
Actor property _npc2 auto
ObjectReference property _object1 auto

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
    packContainer.AddItem(AddSpellMenu_Forms.GetSpellTomeForm())
    packContainer.AddItem(AddSpellMenu_Forms.GetActivatorForm())
endFunction

event OnSpellChooserAddRemoveSpell(string eventName, string strArg, float numArg, Form sender)
    AddSpellMenu_Menu_SkyUISpellChooser.OnSpellChooserAddRemoveSpell(eventName, strArg, numArg, sender)
endEvent

event OnSpellRemoverAddRemoveSpell(string eventName, string strArg, float numArg, Form sender)
    AddSpellMenu_Menu_SkyUISpellRemover.OnSpellRemoverAddRemoveSpell(eventName, strArg, numArg, sender)
endEvent

event UnregisterUIMagicMenuEvents(string eventName, string strArg, float numArg, Form sender)
    UnregisterForModEvent("UIMagicMenu_AddRemoveSpell")
    UnregisterForModEvent("UIMagicMenu_CloseMenu")
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