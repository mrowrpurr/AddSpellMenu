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
    
    if modQuest.PreviousModVersion < 3
        UpgradeToV3()
        modQuest.PreviousModVersion = GetCurrentVersion()
    endIf
endFunction

function UpgradeToV3() global
    Actor player = Game.GetPlayer()

    ObjectReference packContainer = AddSpellMenu_Forms.GetPackContainerInstance()
    Spell shoutSpell = AddSpellMenu_Forms.GetSpell()
    Form shoutSpellTome = AddSpellMenu_Forms.GetShoutSpellTomeForm()
    Form npcSpellTome = AddSpellMenu_Forms.GetNpcSpellTomeForm()
    Form spellActivatorObject = AddSpellMenu_Forms.GetActivatorForm()
    Form packActivatorForm = AddSpellMenu_Forms.GetPackActivatorForm()

    ; Remove any old activators if they're around in the container or player inventory (and add a brand new one - we want new scripts attached to it)
    if packContainer.GetItemCount(spellActivatorObject) > 0
        packContainer.RemoveItem(spellActivatorObject)
        packContainer.AddItem(spellActivatorObject)
    endIf
    if player.GetItemCount(spellActivatorObject) > 0
        player.RemoveItem(spellActivatorObject, abSilent = true)
        player.AddItem(spellActivatorObject, abSilent = true)
    endIf

    ; If they don't know the main spell (and it's not already in the pack), add the spell tome
    if ! player.HasSpell(shoutSpell) && packContainer.GetItemCount(shoutSpellTome) == 0
        packContainer.AddItem(shoutSpellTome)
    endIf

    ; The pack can't have the NPC tome because it's new, so add it to the pack
    packContainer.AddItem(npcSpellTome)

    ; If they have a pack already, just tell them that the items were updated (but remove and re-add the pack silently) - we want new scripts attached to it
    if player.GetItemCount(packActivatorForm) > 0
        player.RemoveItem(packActivatorForm, abSilent = true)
        player.AddItem(packActivatorForm, abSilent = true)
        Debug.Notification("[AddSpellMenu] Upgrade to v3 (Added new items to pack!)")
    ; Else if they no longer have a pack, tell them that we added it
    else
        player.AddItem(packActivatorForm)
        Debug.Notification("[AddSpellMenu] Upgrade to v3 (Added pack with new items!)")
    endIf
endFunction