# Set Working Directory
Split-Path $MyInvocation.MyCommand.Path | Push-Location

# Import Settings.ps1
. "./Settings.ps1"

# Reassemble CVM contents into ISO
& $mkiso -udf -iso-level 2 -V "$isoLabel" -o "$cvmIsoPath" "$cvmExtPath"

# Reassemble ROFS.CVM from ISO and Header
& $cvm mkcvm "$cvmPath" "$cvmIsoPath" "$cvmHdrPath"

# Create the final ISO from the ROM path
# I could not get this to boot using any other ISO building tool... no idea why
& $imgburn ($isoDefaultParams + "/volumelabel", "$isoLabel", "/src", "$romPath", "/dest", "$isoPath")

# Restore Working Directory
Pop-Location