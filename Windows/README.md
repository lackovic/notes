# Windows

*Table of contents*

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Know the version and build](#know-the-version-and-build)
- [Know the domain](#know-the-domain)
- [Know whether a service is running on a port number](#know-whether-a-service-is-running-on-a-port-number)
- [Create a EXT4 partition](#create-a-ext4-partition)
- [Change the screenshots default save location](#change-the-screenshots-default-save-location)
- [Create your own custom keyboard layout](#create-your-own-custom-keyboard-layout)
- [Wipe all the deleted data / free space on a drive](#wipe-all-the-deleted-data--free-space-on-a-drive)
- [See the command history across all PowerShell sessions](#see-the-command-history-across-all-powershell-sessions)
- [Lock a BitLocker encrypted drive from the command line](#lock-a-bitlocker-encrypted-drive-from-the-command-line)
- [Automation and bloatware removal](#automation-and-bloatware-removal)
  - [Install Windows without 3rd party bloatware](#install-windows-without-3rd-party-bloatware)
  - [Disable Web Results in Windows 11 Start or Search Menu](#disable-web-results-in-windows-11-start-or-search-menu)
  - [Uninstall Xbox apps](#uninstall-xbox-apps)
  - [Scripts for automation of routine tasks and bloatware removal](#scripts-for-automation-of-routine-tasks-and-bloatware-removal)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Know the version and build

Run in PowerShell:
```powershell
# Displays the version in a window 
winver

# Displays the version in the terminal
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
```

## Know the domain

Run in PowerShell either of the two:
```powershell
systeminfo | findstr /B /C:"Domain"
wmic computersystem get domain
```

## Know whether a service is running on a port number

Run in PowerShell:
```powershell
netstat -an -b | grep <port_number>
```

## Create a EXT4 partition

Run in PowerShell:
```powershell
choco install partitionwizard ext2fsd -y
```

Use MiniTool Partition Wizard to create a EXT4 partition.
[Ext2Fsd](http://www.ext2fsd.com/) adds EXT4 support to Windows.

## Change the screenshots default save location

1. Right click on `%USERPROFILE%\Pictures\Screenshots\`

1. Properties > Location

## Create your own custom keyboard layout

- [Microsoft Keyboard Layout Creator](https://www.microsoft.com/en-us/download/details.aspx?id=22339)

## Wipe all the deleted data / free space on a drive

```powershell
# Overwrites the deallocated space on drive C:
cipher /w:C
```

Cipher goes through the following steps:

1. creates the folder `C:\EFSTMPWP`

1. creates a first file in that folder filled with `0`, making it grow until the hard drive fills up

1. deletes that file and creates a second one filled with `255`, making it grow until the hard drive fills up

1. deletes the second file, creates a third file filled with random numbers, making it grow until the hard drive fills up again

1. deletes the third file and returns you to the prompt

## See the command history across all PowerShell sessions

```powershell
cat (Get-PSReadlineOption).HistorySavePath
``` 

## Lock a BitLocker encrypted drive from the command line

```powershell
manage-bde.exe -lock e:
``` 

## Automation and bloatware removal

### Install Windows without 3rd party bloatware

1. At the initial install, select "_English (World)_" as the _Time & Currency format_ [Source](https://twitter.com/thiojoe/status/1686565269907636224)

1. After installation, open Windows Settings > _Time & Language & Region_ > _Country or region_: set the country you actually are located in.

### Disable Web Results in Windows 11 Start or Search Menu

- Run `gpedit.msc`

- User Configuration > Administrative Templates > Windows Components > File Explorer

- Enable `Turn off display of recent search entries in the File Explorer search box`

- Reboot

### Uninstall Xbox apps

To uninstall all Xbox apps (for example Xbox, XboxGameOverlay, XboxGamingOverlay, XboxIdentityProvider and XboxSpeechToTextOverlay) from the current user and from all users run the following commands in a powershell console as Administrator:

```powershell
# List all Xbox apps
dism /Online /Get-ProvisionedAppxPackages | Select-String PackageName | Select-String xbox

# Uninstall all Xbox apps
Get-ProvisionedAppxPackage -Online | Where-Object { $_.PackageName -match “xbox”} | ForEach-Object { Remove-ProvisionedAppxPackage -Online -AllUsers -PackageName $_.PackageName }
```

### Scripts for automation of routine tasks and bloatware removal

- [topics/windows-11-debloat](https://github.com/topics/windows-11-debloat)

- [builtbybel/BloatyNosy](https://github.com/builtbybel/BloatyNosy)

- [W4RH4WK/Debloat-Windows-10](https://github.com/W4RH4WK/Debloat-Windows-10)

- [LeDragoX/Win-Debloat-Tools](https://github.com/LeDragoX/Win-Debloat-Tools)

- [Tron fights for the User](https://www.reddit.com/r/TronScript/wiki/index)

- [farag2/Windows-10-Sophia-Script](https://github.com/farag2/Windows-10-Sophia-Script)

- [Disassembler0/Win10-Initial-Setup-Script](https://github.com/Disassembler0/Win10-Initial-Setup-Script) (discontinued since May 28, 2021)

- [Sycnex/Windows10Debloater](https://github.com/Sycnex/Windows10Debloater) (discontinued since Sep 21, 2023)

- [ChrisTitusTech/win10script](https://github.com/ChrisTitusTech/win10script) (discontinued since Sep 8, 2022)
