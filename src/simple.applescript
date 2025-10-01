tell application "Notes"
    set noteCount to count of notes of folder "Input" of default account
end tell
return "Number of notes in 'Input': " & noteCount