# Load System.Windows.Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Define the list of strings
$messages = @(
    "Deployment",
    "HR data feed",
    "Pull requests",
    "Patching")

$delay = 300;

$index = 0;
# Enter an infinite loop
while ($true) {
    # Select a random string from the list
    $selectedMessage = $messages[$index];

    $index = $index + 1;
    if ($index -eq $messages.Count)
    {
      $index = 0;
    }

    # Wait for 5 minutes
    Start-Sleep -Seconds $delay

    # Show the message box
    [System.Windows.Forms.MessageBox]::Show($selectedMessage, "Check Task", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}
