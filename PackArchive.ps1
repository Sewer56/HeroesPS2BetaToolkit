param (
    [string]$archiveName
)

# Function to print usage instructions
function PrintUsage {
    Write-Host "Usage: PackArchive.ps1 -archiveName <ArchiveName>"
    Write-Host "       ArchiveName - The name of the archive to repack."
    exit
}

# Import Settings.ps1
. "./Settings.ps1"

# Check if the archive name is provided
if ([string]::IsNullOrWhiteSpace($archiveName)) {
    PrintUsage
}

# Define function to repack .one archive
function RepackOneArchive($folderPath, $archivePath) {
    Write-Host "Repacking .one archive: $folderPath"
    & $one repack --source "$folderPath" --target "$archivePath"
}

# Define function to repack .afs archive
function RepackAfsArchive($folderPath, $archivePath) {
    Write-Host "Repacking .afs archive: $folderPath"
    & $afs $folderPath

    $afsFile = Get-ChildItem -Path "${folderPath}.afs" -Filter *.afs
    if ($afsFile) {
        Move-Item -Path $afsFile.FullName -Destination $archivePath -Force
    }
}

# Function to find and repack archive
function FindAndRepackArchive($archiveType, $searchPath) {
    $searchPath = [System.IO.Path]::GetFullPath($searchPath)
    
    $matchingFolders = Get-ChildItem -Path $searchPath -Recurse -Directory -Filter $archiveName | Select-Object -First 1
    if ($matchingFolders) {
        $relativePath = $matchingFolders.FullName.Substring($searchPath.Length).TrimStart('\')
        $targetPath = Join-Path $cvmExtPath "$relativePath"

        if ($archiveType -eq 'one') {
            RepackOneArchive $matchingFolders.FullName $targetPath
        } elseif ($archiveType -eq 'afs') {
            RepackAfsArchive $matchingFolders.FullName $targetPath
        }

        return $true
    }

    return $false
}

# Search for matching folder in .one and .afs archive paths
$foundOne = FindAndRepackArchive 'one' $oneArchivePath
$foundAfs = $false
if (-not $foundOne) {
    $foundAfs = FindAndRepackArchive 'afs' $afsArchivePath
}

# Check if neither archive was found
if (-not $foundOne -and -not $foundAfs) {
    Write-Host "No matching .one or .afs archive found for '$archiveName'."
}
