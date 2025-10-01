# macos-applenotes-checker

A collection of AppleScript utilities to check and report on Apple Notes in specific subfolders, grouped by time-based criteria. Designed for automation via Terminal, Apple Shortcuts, or scheduling tools.

## Scripts Overview

- **notes-checker-all.applescript**: Runs all checker scripts in sequence and displays their results. Use this for a full overview.
- **notes-checker-weekly.applescript**: Checks notes in the "Product Updates", "Sales Enablement Resources", and "Marketing Updates" subfolders (within "Input"). Groups notes as:
  - `NEW`: Created within the last week
  - `OVERDUE`: 8–14 days old
  - `READNOW`: Older than 14 days
- **notes-checker-monthly.applescript**: Checks notes in the following subfolders (within "Input"):
  - Market Vertical Trends
  - Technical Trends
  - Partner Enablement
  - Competitive Intelligence
  - Event Information
  - Siemens Mendix Strategic Reference Knowledge
  Groups notes as:
  - `NEW`: 30 days old or less
  - `OVERDUE`: 31–45 days old
  - `READNOW`: Older than 45 days
- **notes-checker-ongoing.applescript**: Checks notes in the "Customer Feedback & Case Studies" and "Internal Process Updates" subfolders (within "Input"). All notes are marked as `READNOW`.

## Usage

### Prerequisites
- macOS with the Notes app
- AppleScript enabled (default on macOS)
- Scripts saved as plain text (`.applescript`)

### Run from Terminal
To run all scripts and see results:

```sh
osascript /path/to/notes-checker-all.applescript
```

To run an individual script:

```sh
osascript /path/to/notes-checker-weekly.applescript
osascript /path/to/notes-checker-monthly.applescript
osascript /path/to/notes-checker-ongoing.applescript
```

The output will be shown in dialog boxes or printed to the terminal, depending on the script.

### Automate with Apple Shortcuts
1. Create a new Shortcut.
2. Add a "Run Shell Script" action with:
   ```sh
   osascript /path/to/notes-checker-all.applescript
   ```
3. (Optional) Add a "Send Email" action to email the results (use the output from the previous step).
4. (Optional) Schedule the Shortcut using the Automation tab (macOS Monterey or later).

### Scheduling (Alternative)
If you do not have the Automation tab in Shortcuts, you can use the Calendar app or a LaunchAgent to schedule script execution.

## Customization
- Edit the folder names in each script to match your Notes structure.
- Adjust the grouping logic as needed for your workflow.

## Troubleshooting
- If you see the character `�` in output, ensure your scripts use only standard ASCII characters (e.g., replace bullets with dashes).
- If you get permissions errors, grant Automation permissions in System Settings > Privacy & Security > Automation.
- Make sure the Notes app is installed and accessible.

## License
MIT
