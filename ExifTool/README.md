# ExifTool

[ExifTool](https://exiftool.org/) is a library and a command-line application for reading, writing and editing meta information.

_Table of Contents_
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Shift 2 hours earlier the time of the photos in the current folder](#shift-2-hours-earlier-the-time-of-the-photos-in-the-current-folder)
- [Set a specific date for all photos in the current folder, without changing the time](#set-a-specific-date-for-all-photos-in-the-current-folder-without-changing-the-time)
- [Rename image and video files by date and time](#rename-image-and-video-files-by-date-and-time)
- [Move or copy image files into folders by year and month](#move-or-copy-image-files-into-folders-by-year-and-month)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Shift 2 hours earlier the time of the photos in the current folder

```powershell
exiftool "-DateTimeOriginal-=0:0:0 2:0:0" .
```

## Set a specific date for all photos in the current folder, without changing the time

In powershell:
```powershell
Get-ChildItem *.jpg | ForEach-Object {
    $currentDateTime = exiftool -s -s -s -DateTimeOriginal $_.Name
    $timePart = $currentDateTime.Split(' ')[1]
    exiftool -DateTimeOriginal="2006:10:16 $timePart" $_.Name
    Write-Host "Updated: $($_.Name)"
}
```

## Rename image and video files by date and time

Rename image and video files according to their EXIF capture date, using `YYYY-MM-DD HH.MM.SS.ext` format. Files shot within the same second get copy number added (`-1`, `-2`, etc.). Some MOV files require a different date, so we run exiftool 3 times.

```powershell
# Exclude MOV files and rename the image files with <CreateDate>
exiftool --ext MOV '-filename<CreateDate' -d '%Y-%m-%d %H.%M.%S%%-c.%%le' .

# Target MOV files and rename them with MediaCreateDate (for iPhone videos)
exiftool -ext MOV '-filename<ContentCreateDate' -d '%Y-%m-%d %H.%M.%S%%-c.%%le' .

# Target MOV files and rename them with DateTimeOriginal (for Fuji camera videos)
exiftool -ext MOV '-filename<DateTimeOriginal' -d '%Y-%m-%d %H.%M.%S%%-c.%%le' .
```

`--ext` EXCLUDES files with the extension.

`-ext` INCLUDES files with that extension.

See:

- [Rename image files according to their creation date](https://ninedegreesbelow.com/photography/exiftool-commands.html#rename)
- [Common Date Format Codes](https://exiftool.org/filename.html)
- [Exiftool Canonize](https://gist.github.com/jmuspratt/3680d45b0c12f8b32093)

## Move or copy image files into folders by year and month

```powershell
# Move
exiftool '-Directory<CreateDate' -d './destination/folder/%Y/%m %B' -r ./source/folder

# Copy
exiftool -o . '-Directory<CreateDate' -d './destination/folder/%Y/%m %B' -r ./source/folder
```

See [Writing "FileName" and "Directory" tags](https://exiftool.org/filename.html).
