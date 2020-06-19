# Script to move and rename WhatsApp media files like follows:
# IMG-20150527-WA0002.jpg -> .\2015\05\2015-05-27 WA0002.jpg
# VID-20130509-WA0006.mp4 -> .\2013\05\2013-05-09 WA0006.mp4

function Test-IsWhatsAppImage($file) {
    return $file.BaseName.StartsWith("IMG-") -and $file.Extension.equals(".jpg")
}

function Test-IsWhatsAppVideo($file) {
    return $file.BaseName.StartsWith("VID-") -and $file.Extension.equals(".mp4")
}

function Test-IsWhatsAppMediaFile($file) {
    return $file.BaseName.length.equals(19) -and $file.BaseName.substring(12, 3).equals("-WA") -and ((Test-IsWhatsAppImage($file)) -or (Test-IsWhatsAppVideo($file)))
}

Get-ChildItem | ForEach-Object {
    if (Test-IsWhatsAppMediaFile($_)) {
        $BaseName = $_.BaseName
        $Extension = $_.Extension
        $Year = $BaseName.substring(4, 4)
        $Month = $BaseName.substring(8, 2)
        $Day = $BaseName.substring(10, 2)
        $WhatsAppId = $BaseName.substring(13, 6)
        $NewName = "$Year-$Month-$Day $WhatsAppId$Extension"
        $Directory = ".\$Year\$Month"
        if (!(Test-Path $Directory)) {
            New-Item -Path $Directory -ItemType Directory -Force | Out-Null
        }
        Move-Item $_ -Force -Destination ".\$Directory\$NewName"
    }
}
