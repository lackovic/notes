<#
.SYNOPSIS
    Removes old Windows directories from a previous Windows installation.
.DESCRIPTION
    Based on: https://superuser.com/a/1028115/54747
.PARAMETER TargetDrive
    The drive letter where the old Windows installation is located
.PARAMETER Force
    Skip confirmation prompts and proceed with deletion
.EXAMPLE
    .\DeleteOldWinDirs.ps1 -TargetDrive "D:" -Force
#>

#Requires -RunAsAdministrator

param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern("^[A-Za-z]:$")]
    [string]$TargetDrive,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

function Write-ColoredOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

function Get-FolderSize {
    param([string]$Path)
    if (-not (Test-Path $Path)) { return 0 }
    try {
        $size = (Get-ChildItem $Path -Recurse -File -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum
        return [math]::Round($size / 1GB, 2)
    }
    catch { return 0 }
}

function Remove-WindowsDirectory {
    param([string]$Path, [string]$Name)
    
    if (-not (Test-Path $Path)) {
        Write-ColoredOutput "  $Name not found - skipping" "Yellow"
        return 0
    }
    
    $size = Get-FolderSize $Path
    Write-ColoredOutput "  Removing $Name ($size GB)..." "Cyan"
    
    try {
        # Take ownership and set permissions
        & takeown.exe /F $Path /A /R /D Y 2>&1 | Out-Null
        & icacls.exe $Path /T /grant "Administrators:F" 2>&1 | Out-Null
        
        # Remove directory
        Remove-Item $Path -Recurse -Force
        Write-ColoredOutput "  ✓ Removed $Name ($size GB)" "Green"
        return $size
    }
    catch {
        Write-ColoredOutput "  ✗ Failed to remove $Name`: $_" "Red"
        return 0
    }
}

# Main execution
try {
    Write-ColoredOutput "`n=== Delete Old Windows Directories ===" "White"
    Write-ColoredOutput "Target Drive: $TargetDrive" "Cyan"
    
    # Check if running as administrator
    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        throw "This script requires Administrator privileges."
    }
    
    # Check if target drive exists
    if (-not (Test-Path $TargetDrive)) {
        throw "Target drive $TargetDrive does not exist."
    }
    
    # Define directories to remove
    $directories = @(
        @{ Path = "$TargetDrive\Program Files"; Name = "Program Files" }
        @{ Path = "$TargetDrive\Program Files (x86)"; Name = "Program Files (x86)" }
        @{ Path = "$TargetDrive\ProgramData"; Name = "ProgramData" }
        @{ Path = "$TargetDrive\Users"; Name = "Users" }
        @{ Path = "$TargetDrive\Windows"; Name = "Windows" }
    )
    
    # Calculate total size
    $totalSize = ($directories | ForEach-Object { Get-FolderSize $_.Path } | Measure-Object -Sum).Sum
    Write-ColoredOutput "Total size to delete: $totalSize GB`n" "Yellow"
    
    # Show confirmation unless -Force is used
    if (-not $Force) {
        Write-ColoredOutput "WARNING: This will permanently delete:" "Red"
        foreach ($dir in $directories) {
            if (Test-Path $dir.Path) {
                $size = Get-FolderSize $dir.Path
                Write-ColoredOutput "  - $($dir.Path) ($size GB)" "Yellow"
            }
        }
        
        $response = Read-Host "`nContinue? (yes/no)"
        if ($response -ne "yes") {
            Write-ColoredOutput "Operation cancelled." "Yellow"
            exit 0
        }
    }
    
    # Remove directories
    Write-ColoredOutput "`nRemoving directories..." "White"
    $totalRemoved = 0
    foreach ($dir in $directories) {
        $totalRemoved += Remove-WindowsDirectory $dir.Path $dir.Name
    }
    
    Write-ColoredOutput "`n=== Completed Successfully ===" "Green"
    Write-ColoredOutput "Total space freed: $totalRemoved GB" "Green"
}
catch {
    Write-ColoredOutput "`nError: $_" "Red"
    exit 1
}
