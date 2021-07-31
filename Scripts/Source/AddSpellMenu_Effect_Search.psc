scriptName AddSpellMenu_Effect_Search extends ActiveMagicEffect  

event OnEffectStart(Actor target, Actor caster)
    uiextensions.InitMenu("UITextEntryMenu")
    uiextensions.OpenMenu("UITextEntryMenu")
    string spellNameQuery = uiextensions.GetMenuResultString("UITextEntryMenu")
    
    int matchCount = 0
    ; string text = ""

    if spellNameQuery != ""

        Spell[] allSpellsInTheGame = PO3_SKSEFunctions.GetAllSpells(abIsPlayable = true)

        Spell[] matchingSpells = new Spell[128]
        uilistmenu listMenu = uiextensions.GetMenu("UIListMenu") as uilistmenu

        int index = 0
        while index < allSpellsInTheGame.Length && matchCount < 128
            Spell theSpell = allSpellsInTheGame[index]
            string theSpellName = theSpell.GetName()
            if StringUtil.Find(theSpellName, spellNameQuery) > -1 && ! caster.HasSpell(theSpell)
                listMenu.AddEntryItem(theSpellName)
                matchingSpells[matchCount] = theSpell
                matchCount += 1
            endIf
            index += 1
        endWhile
        if matchCount > 0
            listMenu.OpenMenu()
            int selectedSpellIndex = listMenu.GetResultInt()
            caster.AddSpell(matchingSpells[selectedSpellIndex])
        else
            Debug.MessageBox("No matching spells found")
        endIf
    endIf
endEvent