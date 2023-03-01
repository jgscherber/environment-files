param([string] environmentFilesPath)

$startupFolder = "Startup"
$startupFile = "Startup.ps1"

$starupFolderPath = "$($environmentFilesPath)\$($startupFolder);
$startupFilePath = "$($starupFolderPath)\$($startupFile)";

# Create Task
$taskName = "Startup utilities"
$action = New-ScheduledTaskAction "powershell.exe $startupPath" -WorkingDirectory $startupFolderPath
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest

# TODO task properties
$taskSettings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit 00:00:00
Register-ScheduledTask $taskName -Description "Run Geneva Monitoring Agent on system startup" -Action $action -Trigger $trigger -Principal $principal -Settings $taskSettings
Start-ScheduledTask -TaskName $taskName