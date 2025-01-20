
function isBadLine([string] $line)
{
  $trimmedLine = $line.Trim();
  # importer now allows single-line break import
#   if ($trimmedLine -eq "")
#   {
#     return $true;
#   }

  if ($trimmedLine -eq "---")
  {
    return $true;
  }

  return $false
}

function Cleanup-MarkdownImport {
    param (
        [string]$path
    )

    # Get all Markdown files in the directory and its subdirectories
    $markdownFiles = Get-ChildItem -Path $path -Filter "*.md" -Recurse

    # Loop through each Markdown file
    foreach ($file in $markdownFiles) {
        # Read the content of the file
        $content = Get-Content -Path $file.FullName

        # Remove all empty lines
        # TODO this won't work because it fucks up tables, tables need lines around them
        $newContent = $content | Where-Object { -not (isBadLine $_) }

        # Write the new content back to the file
        $newContent | Set-Content -Path $file.FullName
    }
}