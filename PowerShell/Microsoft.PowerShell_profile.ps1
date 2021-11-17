
# __________________ Environment _____________________________
$env:Path += ";C:\Program Files\klogg"
$env:Path += ";D:\Personal\EverythingCLI"

Import-Module posh-git;

function Prompt{
    $max_length = 60;
    $powershell = 'PS ';
    $powershell_len = 3;

    $prompt = '>'
    $prompt_len = 1;

    # Need -Force to get folders with "hidden" attributes
    $current = Get-Location | Get-Item -Force;    
    $full_path = $current.FullName;
    $path_len = $full_path.Length;

    $full_len = $powershell_len + $path_len + $prompt_len;
    if (($full_len -le $max_length)){
        # We can just use the normal prompt
        return $powershell + $full_path + $prompt;
    }
    else
    {
        # We need to truncate
        $dots = '...'
        $dots_len = 3;

        $root = $current.Root.Name;
        $root_len = $root.Length;

        $right_side_len = $max_length - ($powershell_len + $root_len + $dots_len + $prompt_len);
        $left_side_len = $full_path.Length - $right_side_len;

        $right_path = $full_path.Substring($left_side_len);

        return $powershell + $root + $dots + $right_path + $prompt;
    }
}

# ______________________ Location Changing ______________________________
function Downloads() {
    Set-Location ("C:\Users\JSCHERBER\Downloads");
}

$oid = "E:\Source\Repos\Security-OneIdentity";

Set-Alias sdiff "C:\Users\jscherber\AppData\Local\semanticmerge\semanticmergetool.exe";

# function Serverlogs($subFolder) {
#     $serverPath = "D:\Apex\ServerLogs\";

#     if ($subFolder)
#     {
#         # Concatenation needs to be wrapped in parans
#         Set-Location ($serverPath + "*" + $subFolder + "*\");
#     }
#     else {
#         Set-Location $serverPath;
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

function es {
    # uses the current directory as the execute path
    # todo wrap search term argument in wildcards (*)
    $current = Get-Location | Get-Item -Force; 
    es.exe -path $current.FullName $args;
}

# _____________ GIT ____________________
function gitstashstage
{
    # https://stackoverflow.com/a/59874960
    git stash -- $(git diff --staged --name-only)
}

# https://www.hanselman.com/blog/spend-less-time-cding-around-directories-with-the-powershell-z-shortcut
#Import-Module z

# search everything
# https://www.voidtools.com/support/everything/command_line_interface/

# prompt
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_prompts?view=powershell-7.1
# function prompt {
#     $(if (Test-Path variable:/PSDebugContext) { '[DBG]: ' } else { '' })
#     + [System.Environment]::NewLine
#     + 'PS ' + $(Get-Location)
#     + $(if ($NestedPromptLevel -ge 1) { '>>' })
#     + '> '
# }

# Sudo (priv elevation)
# https://github.com/gerardog/gsudo

Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'
