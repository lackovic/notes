# PowerShell script to reduce the hour of a date by one hour
# of filenames in the format "YYYY-MM-DD HH.MM.SS". Examples:
# - "2024-01-01 23.59.59.txt" -> "2024-01-01 22.59.59.txt"
# - "2024-01-01 00.00.00.jpg" -> "2023-12-31 23.00.00.jpg"
# - "2024-03-01 00.30.15.mp4" -> "2024-02-29 23.30.15.mp4"

# Get all files in the current directory with the date format pattern
# Pattern matches the date/time portion but allows any extension
$pattern = "^\d{4}-\d{2}-\d{2} \d{2}\.\d{2}\.\d{2}"
$files = Get-ChildItem | Where-Object { $_.BaseName -match $pattern }

foreach ($file in $files) {
    try {
        # Extract the date components from the filename
        $dateParts = $file.BaseName -split " "
        if ($dateParts.Length -ne 2) {
            Write-Warning "Skipping '$($file.Name)': Invalid format"
            continue
        }
        
        $date = $dateParts[0]
        $time = $dateParts[1]
        
        # Validate date format
        if ($date -notmatch '^\d{4}-\d{2}-\d{2}$') {
            Write-Warning "Skipping '$($file.Name)': Invalid date format"
            continue
        }
        
        # Validate time format
        if ($time -notmatch '^\d{2}\.\d{2}\.\d{2}$') {
            Write-Warning "Skipping '$($file.Name)': Invalid time format"
            continue
        }
        
        # Convert the date string to DateTime object
        $dateTime = [DateTime]::ParseExact("$date $($time.Replace('.', ':'))", "yyyy-MM-dd HH:mm:ss", $null)
        
        # Subtract one hour
        $newDateTime = $dateTime.AddHours(-1)
        
        # Format the new date and time
        $newDate = $newDateTime.ToString("yyyy-MM-dd")
        $newTime = $newDateTime.ToString("HH.mm.ss")
        
        # Construct new filename with original extension
        $newName = "$newDate $newTime$($file.Extension)"
        
        # Check if target file already exists
        if (Test-Path $newName) {
            Write-Warning "Cannot rename '$($file.Name)': Target file '$newName' already exists"
            continue
        }
        
        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newName -ErrorAction Stop
        
        # Output the change
        Write-Host "Renamed: $($file.Name) -> $newName"
    }
    catch {
        Write-Error "Error processing '$($file.Name)': $_"
    }
}

# Output summary of any files in the directory that weren't processed
$unprocessedFiles = Get-ChildItem | Where-Object { $_.BaseName -notmatch $pattern }
if ($unprocessedFiles) {
    Write-Host "`nFiles not matching the required format:"
    $unprocessedFiles | ForEach-Object { Write-Host " - $($_.Name)" }
}
