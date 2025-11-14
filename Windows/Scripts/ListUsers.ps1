<#
.SYNOPSIS
    List local users, their home directory and occupied space
.NOTES
    SIDs:
      - Local/domain user accounts: S-1-5-21-...
      - Built-in service accounts:  S-1-5-18 (SYSTEM), S-1-5-19 (LOCAL SERVICE), S-1-5-20 (NETWORK SERVICE)
#>

#Requires -Version 7.0
#Requires -RunAsAdministrator

Write-Host "Collecting users profile information, please wait..." -ForegroundColor Yellow
Get-CimInstance Win32_UserProfile |
Where-Object {
  # Filter for real user accounts (exclude system/service accounts)
  $_.SID -match '^S-1-5-21-' -and
  -not $_.Special -and 
  $_.LocalPath -and
  (Test-Path $_.LocalPath)
} | ForEach-Object {
  try {
    $out = [PSCustomObject]@{
      Name       = (New-Object System.Security.Principal.SecurityIdentifier($_.SID)).Translate([System.Security.Principal.NTAccount]).Value
      LocalPath  = $_.LocalPath
      FolderSize = "{0:N2} MB" -f ((Get-ChildItem -Recurse -Force -ErrorAction SilentlyContinue $_.LocalPath | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum / 1MB)
    }
    $out
  }
  catch {}
} | Format-Table
  