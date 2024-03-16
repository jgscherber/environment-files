param([string] $environmentFilesPath)
if (-not $environmentFilesPath)
{
    throw "Missing environmentFilesPath";
}

$taskName = "Startup utilities"
$startupFolder = "StartupTask"
$startupFile = "Startup_launch.ps1"
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

$starupFolderPath = $environmentFilesPath + "\" + $startupFolder;
$startupFilePath = $starupFolderPath + "\" + $startupFile;

# Create Task
$action = New-ScheduledTaskAction "powershell.exe $startupFilePath" -WorkingDirectory $environmentFilesPath
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-WindowStyle Hidden -File '$startupFilePath' -WorkingDirectory '$startupFolder'"
$trigger = New-ScheduledTaskTrigger -AtLogOn -User "$currentUser"

$taskSettings = = New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -DisallowStartIfOnBatteries $false -StopIfGoingOnBatteries $true -AllowHardTerminate $true -StartWhenAvailable $false -RunOnlyIfNetworkAvailable $false -AllowStartOnDemand $true -Enabled $true -Hidden $false -RunOnlyIfIdle $false -DisallowStartOnRemoteAppSession $false -UseUnifiedSchedulingEngine $true -WakeToRun $true -ExecutionTimeLimit (New-TimeSpan -Seconds 0) -Priority 7

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $taskSettings -Description 'Run startup script on system startup' -User "$currentUser" -RunLevel Highest