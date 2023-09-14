$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if(-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    throw "Must be run as Admin";
}

Set-ExecutionPolicy Bypass -Scope Process -Force;
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
# iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Get Chocolately
winget install chocolatey.chocolatey;

# Chocolately
choco install notion -y;
choco install spotify -y;
choco install vscode -y;
choco install adobereader -y;
choco install klogg -y;
choco install autohotkey -y;
choco install windirstat -y;
choco install x-mouse-button-control -y;
choco install ditto -y;
choco install 7zip.install -y;
choco install vlc -y;
choco install python3 -y;
choco install git.install -y;
choco install win-vind -y;
choco install Firefox --params "/NoDesktopShortcut /RemoveDistributionDir";
choco install everything --params "/folder-context-menu /run-on-system-startup /client-service";

# PowerShell
choco install powershell-core --version=7.1.1
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

