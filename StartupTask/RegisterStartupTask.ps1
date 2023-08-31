param([string] $environmentFilesPath)

$startupFolder = "StartupTask"
$startupFile = "Startup_launch.ps1"

$starupFolderPath = $environmentFilesPath + "\" + $startupFolder;
$startupFilePath = $starupFolderPath + "\" + $startupFile;

# Create Task
$taskName = "Startup utilities"
$action = New-ScheduledTaskAction "powershell.exe $startupFilePath" -WorkingDirectory $environmentFilesPath
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest

# TODO task properties
$taskSettings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit 00:00:00
Register-ScheduledTask $taskName -Description "Run startup script on system startup" -Action $action -Trigger $trigger -Principal $principal -Settings $taskSettings
Start-ScheduledTask -TaskName $taskName