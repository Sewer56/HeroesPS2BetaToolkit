echo "Applying Settings"
[Environment]::CurrentDirectory = $PSScriptRoot

# Game Paths
$workingPath = "./working"                    # Path with all user data.
$romPath     = "./working/rom"                # Path to extracted ISO
$cvmPath     = "./working/rom/ROFS.CVM"       # Path to CRI FileSystem
$cvmExtPath  = "./working/cvm"                # Path to CRI FileSystem (Extracted)
$elfPath     = $workingPath + "/SLES_519.50"  # PS2 Executable

# User Working Paths
$oneArchivePath = "./working/archives/one"
$afsArchivePath = "./working/archives/afs"
$txdArchivePath = "./working/archives/txd"

# Intermediate Locations
$cvmAsIso    = "./working/dont-touch/cvm-as-iso" # CRI FileSystem
$cvmIsoPath  = "$cvmAsIso/tsonic.iso" # CRI FileSystem (As ISO)
$cvmHdrPath  = "$cvmAsIso/tsonic.hdr" # CRI FileSystem (Header)

# Tools
$7z    = "./tools/7z/7z.exe"
$mkiso = "./tools/iso/mkisofs.exe"
$imgburn = "./tools/imgburn/ImgBurn.exe"
$one   = "./tools/one/HeroesONER.Cli.exe"
$afs   = "./tools/afs/AfsLibPak.exe"
$cvm   = "./tools/cvm/cvm_tool.exe"

# ISO Building Settings
$isoDefaultParams = "/mode", "build", "/rootfolder", "yes", "/noimagedetails", "/overwrite", "yes", "/start", "/close"
$isoPath  = "build.iso"
$isoLabel = "Sonic Heroes 2/Oct/03 Proto"
