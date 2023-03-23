# Define variables
$TaskName = "AutoConnectVPN"
$TaskDescription = "Automatically connects to MSFTVPN-Manual on user logon"
$VPNName = "MSFTVPN-Manual"
$ActionScript =
  '-Command "Add-Type -AssemblyName System.Data;
  Add-Type -AssemblyName PresentationFramework;
  $vpnName = ''' + $VPNName + '''; $retryInterval = 5;
  $vpnStatus = (Get-VpnConnection -Name $vpnName).ConnectionStatus;
  while($vpnStatus -ne ''Connected'') {
    rasdial $vpnName;
    Start-Sleep -Seconds $retryInterval;
    $vpnStatus = (Get-VpnConnection -Name $vpnName).ConnectionStatus
  }"'

# Create the scheduled task action
$TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $ActionScript

# Create the scheduled task trigger
$TaskTrigger = New-ScheduledTaskTrigger -AtLogon

# Create the scheduled task principal (run as the current user, only when the user is logged on)
$TaskPrincipal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType Interactive -RunLevel Limited

# Create the scheduled task
Register-ScheduledTask -TaskName $TaskName -Description $TaskDescription -Action $TaskAction -Trigger $TaskTrigger -Principal $TaskPrincipal
