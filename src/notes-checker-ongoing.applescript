-- This script finds all notes in the "Customer Feedback & Case Studies" and "Internal Process Updates" subfolders
-- (within the "Input" folder) in Apple Notes. All notes are marked as READNOW, regardless of age.
-- The results are logged to the console under the READNOW group.


-- Recursive handler to find notes in a folder and its subfolders, grouping by NEW, OVERDUE, READNOW

on findNotesInFolder(f, readnowNotes)
	tell application "Notes"
		set folderName to name of f
		repeat with n in notes of f
			if not (name of n starts with "Template") then
				set noteDate to creation date of n
				set {year:y, month:m, day:d} to noteDate
				set mNum to m as integer
				set mStr to text -2 thru -1 of ("0" & mNum)
				set dStr to text -2 thru -1 of ("0" & d)
				set dateStr to (y as string) & "-" & mStr & "-" & dStr
				set noteText to ("- " & name of n & " (" & folderName & ", " & dateStr & ")")
				set end of readnowNotes to noteText
			end if
		end repeat
		repeat with sf in folders of f
			my findNotesInFolder(sf, readnowNotes)
		end repeat
	end tell
end findNotesInFolder




tell application "Notes"
	-- Prepare a list to collect all notes as READNOW
	set readnowNotes to {}
	-- Set the target folder to "Input" in the default account
	set inputFolder to folder "Input" of default account
	-- Only check in the specified subfolders
	set customerFeedbackFolder to folder "Customer Feedback & Case Studies" of inputFolder
	set internalProcessUpdatesFolder to folder "Internal Process Updates" of inputFolder
	-- Search for notes in each specified subfolder
	my findNotesInFolder(customerFeedbackFolder, readnowNotes)
	my findNotesInFolder(internalProcessUpdatesFolder, readnowNotes)
end tell




set output to ""
if (count of readnowNotes) > 0 then
	set output to output & "READNOW:\n"
	repeat with itemText in readnowNotes
		set output to output & itemText & "\n"
	end repeat
else
	set output to "No matching notes found."
end if

return output
