# Get all HTML files in the directory and its subdirectories
$htmlFiles = Get-ChildItem -Path "./" -Filter "*.html" -Recurse

# Loop through each HTML file
foreach ($file in $htmlFiles) {
    # Read the content of the file as a string
    $content = Get-Content -Path $file.FullName -Raw

    # Try parsing the content as XML
    try {
        [xml]$xmlDoc = $content

        # Locate and remove <nav> elements using XPath
        $navNodes = $xmlDoc.SelectNodes("//nav")
        foreach ($node in $navNodes) {
            $node.ParentNode.RemoveChild($node)
        }

        # Locate and remove <hr> elements using XPath
        $hrNodes = $xmlDoc.SelectNodes("//hr")
        foreach ($node in $hrNodes) {
            $node.ParentNode.RemoveChild($node)
        }

        # Convert the modified XML back to a string
        $newContent = $xmlDoc.OuterXml

        # Write the new content back to the file
        Set-Content -Path $file.FullName -Value $newContent

    } catch {
        Write-Host "Failed to parse $file as XML."
    }
}