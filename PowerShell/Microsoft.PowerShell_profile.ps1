
# __________________ Environment _____________________________
$env:Path += ";C:\Program Files\klogg"
$env:Path += ";C:\Users\JSCHERBER\EverythingCLI"

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

# function Prompt {
#     # It'd be better if this was fixed length
#     # e.g. C:\...(at most 10 characters) so
#     # total length would never be more then 3+3+10
#     # don't need break on slashes (C:\...pex\ is fine)
#     $parent = $current.Parent;

#     $current_name = $current.Name;
#     $parent_name = $parent.Name;
#     $root_name = $current.Root.Name;

#     if ($current_name -eq $root_name) {
#         # At the root
#         return "PS $root_name>"
#     }
#     elseif ($parent_name -eq $root_name) {
#         # One Down from root
#         return "PS $root_name$current_name>"
#     }
#     elseif ($parent.Parent.Name -eq $root_name) {
#         # Two down from root
#         return "PS $root_name$parent_name\$current_name>"
#     }
#     else {
#         # Many down
#         return "PS $root_name...\$parent_name\$current_name>"
#     }
# }

# ______________________ Location Changing ______________________________
function Jira($subFolder) {
    if ($subFolder)
    {
        # Concatenation needs to be wrapped in parans
        Set-Location ("D:\JIRA\*" + $subFolder + "*\");
    }
    else {
        Set-Location ("D:\JIRA\");
    }
}
function Apex() {
    Set-Location ("C:\Apex\Workspaces\Apex_Dev\Apex");
}

function Latitude() {
    Set-Location ("C:\Apex\Workspaces\Apex_Dev\Apex\Client\Web2_0\MVC\Applications\Latitude");
}

function Maps() {
    Set-Location ("D:\Maps\test-vendor\test-identifier\test-version");
}
function Downloads() {
    Set-Location ("C:\Users\JSCHERBER\Downloads");
}

function Serverlogs($subFolder) {
    $serverPath = "D:\Apex\ServerLogs\";

    if ($subFolder)
    {
        # Concatenation needs to be wrapped in parans
        Set-Location ($serverPath + "*" + $subFolder + "*\");
    }
    else {
        Set-Location $serverPath;
    }
}

# https://superuser.com/a/810991
function UnLnk($target)
{
        $sh = new-object -com wscript.shell
        $fullpath = (resolve-path $target).Path
        $targetpath = $sh.CreateShortcut($fullpath).TargetPath
        return $targetpath
}

function gcid {
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

# __________________ RNA Stuff ______________________________

function Start-ServerFilter
{
    & "C:\Apex\Workspaces\Apex_Dev\Apex\Server\Application\NoToolsNoTest.slnf"
}

function Start-Rna
{
    # `&` is "call operator"
    & "C:\Apex\Workspaces\Apex_Dev\Apex\Client\WPF\Applications\RouteNavigator\bin\Debug\RouteNavigator.exe"
}

function Start-SetupApex
{
    # `&` is "call operator"
    & "C:\Apex\EnvironmentSetupTool\EnvironmentSetupTool.exe"
}

function Start-KeyMove {
    & "C:\Program Files\AutoHotkey\AutoHotkey.exe" "D:\Development\Github\environment-files\keymove.ahk"
}

# function TransitMatrixBuilder {
#     & "C:\Apex\Workspaces\Apex_Dev\Apex\Server\Application\Services\TransitMatrixBuilder\bin\debug\Roadnet.Apex.Server.Services.TransitMatrixBuilder.exe" $args;
# }

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