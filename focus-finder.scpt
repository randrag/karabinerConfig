tell application "Finder"
	if (count of windows) > 0 then
		activate
	else
		activate
		open (POSIX file "/Users/roland" as alias)
	end if
end tell
