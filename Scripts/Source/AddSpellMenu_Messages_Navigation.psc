scriptName AddSpellMenu_Messages_Navigation hidden

function NavigateTo(string menuName) global
    Debug.Notification("[AddSpellMenu] Navigate to " + menuName)
    if menuName == "PlayerMainMenu"
        AddSpellMenu_Messages_MainMenu.ShowPlayerMainMenu()
    elseif menuName == "NpcMainMenu"
        AddSpellMenu_Messages_MainMenu.Show(AddSpellMenu_Npcs.GetCurrentTarget())
    else
        Debug.MessageBox("[AddSpellMenu Navigation] Unknown menu: " + menuName)
    endIf
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