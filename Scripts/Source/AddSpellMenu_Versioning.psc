scriptName AddSpellMenu_Versioning

function Upgrade() global
    AddSpellMenu_PlayerScript playerScript = AddSpellMenu_Forms.GetModQuestScriptv2().GetAliasByName("PlayerRef") as AddSpellMenu_PlayerScript
    if playerScript.PreviousModVersion < 2
        UpgradeToV2()
    endIf
    playerScript.PreviousModVersion = playerScript.CurrentModVersion
endFunction

function UpgradeToV2() global
    Actor player = Game.GetPlayer()
    ObjectReference packContainer = AddSpellMenu_Forms.GetPackContainerInstance()
    packContainer.AddItem(AddSpellMenu_Forms.GetListActivatorForm())
    packContainer.AddItem(AddSpellMenu_Forms.GetSearchActivatorForm())
    if ! player.HasSpell(AddSpellMenu_Forms.GetListSpell())
        packContainer.AddItem(AddSpellMenu_Forms.GetListSpellTomeForm())
    endIf
    if ! player.HasSpell(AddSpellMenu_Forms.GetSearchSpell())
        packContainer.AddItem(AddSpellMenu_Forms.GetSearchSpellTomeForm())
    endIf
    Debug.Notification("[AddSpellMenu] Upgrading to v2 (Adding new pack)")
    Game.GetPlayer().AddItem(AddSpellMenu_Forms.GetPackActivatorForm())
endFunction
