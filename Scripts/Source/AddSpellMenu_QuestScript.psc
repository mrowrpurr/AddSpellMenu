scriptName AddSpellMenu_QuestScript extends Quest

bool CurrentlySearchingForSpells = false

GlobalVariable property AddSpellMenu_RequiresSpellTome auto ; Old property from v1 DEPRECATED
string ModName = ""                                         ; Old property from v1 DEPRECATED
int PackActivatorID = 0                                     ; Old property from v1 DEPRECATED

bool property OnlyShowSpellsWithSpellTomes
    bool function get()
        return AddSpellMenu_Forms.GetSpellTomesRequiredGlobal().GetValueInt() == 1
    endFunction
endProperty

event OnInit()
    AddSpellMenu_PlayerScript playerScript = AddSpellMenu_Forms.GetModQuestScriptv2().GetAliasByName("PlayerRef") as AddSpellMenu_PlayerScript
    playerScript.CurrentModVersion = 2
    playerScript.PreviousModVersion = 2
    AddItemsToPack()
    Game.GetPlayer().AddItem(AddSpellMenu_Forms.GetPackActivatorForm())
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