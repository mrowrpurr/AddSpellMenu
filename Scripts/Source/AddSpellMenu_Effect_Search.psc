scriptName AddSpellMenu_Effect_Search extends ActiveMagicEffect  

event OnEffectStart(Actor target, Actor caster)
    uiextensions.InitMenu("UITextEntryMenu")
    uiextensions.OpenMenu("UITextEntryMenu")
    string spellNameQuery = uiextensions.GetMenuResultString("UITextEntryMenu")
    
    int matchCount = 0
    string text = ""

    if spellNameQuery != ""
        ; Let's print out all of the spells which contain the text!
        Spell[] allSpellsInTheGame = PO3_SKSEFunctions.GetAllSpells(abIsPlayable = true)
        int index = 0
        while index < allSpellsInTheGame.Length && matchCount < 30
            Spell theSpell = allSpellsInTheGame[index]
            string theSpellName = theSpell.GetName()
            if StringUtil.Find(theSpellName, spellNameQuery) > -1
                text += theSpellName + "\n"
                matchCount += 1
            endIf
            index += 1
        endWhile
        if matchCount > 0
            Debug.MessageBox("Found " + matchCount + " spells:\n" + text)
        else
            Debug.MessageBox("No matching spells found")
        endIf
    endIf
endEvent