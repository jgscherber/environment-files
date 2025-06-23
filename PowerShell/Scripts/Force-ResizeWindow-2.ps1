$processName = "PowerPom";
$windowTitle = "YourAppWindowTitle"; # Replace with actual window title

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinAPI {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
    
    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
}
"@

# Try to find window by title
$hwnd = [WinAPI]::FindWindow($null, $windowTitle)

if ($hwnd -ne [IntPtr]::Zero) {
    Write-Host "Found window by title: $hwnd"
    [WinAPI]::SetWindowPos($hwnd, [IntPtr]::Zero, 100, 100, 800, 600, 0)
    Write-Host "Window resized successfully."
} else {
    Write-Host "Window not found by title."
}