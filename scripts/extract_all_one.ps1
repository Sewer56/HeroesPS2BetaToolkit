# Import Settings.ps1
. "./Settings.ps1"

# Define the temporary file path
$tempFilePath = [System.IO.Path]::GetTempFileName()

# Recursively extract all .one archives
$oneFiles = Get-ChildItem -Path $cvmExtPath -Recurse -Filter *.one
foreach ($oneFile in $oneFiles) {
    # Calculate the relative path of the .one file from $cvmExtPath
    $relativePath = $oneFile.FullName.Substring([System.IO.Path]::GetFullPath($cvmExtPath).Length)

    # Construct the full target directory path for extraction
    $targetDirectory = Join-Path $oneArchivePath $relativePath

    # Write the source and target pair to the temporary file
    "$($oneFile.FullName)|$targetDirectory" | Out-File -FilePath $tempFilePath -Append -Encoding UTF8
}

# Invoke the batch extract command
& $one batch-extract --file $tempFilePath

# Delete the temporary file
Remove-Item -Path $tempFilePath

