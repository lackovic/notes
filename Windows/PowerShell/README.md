# PowerShell 

Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Know the version](#know-the-version)
- [Run Windows Update from PowerShell](#run-windows-update-from-powershell)
- [Get the Windows Update log](#get-the-windows-update-log)
- [Registry keys CRUD operations](#registry-keys-crud-operations)
- [List local users, their home directory and occupied space](#list-local-users-their-home-directory-and-occupied-space)
- [Get hardware info](#get-hardware-info)
- [Add a timestamp to your prompt](#add-a-timestamp-to-your-prompt)
- [Shortcuts](#shortcuts)
  - [Quickly open PowerShell as Administrator](#quickly-open-powershell-as-administrator)
  - [Use CTRL + D to exit PowerShell console](#use-ctrl--d-to-exit-powershell-console)
- [List only file names in the current directory](#list-only-file-names-in-the-current-directory)
- [PowerShell Core](#powershell-core)
  - [Install the latest version of PowerShell Core](#install-the-latest-version-of-powershell-core)
  - [Add git integration](#add-git-integration)
  - [Set the default starting directory](#set-the-default-starting-directory)
  - [Enable partial matching of a command with up and down keys](#enable-partial-matching-of-a-command-with-up-and-down-keys)
  - [Have syntax highlighting](#have-syntax-highlighting)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Know the version

```powershell
$PSVersionTable
```

## Run Windows Update from PowerShell

To run Windows Update from PowerShell, you can use the `PSWindowsUpdate` module. If it's not installed, you can install it using the following command:

```powershell
Install-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate
```
## Get the Windows Update log

Running the following command will create a `WindowsUpdate.log` file in your Desktop folder:

```powershell
Get-WindowsUpdateLog
```

## Registry keys CRUD operations

```powershell
# To read a registry key:
Get-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\Test\One\Two\Three

# To create or update a registry key default value:
Set-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\Test\One\Two\Three -Name '(Default)' -Value 'NewValue'

# To append something to an existing registry key default value:
$MyRegKey = Get-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\Test\One\Two\Three
$NewValue = $MyRegKey.'(Default)' + 'Something'
Set-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\Test\One\Two\Three -Name '(Default)' -Value $NewValue

# To delete a registry key and all its subkeys:
Remove-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\Test\One\Two\Three -Recurse 
```

## List local users, their home directory and occupied space

Run PowerShell version <= 5.x as *Administrator*:

```powershell
Get-WmiObject win32_userprofile | % { 
    try {
        $out = new-object psobject
        $out | Add-Member noteproperty Name (New-Object System.Security.Principal.SecurityIdentifier($_.SID)).Translate([System.Security.Principal.NTAccount]).Value
        $out | Add-Member noteproperty LocalPath $_.LocalPath
        $out | Add-Member noteproperty FolderSize ("{0:N2}" -f ((Get-ChildItem -Recurse $_.LocalPath | Measure-Object -property length -sum -ErrorAction SilentlyContinue).sum / 1MB) + " MB")
        $out
    } catch {}
} | Format-Table
```

## Get hardware info

```powershell
# Computer brand and model
Get-CimInstance Win32_ComputerSystem | Format-List Manufacturer, Model

# Motherboard
Get-CimInstance Win32_Baseboard | Format-List Manufacturer, SerialNumber, Version, Product

# BIOS
Get-CimInstance Win32_BIOS | Format-List Manufacturer, Version, ReleaseDate, SMBIOSBIOSVersion, SMBIOSMajorVersion, SMBIOSMinorVersion, SystemBiosMajorVersion, SystemBiosMinorVersion

# CPU
Get-CimInstance Win32_Processor | Format-List DeviceID, LoadPercentage, MaxClockSpeed, ProcessorType, SocketDesignation, Description, Name, CurrentClockSpeed, Manufacturer, NumberOfCores, NumberOfEnabledCore, NumberOfLogicalProcessors, ProcessorId, ThreadCount

# Graphic card
Get-CimInstance Win32_VideoController | Format-List AdapterCompatibility, Caption, Description, Name, PNPDeviceID, VideoModeDescription, VideoProcessor

# Drives
wmic diskdrive get model,serialnumber,size,mediaType

# RAM
Get-CimInstance Win32_PhysicalMemory | Format-List Manufacturer, PartNumber, SerialNumber, Tag, BankLabel, Capacity, Speed, ConfiguredClockSpeed, DeviceLocator

# Operating System
Get-CimInstance Win32_OperatingSystem | Format-List Name, InstallDate, LastBootUpTime, NumberOfUsers, Version, BuildNumber, SerialNumber
```

## Add a timestamp to your prompt

Add the following function to your PowerShell profile:

```powershell
# If you don't have posh-git, use:
function prompt {            
    "$(Get-Date -Format "yyyy/MM/dd HH:mm.ss") $(get-location) > "
}

# If you have posh-git, use:
$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "yyyy/MM/dd HH:mm.ss") '
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Magenta
```

- [About Profiles](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7)
- [Get-Date documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7)
- [Customizing Your PowerShell Prompt with posh-git](https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt)

## Shortcuts

### Quickly open PowerShell as Administrator

`Ctrl`+`X` `A`

### Use CTRL + D to exit PowerShell console

Add the following line to your PowerShell profile:

```powershell
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
``` 

## List only file names in the current directory

```powershell
dir | Select-Object Name
``` 

## PowerShell Core

### Install the latest version of PowerShell Core

1. [Install Chocolatey](https://chocolatey.org/install)

1. Run:

   ```powershell
   choco install powershell-core
   ```

### Add git integration

1. Run:

   ```powershell
   PowerShellGet\Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
   ```

2. Add to your profile (e.g. - `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

   ```powershell
   Import-Module posh-git
   ```

### Set the default starting directory

Add to your profile (e.g. - `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

```powershell
Set-Location C:\src
```

### Enable partial matching of a command with up and down keys

Add to your profile (e.g. - `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

```powershell
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
```

### Have syntax highlighting

Install [PsReadLine](https://github.com/PowerShell/PSReadLine) and [PSColor](https://github.com/Davlind/PSColor):

1. Run:

   ```powershell
   Install-Module -Name PSReadLine -RequiredVersion 2.0.1
   Install-Module PSColor
   ```

   Note: PSReadLine `2.0.1` is needed because the current [preinstalled version 2.0.0](https://github.com/PowerShell/PSReadLine/releases) of suffers from [this bug](https://github.com/PowerShell/PSReadLine/issues/854).

2. Add to your profile (e.g. - `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

   ```powershell
   Import-Module PSReadLine
   Import-Module PSColor
   ```

3. To customize the colors follow [these instructions](https://github.com/Davlind/PSColor#configuration).
