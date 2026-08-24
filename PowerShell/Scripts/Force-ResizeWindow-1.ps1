$processName = "PowerPom";

Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
public class WinAPI {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
    
    [DllImport("user32.dll")]
    public static extern bool EnumWindows(EnumWindowsProc enumProc, IntPtr lParam);
    
    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint processId);
    
    [DllImport("user32.dll")]
    public static extern int GetClassName(IntPtr hWnd, StringBuilder lpClassName, int nMaxCount);
    
    [DllImport("user32.dll")]
    public static extern bool IsWindowVisible(IntPtr hWnd);
    
    [DllImport("user32.dll")]
    public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);
    
    public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);
}
"@

function Find-UWPWindow {
    param(
        [string]$ProcessName
    )
    
    $process = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
    if (-not $process) {
        Write-Host "Process not found."
        return $null
    }
    
    $targetProcessId = $process.Id
    $foundWindow = $null
    
    $enumProc = {
        param($hwnd, $lParam)
        
        $processId = 0
        [WinAPI]::GetWindowThreadProcessId($hwnd, [ref]$processId)
        
        if ($processId -eq $targetProcessId) {
            # Check if window is visible and has a title
            if ([WinAPI]::IsWindowVisible($hwnd)) {
                $className = New-Object System.Text.StringBuilder(256)
                [WinAPI]::GetClassName($hwnd, $className, 256)
                
                $windowTitle = New-Object System.Text.StringBuilder(256)
                [WinAPI]::GetWindowText($hwnd, $windowTitle, 256)
                
                # For UWP apps, look for specific class names or non-empty titles
                $classStr = $className.ToString()
                $titleStr = $windowTitle.ToString()
                
                Write-Host "Found window - Class: '$classStr', Title: '$titleStr'"
                
                # Common UWP window classes include "ApplicationFrameWindow" and "Windows.UI.Core.CoreWindow"
                if ($classStr -eq "ApplicationFrameWindow" -or 
                    $classStr -eq "Windows.UI.Core.CoreWindow" -or
                    ($titleStr -ne "" -and $classStr -ne "")) {
                    $script:foundWindow = $hwnd
                    return $false # Stop enumeration
                }
            }
        }
        return $true # Continue enumeration
    }
    
    [WinAPI]::EnumWindows($enumProc, [IntPtr]::Zero)
    return $script:foundWindow
}

# Find and resize the UWP window
$hwnd = Find-UWPWindow -ProcessName $processName
if ($hwnd -and $hwnd -ne [IntPtr]::Zero) {
    Write-Host "Found UWP window handle: $hwnd"
    [WinAPI]::SetWindowPos($hwnd, [IntPtr]::Zero, 100, 100, 800, 600, 0)
    Write-Host "Window resized successfully."
} else {
    Write-Host "Could not find a suitable window for the UWP app."
}