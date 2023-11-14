function isBadLine([string]$line)
{
    $trimLine = $line.Trim();
    if ($trimLine -eq "")
    {
        return $true;
    }

    if ($trimLine -eq "---")
    {
        return $true;
    }

    return $false;
}

$outputFileName = "combined.txt"
$sourceDirectory = ".\" # Source directory containing text files
$outputFile = ".\$outputFileName" # Path to the output file

if (Test-Path $outputFileName)
{
    Remove-Item $outputFileName;
}

# Get all text files in the source directory
$textFiles = Get-ChildItem -Path $sourceDirectory | Where-Object { $_.Name -ne $outputFileName }

# Loop through each file and append its content to the output file
foreach ($file in $textFiles) {
    Get-Content $file.FullName | Where-Object { -not (isBadLine $_) } | Add-Content $outputFile
}
