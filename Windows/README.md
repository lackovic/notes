# Windows

*Table of contents*

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Installation](#installation)
  - [Install the latest Windows release with all the latest updates included](#install-the-latest-windows-release-with-all-the-latest-updates-included)
  - [Install Windows without 3rd party bloatware](#install-windows-without-3rd-party-bloatware)
  - [Things to do right after a Windows 11 installation](#things-to-do-right-after-a-windows-11-installation)
- [Windows Update](#windows-update)
  - [Run Windows Update from terminal](#run-windows-update-from-terminal)
  - [Get the Windows Update log](#get-the-windows-update-log)
- [Miscellaneous how-tos](#miscellaneous-how-tos)
- [Favorite shortcuts](#favorite-shortcuts)
- [Know the version and build](#know-the-version-and-build)
- [Know the domain](#know-the-domain)
- [Know whether a service is running on a port number](#know-whether-a-service-is-running-on-a-port-number)
- [Change the screenshots default save location](#change-the-screenshots-default-save-location)
- [Create your own custom keyboard layout](#create-your-own-custom-keyboard-layout)
- [Wipe all the deleted data / free space on a drive](#wipe-all-the-deleted-data--free-space-on-a-drive)
- [See the command history across all PowerShell sessions](#see-the-command-history-across-all-powershell-sessions)
- [BitLocker](#bitlocker)
  - [Lock a BitLocker encrypted drive from the command line](#lock-a-bitlocker-encrypted-drive-from-the-command-line)
  - [Find out if your drive is running BitLocker software based encryption](#find-out-if-your-drive-is-running-bitlocker-software-based-encryption)
  - [Disable BitLocker encryption for a drive](#disable-bitlocker-encryption-for-a-drive)
- [Find a file or directory being used by another process](#find-a-file-or-directory-being-used-by-another-process)
- [Autostarting programs locations](#autostarting-programs-locations)
- [Get rid of US language in Windows 11](#get-rid-of-us-language-in-windows-11)
- [Automation and bloatware removal](#automation-and-bloatware-removal)
  - [Customize File Explorer (permanently disable files grouping)](#customize-file-explorer-permanently-disable-files-grouping)
  - [Disable magnifier](#disable-magnifier)
  - [Scripts for automation of routine tasks and bloatware removal](#scripts-for-automation-of-routine-tasks-and-bloatware-removal)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## Installation

1. Visit [Download Windows 11](https://www.microsoft.com/en-gb/software-download/windows11).
1. **Create Windows 11 Installation Media** > Download now.
1. Run the downloaded `MediaCreationToolW11.exe`.
1. Follow the instructions to create a bootable USB drive.

### Install the latest Windows release with all the latest updates included

1. Download the image creation script from [UUP dump](https://uupdump.net/)

1. Set `CustomList=1` in `ConvertConfig.ini` in order to avoid including Windows bloatware (like Outlook, Teams, Xbox, etc) in the installation image.

1. Run `uup_download_windows.cmd`

The process will take a while: it takes 35 minutes on a beafy desktop computer with a 150 Mbps bandwidth. Once it's done, you'll find the ISO image (~6 GB) in the folder where you ran the script. You can use it to create a bootable USB drive with [Rufus](https://rufus.ie/).

### Install Windows without 3rd party bloatware

1. At the initial install, select "_English (World)_" as the _Time & Currency format_.

1. After installation, open Windows Settings > _Time & Language & Region_ > _Country or region_: set the country you actually are located in.

[Source](https://twitter.com/thiojoe/status/1686565269907636224).

### Things to do right after a Windows 11 installation

1. Run Windows Update and reboot until there are no more updates available
1. Run . [SetupConfig.ps1](./Scripts/SetupConfig.ps1) to apply various configuration tweaks
1. Run . [SetupApps.ps1](./Scripts/SetupApps.ps1) to install commonly used applications via Winget
1. Install your motherboard drivers (chipset, audio, LAN, etc.)
1. Install your GPU drivers
1. Download _Incosolata Nerd Font_ from [here](https://www.nerdfonts.com/font-downloads), right click on all TTF files, choose _Install_, set it as default font in Windows Terminal

## Windows Update

### Run Windows Update from terminal

```powershell
Install-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate
```

### Get the Windows Update log

Running the following command will create a `WindowsUpdate.log` file in your Desktop folder:

```powershell
Get-WindowsUpdateLog
```

## Miscellaneous how-tos

See [SetupConfig.ps1](./Scripts/SetupConfig.ps1).

## Favorite shortcuts

| Key                       | Command                                             |
| ------------------------- | --------------------------------------------------- |
| `Win+E`                   | Open File Explorer                                  |
| `Win+X`                   | Open the Quick Link menu.                           |
| `Win+R`                   | Open the Run dialog box.                            |
| `Win+Tab`                 | Open Task view.                                     |
| `Win+V`                   | Open the clipboard history.                         |
| `Win+B`                   | Set focus to the first icon in the Taskbar corner.  |
| `Win+number`              | Start/switch to the n-th app pinned to the taskbar. |
| `Win+Ctrl+V`              | Open the sound output device selector               |

[All shortcuts](https://support.microsoft.com/en-us/windows/keyboard-shortcuts-in-windows-dcc61a57-8ff0-cffe-9796-cb9706c75eec)

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

## Change the screenshots default save location

1. Right click on `%USERPROFILE%\Pictures\Screenshots\`

1. Properties > Location

## Create your own custom keyboard layout

- [Microsoft Keyboard Layout Creator](https://www.microsoft.com/en-us/download/details.aspx?id=102134)

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

## BitLocker

### Lock a BitLocker encrypted drive from the command line

```powershell
manage-bde.exe -lock e:
```

### Find out if your drive is running BitLocker software based encryption

```powershell
manage-bde -status
```

### Disable BitLocker encryption for a drive

```powershell
manage-bde -off e:
```

This will take a while, depending on the size of the drive and the amount of data stored on it. You can monitor the decryption progress with:

```powershell
manage-bde -status
```

and then look at the _Conversion Status_ field and the _Percentage Encrypted_ field.

## Find a file or directory being used by another process

1. Open "Resource Monitor" (`resmon.exe`)
1. Go to the "CPU" tab
1. In the "Associated Handles" section, type part of the file or directory name in the search box

## Autostarting programs locations

- Task Manager > Startup apps

- Registry Editor:

   - `Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run`

   - `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`

- Task Scheduler > Task Scheduler Library

## Get rid of US language in Windows 11

In Windows 11 settings (`Win`+`i`), select _Time & language_ > _Language & region_:

1. Open the Language options of any listed language, press _Add a keyboard_, select _US Qwerty_ to add it, then click on the triple dots next to _US Qwerty_ and select _Remove_ to remove it.

1. _Related settings_ section, _Administrative language settings_ option, _Administrative_ tab, _Language for non-Unicode programs_ > press the _Change system locale..._ button, replace _US English_ with the layout of your main language.

1. Reboot.

[Source](https://superuser.com/questions/1680608/how-to-get-rid-of-us-language-in-windows-11/1749153)

## Automation and bloatware removal

### Customize File Explorer (permanently disable files grouping)

Use [WinSetView](https://lesferch.github.io/WinSetView/) to apply the following changes:

Options:

- Show file extensions
- Classic context menu in Windows 11
- No Internet in Windows search
- Make All Folders Generic (Advanced interface)

Global (details) columns:

- Name
- Size
- Date created
- Date modified
- Type
- Group by: (None)

### Disable magnifier

(The following steps are currently not working and are left here for reference until a working solution is found).

In an elevated PowerShell console run the following command:

```powershell
takeown /f C:\Windows\System32\Magnify.exe
```
- type Y and press Enter
- Right-click on `C:\Windows\System32\Magnify.exe` and rename it to `Magnify.exe.bak`

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
