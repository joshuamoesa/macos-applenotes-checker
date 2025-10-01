-- This script finds all notes in the "Product Updates", "Sales Enablement Resources", and "Marketing Updates" subfolders
-- (within the "Input" folder) in Apple Notes, marking them as (NEW) if created within the last week, or (OVERDUE) otherwise.
-- It logs the results to the console.


-- Recursive handler to find notes in a folder and its subfolders, grouping by NEW, OVERDUE, READNOW
on findNotesInFolder(f, newNotes, overdueNotes, readnowNotes)
	tell application "Notes"
		set folderName to name of f
		set oneMonthAgo to (current date) - (30 * days)
		set oneAndHalfMonthAgo to (current date) - (45 * days)
		repeat with n in notes of f
			if not (name of n starts with "Template") then
				set noteDate to creation date of n
				set {year:y, month:m, day:d} to noteDate
				set mNum to m as integer
				set mStr to text -2 thru -1 of ("0" & mNum)
				set dStr to text -2 thru -1 of ("0" & d)
				set dateStr to (y as string) & "-" & mStr & "-" & dStr
				set noteText to ("- " & name of n & " (" & folderName & ", " & dateStr & ")")
				if noteDate is greater than oneMonthAgo then
					set end of newNotes to noteText
				else if noteDate is less than or equal to oneMonthAgo and noteDate is greater than oneAndHalfMonthAgo then
					set end of overdueNotes to noteText
				else
					set end of readnowNotes to noteText
				end if
			end if
		end repeat
		repeat with sf in folders of f
			my findNotesInFolder(sf, newNotes, overdueNotes, readnowNotes)
		end repeat
	end tell
end findNotesInFolder



tell application "Notes"
	-- Prepare empty lists to collect notes by group
	set newNotes to {}
	set overdueNotes to {}
	set readnowNotes to {}
	-- Set the target folder to "Input" in the default account
	set inputFolder to folder "Input" of default account
	-- Only check in the specified subfolders
	set marketVerticalTrendsFolder to folder "Market Vertical Trends" of inputFolder
	set technicalTrendsFolder to folder "Technical Trends" of inputFolder
	set partnerEnablementFolder to folder "Partner Enablement" of inputFolder
	set competitiveIntelligenceFolder to folder "Competitive Intelligence" of inputFolder
	set eventInformationFolder to folder "Event Information" of inputFolder
	set siemensMendixFolder to folder "Siemens Mendix Strategic Reference Knowledge" of inputFolder
	-- Search for notes in each specified subfolder
	my findNotesInFolder(marketVerticalTrendsFolder, newNotes, overdueNotes, readnowNotes)
	my findNotesInFolder(technicalTrendsFolder, newNotes, overdueNotes, readnowNotes)
	my findNotesInFolder(partnerEnablementFolder, newNotes, overdueNotes, readnowNotes)
	my findNotesInFolder(competitiveIntelligenceFolder, newNotes, overdueNotes, readnowNotes)
	my findNotesInFolder(eventInformationFolder, newNotes, overdueNotes, readnowNotes)
	my findNotesInFolder(siemensMendixFolder, newNotes, overdueNotes, readnowNotes)
end tell



set output to ""
if (count of newNotes) > 0 then
	set output to output & "NEW:\n"
	repeat with itemText in newNotes
		set output to output & itemText & "\n"
	end repeat
end if
if (count of overdueNotes) > 0 then
	set output to output & "OVERDUE:\n"
	repeat with itemText in overdueNotes
		set output to output & itemText & "\n"
	end repeat
end if
if (count of readnowNotes) > 0 then
	set output to output & "READNOW:\n"
	repeat with itemText in readnowNotes
		set output to output & itemText & "\n"
	end repeat
end if
if (count of newNotes) = 0 and (count of overdueNotes) = 0 and (count of readnowNotes) = 0 then
	set output to "No matching notes found."
end if

return output
