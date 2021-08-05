scriptName AddSpellMenu_Versioning hidden
{Performs mod version upgrades.
The current/previous version numbers are stored on the Quest v2 Player Script Quest Alias.}

int function GetCurrentVersion() global
    return 2
endFunction

function FirstRun() global
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript() as AddSpellMenu_QuestScript
    modQuest.CurrentModVersion = GetCurrentVersion()
    modQuest.PreviousModVersion = GetCurrentVersion()
endFunction

function Upgrade() global
    AddSpellMenu_QuestScript modQuest = AddSpellMenu_Forms.GetModQuestScript() as AddSpellMenu_QuestScript
    modQuest.CurrentModVersion = GetCurrentVersion()

    if modQuest.PreviousModVersion < 2
        UpgradeToV2()
    endIf
    
    modQuest.PreviousModVersion = GetCurrentVersion()
endFunction

function UpgradeToV2() global
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
        Debug.Notification("[AddSpellMenu] Upgrading to v2 (Adding new pack)")
        Game.GetPlayer().AddItem(AddSpellMenu_Forms.GetPackActivatorForm())
    endIf
endFunction
