
# __________________ Environment _____________________________
$env:Path += ";C:\Program Files\klogg";
$env:Path += ";D:\Personal\EverythingCLI";
$env:Path += ";C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin";
$env:Path += ";C:\Users\jscherber\OneDrive - Microsoft\WorkItems\Tools\Nuget";

$oid = "C:\Repos\Security-OneIdentity";
$oyb = "C:\Repos\OneYubi\src";
$downloads = "D:\jscherber\OneDrive - Microsoft\Personal\Downloads";
$desktop = "C:\Users\jscherber\Desktop";
$hosts = "C:\Windows\System32\drivers\etc\hosts";

$powershellModulePath = "C:\Users\$($env:UserName)\PowerShell\Modules";
$env:PSModulePath += ";$powershellModulePath";

# function Prompt{
#     $max_length = 60;
#     $powershell = 'PS ';
#     $powershell_len = 3;

#     $prompt = '>'
#     $prompt_len = 1;

#     # Need -Force to get folders with "hidden" attributes
#     $current = Get-Location | Get-Item -Force;    
#     $full_path = $current.FullName;
#     $path_len = $full_path.Length;

#     $full_len = $powershell_len + $path_len + $prompt_len;
#     if (($full_len -le $max_length)){
#         # We can just use the normal prompt
#         return $powershell + $full_path + $prompt;
#     }
#     else
#     {
#         # We need to truncate
#         $dots = '...'
#         $dots_len = 3;

#         $root = $current.Root.Name;
#         $root_len = $root.Length;

#         $right_side_len = $max_length - ($powershell_len + $root_len + $dots_len + $prompt_len);
#         $left_side_len = $full_path.Length - $right_side_len;

#         $right_path = $full_path.Substring($left_side_len);

#         return $powershell + $root + $dots + $right_path + $prompt;
#     }
# }

# https://superuser.com/a/810991
function UnLnk($target)
{
        $sh = new-object -com wscript.shell
        $fullpath = (resolve-path $target).Path
        $targetpath = $sh.CreateShortcut($fullpath).TargetPath
        return $targetpath
}

function lsd {
    Get-ChildItem -Attributes D;
}

function Install-Module {
    Write-Host "Running Save-Module instead";
    if (-not (Test-Path -Path $powershellModulePath -PathType Container)) {
        Write-Host "Creating PowerShell module path: $powershellModulePath";
        New-Item -ItemType Directory -Path $powershellModulePath -Force | Out-Null;
    }
    
    Save-Module @args -Path $powershellModulePath;
}


# Recycle
Add-Type -AssemblyName Microsoft.VisualBasic
function Remove-ItemSafely($Path) {
    $item = Get-Item -Path $Path -ErrorAction SilentlyContinue
    if ($null -eq $item)
    {
        Write-Error("'{0}' not found" -f $Path)
    }
    else
    {
        $fullpath = $item.FullName
        if (Test-Path -Path $fullpath -PathType Container)
        {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory($fullpath,'OnlyErrorDialogs','SendToRecycleBin')
        }
        else
        {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($fullpath,'OnlyErrorDialogs','SendToRecycleBin')
        }
    }
}

Set-Alias ris Remove-ItemSafely -Option AllScope

function Start-RecycleBin {
    explorer 'C:\$Recycle.Bin\S-1-5-21-3612712526-2970697336-2168407165-4249'
}

# search everything
# https://www.voidtools.com/support/everything/command_line_interface/
function es {
    # uses the current directory as the execute path
    # todo wrap search term argument in wildcards (*)
    $current = Get-Location | Get-Item -Force; 
    es.exe -path $current.FullName $args;
}

# _____________ GIT ____________________

Set-Alias sdiff "C:\Users\jscherber\AppData\Local\semanticmerge\semanticmergetool.exe";

function gstst
{
    # https://stackoverflow.com/a/59874960
    git stash -- $(git diff --staged --name-only)
}

function gits
{
    git status
}

function gitch
{
    git checkout 
}

function gitc
{
    git commit -m $args
}

function gita
{
    git add $args
}

function gitp
{
    git push
}

function gitsyn
{
    git fetch origin
    git pull
}

# https://www.hanselman.com/blog/spend-less-time-cding-around-directories-with-the-powershell-z-shortcut
#Import-Module z

# Sudo (priv elevation)
# https://github.com/gerardog/gsudo


function Remove-BuildArtifacts {
    Get-ChildItem -Recurse -Attributes !H | 
    Where-Object { 
        $_.PSIsContainer -and (
            $_.Name -eq "bin" -or 
            $_.Name -eq "obj" -or 
            $_.Name -eq "packages" -or 
            $_.Name -eq ".vs"
        ) 
    } | 
    ForEach-Object { 
        Write-Host "Deleting folder: $($_.FullName)"
        Remove-Item $_.FullName -Recurse -Force
    }
    # This needs to be done separately because of the hidden attribute filter
    # -Force is needed to get folders with "hidden" attributes
    if (Get-Item ".vs" -Force -ErrorAction SilentlyContinue) {
        Write-Host "Deleting folder: .vs"
        Remove-Item ".vs" -Recurse -Force
    }
}

# https://ohmyposh.dev/docs/themes
# Must be last line of the file
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\nu4a.omp.json" | Invoke-Expression
