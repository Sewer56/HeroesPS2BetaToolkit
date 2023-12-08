# Import Settings.ps1
. "./Settings.ps1"

# File to store the timestamp of the last run
$lastRunFile = Join-Path $workingPath "lastRunTimestamp.txt"
$lastRunTime = if (Test-Path $lastRunFile) { Get-Content $lastRunFile } else { [DateTime]::MinValue }

# Function to repack archives in a given path
function RepackModifiedArchives($archivePath, $archiveType) {
    $archives = Get-ChildItem -Path $archivePath -Recurse -Directory | Where-Object { $_.LastWriteTime -gt $lastRunTime }

    foreach ($archive in $archives) {
        $archiveName = $archive.Name
        Write-Host "Repacking modified $archiveType archive: $archiveName"
        & "./PackArchive.ps1" -archiveName $archiveName
    }
}

# Repack modified .one archives
RepackModifiedArchives $oneArchivePath 'one'

# Repack modified .afs archives
RepackModifiedArchives $afsArchivePath 'afs'

# Update the last run timestamp
Get-Date -Format "o" | Set-Content $lastRunFile
