If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break
}


$touchScreenDevice = Get-PnpDevice -FriendlyName "*touch screen*";
if (-not $touchScreenDevice) {
    Write-Error "Unable to find touchscreen"
    exit;
}

$screenStatus = $touchScreenDevice.Status;
if ($screenStatus -eq "OK") {
    Disable-PnpDevice $touchScreenDevice.DeviceID -Confirm:$false;
}
elseif ($screenStatus -eq "Error") {
    Enable-PnpDevice $touchScreenDevice.DeviceID -Confirm:$false;
}
else {
    Write-Error "Unknown status: $screenStatus"
    exit;
}
