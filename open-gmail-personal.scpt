set myURL to "https://mail.google.com/mail/u/1/"

tell application "Safari"
    -- Check if Safari is running
    if not (exists window 1) then
        make new document with properties {URL:myURL}
        activate
        return
    end if

    set allWindows to every window

    -- Loop through each window and then each tab to check if Url is opened.
    repeat with aWindow in allWindows
        set allTabs to every tab of aWindow
        repeat with aTab in allTabs
            if URL of aTab contains myURL then
                if miniaturized of aWindow then
                    set miniaturized of aWindow to false
                end if
                set current tab of aWindow to aTab
                set index of aWindow to 1 -- bring the window to the front
                activate
                return
            end if
        end repeat
    end repeat

    -- If Url is not found, open a new tab with Url in the frontmost window.
    make new document with properties {URL:myURL}
    activate
    return
end tell
