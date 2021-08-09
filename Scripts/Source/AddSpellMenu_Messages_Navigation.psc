scriptName AddSpellMenu_Messages_Navigation hidden

function NavigateTo(string menuName) global
    if menuName == "PlayerMainMenu"
        AddSpellMenu_Messages_MainMenu.Show()
    elseif menuName == "NpcMainMenu"
        Debug.MessageBox("Npc Main Menu Deprecated")
        AddSpellMenu_Messages_MainMenu.Show()
    elseif menuName == "NpcMenu"
        AddSpellMenu_Messages_NpcMenu.Show(AddSpellMenu_Npcs.GetCurrentTarget())
    else
        Debug.Trace("[AddSpellMenu Navigation] Unknown menu: " + menuName)
    endIf
endFunction

function Clear() global
    SetHistory(None)
endFunction

function Visit(string menuName) global
    string[] history = GetHistory()
    if history
        history = Utility.ResizeStringArray(history, history.Length + 1)
        history[history.Length - 1] = menuName
    else
        history = new string[1]
        history[0] = menuName
    endIf
    SetHistory(history)
endFunction

function GoBack(int numberOfPages = 1) global
    string[] history = GetHistory()
    if history
        if numberOfPages > history.Length
            Debug.Notification("Cannot go back " + numberOfPages + " pages, history does not go back that far")
        endIf
        string lastPage = history[history.Length - numberOfPages]
        SetHistory(Utility.ResizeStringArray(history, history.Length - numberOfPages))
        NavigateTo(lastPage)
    endIf
endFunction

function GoBackOrMainMenu(int numberOfPages = 1) global
    string[] history = GetHistory()
    if ! history || history.Length < numberOfPages
        AddSpellMenu_Messages_MainMenu.Show()
    else
        GoBack(numberOfPages)
    endIf
endFunction

string[] function GetHistory() global
    return AddSpellMenu_Forms.GetModQuestScriptv3().MenuHistory
endFunction

function SetHistory(string[] history) global
    AddSpellMenu_Forms.GetModQuestScriptv3().MenuHistory = history
endFunction