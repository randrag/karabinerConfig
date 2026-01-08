do shell script "date +%Y-%m-%d"
set theDate to the result

set savedClipboard to the clipboard

set the clipboard to theDate

tell application "System Events"
   set frontApp to name of first application process whose frontmost is true
   tell process frontApp
      tell menu bar 1
         tell menu bar item "Edit"
            tell menu "Edit"
               click menu item "Paste"
               delay 0.25 -- otherwise it sometimes pastes the replaced value below
            end tell
         end tell
      end tell
   end tell
end tell

set the clipboard to savedClipboard
