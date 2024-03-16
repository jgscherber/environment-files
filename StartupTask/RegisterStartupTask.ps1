param([string] $environmentFilesPath)
if (-not $environmentFilesPath)
{
    throw "Missing environmentFilesPath";
}

$taskName = "Startup utilities"
$startupFolder = "StartupTask"
$startupFile = "Startup_launch.ps1"
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

$startupFolderPath = $environmentFilesPath + "\" + $startupFolder;
$startupFilePath = $startupFolderPath + "\" + $startupFile;

# Create Task
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-WindowStyle Hidden -File `"$startupFilePath`"" -WorkingDirectory $startupFolderPath
$trigger = New-ScheduledTaskTrigger -AtLogOn -User "$currentUser"

$taskSettings = New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -WakeToRun -ExecutionTimeLimit (New-TimeSpan -Seconds 0) -Priority 7

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $taskSettings -Description 'Run startup script on system startup' -User "$currentUser" -RunLevel Highest