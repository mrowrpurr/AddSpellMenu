scriptName AddSpellMenu_Versioning

int function GetVersion() global
    return 2
endFunction

function Upgrade() global
    Debug.Trace("UPGRADE")
    if AddSpellMenu_Forms.GetModQuestScript().CurrentModVersion != 2
        UpgradeToV2()
    endIf
endFunction

function UpgradeToV2() global
    Debug.Trace("UPGRADING TO v2")
    ObjectReference packContainer = AddSpellMenu_Forms.GetPackContainerInstance()
    packContainer.RemoveItem(AddSpellMenu_Forms.GetListSpellTomeForm())
    packContainer.RemoveItem(AddSpellMenu_Forms.GetSearchSpellTomeForm())

    Actor player = Game.GetPlayer()
    Form pack = AddSpellMenu_Forms.GetPackActivatorForm()
    Debug.Notification("[AddSpellMenu] Upgrading to v2 (Adding new pack)")
    player.AddItem(pack)
endFunction