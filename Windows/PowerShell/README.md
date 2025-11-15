# PowerShell 

Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Installation](#installation)
- [Know PowerShell version](#know-powershell-version)
- [Registry keys CRUD operations](#registry-keys-crud-operations)
- [Get hardware info](#get-hardware-info)
- [Add a timestamp to your prompt](#add-a-timestamp-to-your-prompt)
- [Shortcuts](#shortcuts)
  - [Quickly open PowerShell as Administrator](#quickly-open-powershell-as-administrator)
  - [Use CTRL + D to exit PowerShell console](#use-ctrl--d-to-exit-powershell-console)
- [List only files and folders names in the current directory](#list-only-files-and-folders-names-in-the-current-directory)
- [Add git integration](#add-git-integration)
- [Set the default starting directory](#set-the-default-starting-directory)
- [Enable partial matching of a command with up and down keys](#enable-partial-matching-of-a-command-with-up-and-down-keys)
- [Have syntax highlighting](#have-syntax-highlighting)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

PowerShell 7 is a modern, cross-platform version of PowerShell that can run on Windows, Linux, and macOS, unlike version 5 which is limited to Windows. It offers improved performance, new features and better error handling. PowerShell 7 is actively developed and maintained, while version 5 only receives security updates. PowerShell 7 installs to a new directory and runs side-by-side with Windows PowerShell 5.

To install it run:

```powershell
winget install -h --id Microsoft.PowerShell
```

For a better experience, install also the [PowerShell Toys](https://github.com/lackovic/PSToys).

## Know PowerShell version

```powershell
$PSVersionTable
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

# Drives / storage
Get-WmiObject Win32_DiskDrive | Select Model, SerialNumber, Size, MediaType

# RAM
Get-CimInstance Win32_PhysicalMemory | Format-List Manufacturer, PartNumber, SerialNumber, Tag, BankLabel, Capacity, Speed, ConfiguredClockSpeed, DeviceLocator

# Operating System
Get-CimInstance Win32_OperatingSystem | Format-List Name, InstallDate, LastBootUpTime, NumberOfUsers, Version, BuildNumber, SerialNumber
```

## Add a timestamp to your prompt

See prompt renderers posh-git in [./Microsoft.PowerShell_profile.ps1](./Microsoft.PowerShell_profile.ps1)

## Shortcuts

### Quickly open PowerShell as Administrator

`Ctrl`+`X` `A`

### Use CTRL + D to exit PowerShell console

See [./Microsoft.PowerShell_profile.ps1](./Microsoft.PowerShell_profile.ps1)

## List only files and folders names in the current directory

```powershell
dir | Select-Object Name
```

## Add git integration

See prompt renderers in [./Microsoft.PowerShell_profile.ps1](./Microsoft.PowerShell_profile.ps1)

## Set the default starting directory

See [./Microsoft.PowerShell_profile.ps1](./Microsoft.PowerShell_profile.ps1)

## Enable partial matching of a command with up and down keys

Add to your profile (e.g. - `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

```powershell
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
```

## Have syntax highlighting

See color highlighting in [./Microsoft.PowerShell_profile.ps1](./Microsoft.PowerShell_profile.ps1)
