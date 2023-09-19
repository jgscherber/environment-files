# Source: https://gist.github.com/Braytiner/be2497d1a06f5a9d943dc7760693d460
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true, HelpMessage="Projects folder")]
  [string]$projectsFolder
)

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if(-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    throw "Must be run as Admin";
}

$userPath = $env:USERPROFILE
$pathExclusions = New-Object System.Collections.ArrayList
$processExclusions = New-Object System.Collections.ArrayList

$pathExclusions.Add($projectsFolder) > $null
$pathExclusions.Add('C:\Windows\Microsoft.NET') > $null
$pathExclusions.Add('C:\Windows\assembly') > $null

$pathExclusions.Add($userPath + '\.dotnet') > $null
$pathExclusions.Add($userPath + '\.librarymanager') > $null

$pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VisualStudio') > $null
$pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VisualStudio Services') > $null
$pathExclusions.Add($userPath + '\AppData\Local\GitCredentialManager') > $null
$pathExclusions.Add($userPath + '\AppData\Local\GitHubVisualStudio') > $null
$pathExclusions.Add($userPath + '\AppData\Local\Microsoft\dotnet') > $null
$pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VSApplicationInsights') > $null
$pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VSCommon') > $null
$pathExclusions.Add($userPath + '\AppData\Local\Temp\VSFeedbackIntelliCodeLogs') > $null

$pathExclusions.Add($userPath + '\AppData\Roaming\Microsoft\VisualStudio') > $null
$pathExclusions.Add($userPath + '\AppData\Roaming\NuGet') > $null
$pathExclusions.Add($userPath + '\AppData\Roaming\Visual Studio Setup') > $null
$pathExclusions.Add($userPath + '\AppData\Roaming\vstelemetry') > $null
$pathExclusions.Add($userPath + '\AppData\Roaming\HeidiSQL') > $null

$pathExclusions.Add('C:\ProgramData\Microsoft\VisualStudio') > $null
$pathExclusions.Add('C:\ProgramData\Microsoft\NetFramework') > $null
$pathExclusions.Add('C:\ProgramData\Microsoft Visual Studio') > $null
$pathExclusions.Add('C:\ProgramData\MySQL') > $null

$pathExclusions.Add('C:\Program Files\Microsoft Visual Studio') > $null
$pathExclusions.Add('C:\Program Files\dotnet') > $null
$pathExclusions.Add('C:\Program Files\Microsoft SDKs') > $null
$pathExclusions.Add('C:\Program Files\Microsoft SQL Server') > $null
$pathExclusions.Add('C:\Program Files\MySQL') > $null
$pathExclusions.Add('C:\Program Files\IIS') > $null
$pathExclusions.Add('C:\Program Files\IIS Express') > $null

$pathExclusions.Add('C:\Program Files (x86)\Microsoft Visual Studio') > $null
$pathExclusions.Add('C:\Program Files (x86)\dotnet') > $null
$pathExclusions.Add('C:\Program Files (x86)\Microsoft SDKs') > $null
$pathExclusions.Add('C:\Program Files (x86)\Microsoft SQL Server') > $null
$pathExclusions.Add('C:\Program Files (x86)\IIS') > $null
$pathExclusions.Add('C:\Program Files (x86)\IIS Express') > $null

$processExclusions.Add('ServiceHub.SettingsHost.exe') > $null
$processExclusions.Add('ServiceHub.IdentityHost.exe') > $null
$processExclusions.Add('ServiceHub.VSDetouredHost.exe') > $null
$processExclusions.Add('ServiceHub.Host.CLR.x86.exe') > $null
$processExclusions.Add('Microsoft.ServiceHub.Controller.exe') > $null
$processExclusions.Add('PerfWatson2.exe') > $null

################ Add Exclusions ###############
foreach ($exclusion in $pathExclusions) 
{
    Write-Host "Adding Path Exclusion: " $exclusion
    Add-MpPreference -ExclusionPath $exclusion
}

foreach ($exclusion in $processExclusions)
{
    Write-Host "Adding Process Exclusion: " $exclusion
    Add-MpPreference -ExclusionProcess $exclusion
}

############### Verify Exclusions ###############
Write-Host ""
Write-Host "Your Exclusions:"

$prefs = Get-MpPreference
$prefs.ExclusionPath
$prefs.ExclusionProcess

Write-Host ""
Write-Host "Enjoy faster build times and coding!"
Write-Host ""