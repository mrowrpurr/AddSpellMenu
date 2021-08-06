scriptName AddSpellMenu_Versioning hidden
{Performs mod version upgrades.
The current/previous version numbers are stored on the Quest v2 Player Script Quest Alias.}

int function GetCurrentVersion() global
    return 3
endFunction

function FirstRun() global
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript() as AddSpellMenu_QuestScript
    modQuest.CurrentModVersion = GetCurrentVersion()
    modQuest.PreviousModVersion = GetCurrentVersion()
endFunction

function Upgrade() global
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript() as AddSpellMenu_QuestScript
    modQuest.CurrentModVersion = GetCurrentVersion()
    bool newPackAdded = false

    if modQuest.PreviousModVersion < 2
        newPackAdded = UpgradeToV2()
    endIf

    if modQuest.PreviousModVersion < 3
        UpgradeToV3()
    endIf
    
    modQuest.PreviousModVersion = GetCurrentVersion()
endFunction

bool function UpgradeToV2() global
    Actor player = Game.GetPlayer()
    if player.GetItemCount(AddSpellMenu_Forms.GetPackActivatorForm()) == 0
        ObjectReference packContainer = AddSpellMenu_Forms.GetPackContainerInstance()
        packContainer.AddItem(AddSpellMenu_Forms.GetListActivatorForm())
        packContainer.AddItem(AddSpellMenu_Forms.GetSearchActivatorForm())
        if ! player.HasSpell(AddSpellMenu_Forms.GetListSpell()) && player.GetItemCount(AddSpellMenu_Forms.GetListSpellTomeForm()) == 0
            packContainer.AddItem(AddSpellMenu_Forms.GetListSpellTomeForm())
        endIf
        if ! player.HasSpell(AddSpellMenu_Forms.GetSearchSpell()) && player.GetItemCount(AddSpellMenu_Forms.GetSearchSpellTomeForm()) == 0
            packContainer.AddItem(AddSpellMenu_Forms.GetSearchSpellTomeForm())
        endIf
        player.AddItem(AddSpellMenu_Forms.GetPackActivatorForm())
    endIf
endFunction

function UpgradeToV3() global
    Actor player = Game.GetPlayer()
    if player.GetItemCount(AddSpellMenu_Forms.GetPackActivatorForm()) == 1
        ObjectReference packContainer = AddSpellMenu_Forms.GetPackContainerInstance()
        packContainer.AddItem(AddSpellMenu_Forms.GetNpcSpellTomeForm())
        if AddSpellMenu_Forms.GetModQuestScript().PreviousModVersion == 2
            Debug.Notification("[AddSpellMenu] Upgrading to v3 (NPC spell tomes added to pack)")
        else
            Debug.Notification("[AddSpellMenu] Upgrading to v3 (Added new pack)")
        endIf
    elseIf player.GetItemCount(AddSpellMenu_Forms.GetPackActivatorForm()) == 0
        ObjectReference packContainer = AddSpellMenu_Forms.GetPackContainerInstance()
        packContainer.AddItem(AddSpellMenu_Forms.GetNpcSpellTomeForm())
        player.AddItem(AddSpellMenu_Forms.GetPackActivatorForm())
        Debug.Notification("[AddSpellMenu] Upgrading to v3 (Added new pack)")
    endIf
endFunction