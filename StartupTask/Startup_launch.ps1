# Always run as admin

$StartUpCommands = @(
    "& 'C:\Program Files\AutoHotkey\AutoHotkey.exe' C:\Develop\environment-files\keymove.ahk",
    "& 'C:\Program Files\Ditto\Ditto.exe'"
)

$StartUpCommands | ForEach-Object { Invoke-Expression $_ };

