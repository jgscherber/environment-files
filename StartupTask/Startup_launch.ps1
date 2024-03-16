# Always run as admin

$localAppData = [Environment]::GetFolderPath("LocalApplicationData");
$StartUpCommands = @(
    "& 'C:\Program Files\AutoHotkey\AutoHotkey.exe' /restart '..\AutoHotKey\keymove.ahk'",
    "& 'C:\Program Files\Ditto\Ditto.exe'",
    "& 'C:\Program Files\Mozilla Firefox\firefox.exe'",
    "& 'explorer.exe'"
    "& '$localAppData\Programs\Notion\Notion.exe'"
)

# Create a new event source if it doesn't exist
$source = "StatupLaunch"
if (![System.Diagnostics.EventLog]::SourceExists($source)) {
    [System.Diagnostics.EventLog]::CreateEventSource($source, "Application")
}

function Write-Event($entryType, $message)
{
    Write-EventLog -LogName Application -Source $source -EntryType $entryType -EventId 1 -Message $message
}

$StartUpCommands | ForEach-Object {
    try {
        Write-Event "Info" "Starting $_"
        Start-Process -NoNewWindow -FilePath PowerShell -WorkingDirectory $PSScriptRoot -ArgumentList "$_"
    } catch {
        # Write the error to the event log
        Write-Event "Error" $_.Exception.Message
    }
}
