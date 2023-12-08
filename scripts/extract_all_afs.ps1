# Import Settings.ps1
. "./Settings.ps1"

# Recursively extract all .afs archives
$afsFiles = Get-ChildItem -Path $cvmExtPath -Recurse -Filter *.afs
foreach ($afsFile in $afsFiles) {
    # Calculate the relative path of the .afs file from $cvmExtPath
    $relativePath = $afsFile.FullName.Substring([System.IO.Path]::GetFullPath($cvmExtPath).Length)

    # Construct the full target directory path for extraction
    $targetDirectory = Join-Path $afsArchivePath $relativePath

    # Extract the .afs file
    echo "Extracting $relativePath"
    & $afs $afsFile.FullName

    # The extracted directory will have the same name as the .afs file without extension
    $extractedDirName = [System.IO.Path]::GetFileNameWithoutExtension($afsFile.FullName)
    $extractedDirPath = Join-Path ([System.IO.Path]::GetDirectoryName($afsFile.FullName)) $extractedDirName

    # Ensure the path to target directory exists
    if (-not (Test-Path $targetDirectory)) {
        New-Item -Path $targetDirectory -ItemType Directory -Force
    }

    # And now remove the target directory so we can move there.
    if (Test-Path $targetDirectory) {
        Remove-Item -Path $targetDirectory -Recurse -Force
    }

    # Move the extracted directory to the target directory if it exists
    if (Test-Path $extractedDirPath) {
        Move-Item -Path "$extractedDirPath" -Destination "$targetDirectory"
    } else {
        Write-Warning "Extracted directory not found: $extractedDirPath"
    }
}
