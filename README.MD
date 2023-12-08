# Heroes PS2 Beta Toolkit

Personal Tools, Scripts and Release Notes for the PS2 Sonic Heroes Prototype to be released by 
Hidden Palace soon(TM).

Notes:
- Only tested with Linux, however should work on Windows.
- This is a one-off for research, not bleeding edge fastest tools you'd expect from me today.
- On Linux you might want to mark all binaries under `tools` as executable first.
- If ImgBurn fails to run under `Wine`, set your Windows version in `winecfg` to WinXP.

## Workflow

You get a `working` folder containing all of the files.

- `working/rom`: Extracted ISO.
- `working/cvm`: Extracted CVM files. (game files)
- `working/build.iso`: Built ISO.  
- `working/archives/one`: Extracted .ONE Archives
- `working/archives/afs`: Extracted .AFS Archives

These are intermediate files, don't touch them:

- `working/dont-touch/cvm-as-iso`: Split CVM and ISO files.

## Scripts

- `Setup.ps1`: Unpacks game ISO, CVM and all archives.
- `PackArchive.ps1`: Repacks a `.one/.afs` archive, replacing the original in the `working` directory.
- `PackAllArchives.ps1`: Packs all `.one/.afs` archives modified since last run, replacing the originals in the `working` directory.
- `MakeIso.ps1`: Packs CVM and Creates ISO.

## Credits

- `roxfan`: cvm_tool
- `LIGHTNING UK!`: ImgBurn
- `Joerg Schilling`: ISO tools
- `Igor Pavlov`: 7zip