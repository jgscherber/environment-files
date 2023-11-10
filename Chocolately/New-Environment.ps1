[CmdletBinding()]
param(
  [Parameter(Mandatory=$false, HelpMessage="Install location")]
  [ValidateSet('Home', 'Work')]
  [string]$environment = 'Home'
)

# Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy Unrestricted -Force;
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if(-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    throw "Must be run as Admin";
}

function Test-CommandExists([string] $commandName)
{
  $command = Get-Command $commandName -ErrorAction SilentlyContinue;
  return $null -ne $command;
}


if (-not (Test-CommandExists "choco"))
{
  Write-Host "choco command not found, installing Chocolately";
  winget install chocolatey.chocolatey;

  # Refresh the path, post installation
  $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

#### Chocolately ####
Write-Host "Installing application";
choco install 7zip.install -y;
choco install anki -y;
choco install autohotkey -y;
choco install chocolateygui -y;
choco install ditto -y;
choco install everything --params "/folder-context-menu /run-on-system-startup /client-service" -y;
choco install Firefox --params "/NoDesktopShortcut /RemoveDistributionDir" -y;
choco install git.install -y;
choco install github-desktop -y;
choco install jetbrainsmono -y;
choco install klogg -y;
choco install notion -y;
choco install obsidian -y;
choco install openjdk -y;
choco install paint.net -y;
choco install passwordsafe -y;
choco install powershell-core -y;
choco install python3 -y;
choco install remote-desktop-client -y;
choco install spotify -y;
choco install vscode -y;
choco install win-vind -y;
choco install windirstat -y;
choco install x-mouse-button-control -y;

if ($environment -eq "Home")
{
  choco install adobereader -y;
  choco install visualstudio2022community -y;
  choco install vlc -y;
}

if ($environment -eq "Work")
{
  choco install dotnetcore-2.1-sdk -y;
  choco install rdcman -y;
  choco install sql-server-management-studio -y;
  choco install visualstudio2022enterprise -y;
}

######### Dependent Installs ############
$Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

# VS Code
if (Test-CommandExists "code")
{
    # Generated using: code --list-extensions | % { "code --install-extension $_" }
    code --install-extension dvirtz.parquet-viewer
    code --install-extension eamodio.gitlens
    code --install-extension GitHub.copilot
    code --install-extension GitHub.copilot-chat
    code --install-extension GitHub.copilot-labs
    code --install-extension hediet.vscode-drawio
    code --install-extension janisdd.vscode-edit-csv
    code --install-extension johnpapa.vscode-peacock
    code --install-extension khaeransori.json2csv
    code --install-extension L13RARY.l13-diff
    code --install-extension mark-wiemer.vscode-autohotkey-plus-plus
    code --install-extension ms-dotnettools.csharp
    code --install-extension ms-dotnettools.vscode-dotnet-runtime
    code --install-extension ms-dotnettools.vscodeintellicode-csharp
    code --install-extension ms-mssql.data-workspace-vscode
    code --install-extension ms-mssql.mssql
    code --install-extension ms-mssql.sql-bindings-vscode
    code --install-extension ms-mssql.sql-database-projects-vscode
    code --install-extension ms-python.python
    code --install-extension ms-python.vscode-pylance
    code --install-extension ms-toolsai.jupyter
    code --install-extension ms-toolsai.jupyter-keymap
    code --install-extension ms-toolsai.jupyter-renderers
    code --install-extension ms-toolsai.vscode-jupyter-cell-tags
    code --install-extension ms-toolsai.vscode-jupyter-slideshow
    code --install-extension ms-vscode.powershell
    code --install-extension msazurermtools.azurerm-vscode-tools
    code --install-extension redhat.vscode-xml
    code --install-extension rosshamish.kuskus-kusto-language-server
    code --install-extension rosshamish.kuskus-kusto-syntax-highlighting
    code --install-extension yzhang.markdown-all-in-one
}