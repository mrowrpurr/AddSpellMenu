scriptName AddSpellMenu_Messages_Navigation hidden

; The navigation system really needs a much simpler rewrite

function NavigateTo(string menuName) global
    if GetCurrentPage() != menuName
        Debug.Trace("[AddSpellMenu] Navigate to " + menuName + "(Current Page: " + GetCurrentPage() + ")")
        if menuName == "PlayerMainMenu"
            AddSpellMenu_Messages_MainMenu.Show()
        elseif menuName == "NpcMenu"
            AddSpellMenu_Messages_NpcMenu.Show(AddSpellMenu_Npcs.GetCurrentTarget())
        else
            Debug.Trace("[AddSpellMenu Navigation] Unknown menu: " + menuName)
        endIf
    endIf
endFunction

function Clear() global
    string[] history
    SetHistory(history)
endFunction

string function GetCurrentPage() global
    string[] history = GetHistory()
    if history && history.Length > 0
        return history[history.Length - 1]
    else
        return ""
    endIf
endFunction

function Visit(string menuName) global
    if GetCurrentPage() != menuName
        Debug.Trace("[AddSpellMenu] Visit " + menuName)
        string[] history = GetHistory()
        if history
            history = Utility.ResizeStringArray(history, history.Length + 1)
            history[history.Length - 1] = menuName
        else
            history = new string[1]
            history[0] = menuName
        endIf
        SetHistory(history)
    endIf
endFunction

function GoBack(int numberOfPages = 1) global
    Debug.Trace("[AddSpellMenu] Go back")
    string[] history = GetHistory()
    if history
        if numberOfPages > history.Length
            Debug.Notification("Cannot go back " + numberOfPages + " pages, history does not go back that far")
        endIf
        string lastPage = history[history.Length - numberOfPages]
        SetHistory(Utility.ResizeStringArray(history, history.Length - numberOfPages))
        if lastPage != GetCurrentPage()
            NavigateTo(lastPage)
        endIf
    endIf
endFunction

function GoBackOrMainMenu(int numberOfPages = 1) global
    Debug.Trace("[AddSpellMenu] Go back or main menu")
    string[] history = GetHistory()
    if ! history || history.Length < numberOfPages
        NavigateTo("PlayerMainMenu")
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