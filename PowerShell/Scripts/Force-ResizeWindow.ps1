$processName = "PowerPom";

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinAPI {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
}
"@

# Get the handle of the target window (e.g., Notepad)
$process = Get-Process -Name $processName -ErrorAction SilentlyContinue
if ($process) {
    $hwnd = $process.MainWindowHandle
    if ($hwnd -ne [IntPtr]::Zero) {
        # Resize and move the window (X=100, Y=100, Width=800, Height=600)
        [WinAPI]::SetWindowPos($hwnd, [IntPtr]::Zero, 100, 100, 800, 600, 0)
    } else {
        Write-Host "Window not found."
    }
} else {
    Write-Host "Process not found."
}