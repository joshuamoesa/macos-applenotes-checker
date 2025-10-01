
-- This script runs the ongoing, weekly, and monthly notes checker scripts in sequence
-- and displays the output of each in a dialog box.


do shell script "osascript notes-checker-weekly.applescript"
do shell script "osascript notes-checker-monthly.applescript"


-- Run each script and capture its output
set ongoingOutput to do shell script "osascript notes-checker-ongoing.applescript"
set weeklyOutput to do shell script "osascript notes-checker-weekly.applescript"
set monthlyOutput to do shell script "osascript notes-checker-monthly.applescript"


-- Show the output of each script in a dialog box
display dialog "Ongoing Results:\n" & ongoingOutput buttons {"OK"} default button 1
display dialog "Weekly Results:\n" & weeklyOutput buttons {"OK"} default button 1
display dialog "Monthly Results:\n" & monthlyOutput buttons {"OK"} default button 1
