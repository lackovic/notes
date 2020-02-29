# ExifTool

## Installation

```powershell
choco install exiftool
```

## Shift 2 hours earlier the time of the photos in the current folder

```powershell
.\exiftool "-DateTimeOriginal-=0:0:0 2:0:0" .
```