# Set Working Directory
Split-Path $MyInvocation.MyCommand.Path | Push-Location

# Import Settings.ps1
. "./Settings.ps1"

# Check if the ISO file path is provided as an argument
if ($args.Length -eq 0) {
    Write-Error "No ISO file path provided."
    exit
}

# ISO file path from the first argument
$isoPath = $args[0]

# Check if the provided ISO file exists
if (-not (Test-Path $isoPath)) {
    Write-Error "The provided ISO file does not exist: $isoPath"
    exit
}

# Ensure the working path exists
if (-not (Test-Path $workingPath)) {
    Write-Host "Creating working directory: $workingPath"
    New-Item -Path $workingPath -ItemType Directory
}

# Extract ISO using 7-Zip
& $7z x -y "$isoPath" "-o$romPath"

# Split ROFS.CVM into ISO and Header
New-Item -Path "$cvmAsIso" -ItemType Directory
& $cvm split "$cvmPath" "$cvmIsoPath" "$cvmHdrPath"

# Extract ISO from ROFS.CVM
& $7z x -y "$cvmIsoPath" "-o$cvmExtPath"

# Extract all archives.
& "./scripts/extract_all_one.ps1"
& "./scripts/extract_all_afs.ps1"

# Restore Working Directory
Pop-Location
