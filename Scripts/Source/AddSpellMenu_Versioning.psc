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
        player.RemoveItem(AddSpellMenu_Forms.GetPackActivatorForm())
        if player.GetItemCount(AddSpellMenu_Forms.GetActivatorForm()) == 1
            Debug.Notification("[AddSpellMenu] Upgrading to v3 (Removed pack)")
        else
            player.AddItem(AddSpellMenu_Forms.GetActivatorForm())
            Debug.Notification("[AddSpellMenu] Upgrading to v3 (Removed pack and added [AddSpellMenu])")
        endIf
    else
        if player.GetItemCount(AddSpellMenu_Forms.GetActivatorForm()) == 0
            player.AddItem(AddSpellMenu_Forms.GetActivatorForm())
            Debug.Notification("[AddSpellMenu] Upgrading to v3 (Added [AddSpellMenu])")
        endIf
    endIf
endFunction