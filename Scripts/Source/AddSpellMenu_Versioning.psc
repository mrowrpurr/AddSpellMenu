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
        packContainer.AddItem(AddSpellMenu_Forms.GetActivatorForm())
        if ! player.HasSpell(AddSpellMenu_Forms.GetSpell()) && player.GetItemCount(AddSpellMenu_Forms.GetSpellTomeForm()) == 0
            packContainer.AddItem(AddSpellMenu_Forms.GetSpellTomeForm())
        endIf
        player.AddItem(AddSpellMenu_Forms.GetPackActivatorForm())
    endIf
endFunction

function UpgradeToV3() global
    Actor player = Game.GetPlayer()
    if player.GetItemCount(AddSpellMenu_Forms.GetPackActivatorForm()) == 1
        ObjectReference packContainer = AddSpellMenu_Forms.GetPackContainerInstance()
        if AddSpellMenu_Forms.GetModQuestScript().PreviousModVersion == 2
            Debug.Notification("[AddSpellMenu] Upgrading to v3 (NPC spell tomes added to pack)")
        else
            Debug.Notification("[AddSpellMenu] Upgrading to v3 (Added new pack)")
        endIf
    elseIf player.GetItemCount(AddSpellMenu_Forms.GetPackActivatorForm()) == 0
        ObjectReference packContainer = AddSpellMenu_Forms.GetPackContainerInstance()
        player.AddItem(AddSpellMenu_Forms.GetPackActivatorForm())
        Debug.Notification("[AddSpellMenu] Upgrading to v3 (Added new pack)")
    endIf
endFunction