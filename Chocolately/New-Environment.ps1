[CmdletBinding()]
param(
  [Parameter(Mandatory=$false, HelpMessage="Install location")]
  [ValidateSet('Home', 'Work')]
  [string]$environment = 'Home'
)

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if(-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    throw "Must be run as Admin";
}

Set-ExecutionPolicy Bypass -Scope Process -Force;
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
# iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

$command = Get-Command choco -ErrorAction SilentlyContinue
if ($null -eq $command)
{
  # Get Chocolately
  winget install chocolatey.chocolatey;

  # Refresh the path, post installation
  $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

#### Chocolately ####
choco install notion -y;
choco install anki -y;
choco install paint.net -y;
choco install spotify -y;
choco install vscode -y;
choco install remote-desktop-client -y;
choco install klogg -y;
choco install autohotkey -y;
choco install windirstat -y;
choco install passwordsafe -y;
choco install x-mouse-button-control -y;
choco install ditto -y;
choco install 7zip.install -y;
choco install python3 -y;
choco install git.install -y;
choco install win-vind -y;
choco install github-desktop -y;
choco install Firefox --params "/NoDesktopShortcut /RemoveDistributionDir" -y;
choco install everything --params "/folder-context-menu /run-on-system-startup /client-service" -y;
choco install obsidian -y;
choco install chocolateygui -y;

if ($environment -eq "Home")
{
  choco install adobereader -y;
  choco install vlc -y;
  choco install visualstudio2022community -y;
}

if ($environment -eq "Work")
{
  choco install visualstudio2022enterprise -y;
  choco install sql-server-management-studio -y;
}


# PowerShell
choco install powershell-core -y;
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

