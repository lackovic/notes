# ImageMagick

ImageMagick is a free, open-source command-line tool and library for creating, editing, converting, and composing bitmap images. It supports over 200 image formats and can be used for tasks like resizing, cropping, format conversion, and batch processing.

## Installation

On Windows:

```powershell
winget install --id ImageMagick.ImageMagick
``` 

## How to turn HEIC files into JPG and preserve EXIF data

```powershell
magick mogrify -format jpg *.heic 
``` 
