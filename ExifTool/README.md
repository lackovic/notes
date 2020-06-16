# ExifTool

[ExifTool](https://exiftool.org/) is a library and a command-line application for reading, writing and editing meta information.

## Shift 2 hours earlier the time of the photos in the current folder

```powershell
exiftool "-DateTimeOriginal-=0:0:0 2:0:0" .
```

## Move or copy image files into folders by year and month

```powershell
# Move
exiftool '-Directory<CreateDate' -d './destination/folder/%Y/%m %B' -r ./source/folder

# Copy
exiftool -o . '-Directory<CreateDate' -d './destination/folder/%Y/%m %B' -r ./source/folder
```

 - See `exiftool` docs [Writing "FileName" and "Directory" tags](https://exiftool.org/filename.html)