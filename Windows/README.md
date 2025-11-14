# Windows

*Table of contents*

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

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
- [Install the latest Windows release with all the latest updates included](#install-the-latest-windows-release-with-all-the-latest-updates-included)
- [Get rid of US language in Windows 11](#get-rid-of-us-language-in-windows-11)
- [Automation and bloatware removal](#automation-and-bloatware-removal)
  - [Install Windows without 3rd party bloatware](#install-windows-without-3rd-party-bloatware)
  - [Disable Web Results in Windows 11 Start or Search Menu](#disable-web-results-in-windows-11-start-or-search-menu)
  - [Use classic context menu in File Explorer in Windows 11](#use-classic-context-menu-in-file-explorer-in-windows-11)
  - [Things to do right after a Windows 11 installation](#things-to-do-right-after-a-windows-11-installation)
  - [Turn on fast startup](#turn-on-fast-startup)
  - [Disable hyper key (Win+Alt+Ctrl+Shift) opening Microsoft Office](#disable-hyper-key-winaltctrlshift-opening-microsoft-office)
  - [Customize File Explorer (permanently disable files grouping)](#customize-file-explorer-permanently-disable-files-grouping)
  - [Disable magnifier](#disable-magnifier)
  - [Disable computer wake up on key press or mouse movement](#disable-computer-wake-up-on-key-press-or-mouse-movement)
  - [Uninstall Xbox apps](#uninstall-xbox-apps)
  - [Scripts for automation of routine tasks and bloatware removal](#scripts-for-automation-of-routine-tasks-and-bloatware-removal)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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

## Install the latest Windows release with all the latest updates included

1. Download the image creation script from [UUP dump](https://uupdump.net/)

1. Set `CustomList=1` in `ConvertConfig.ini` in order to avoid including Windows bloatware (like Outlook, Teams, Xbox, etc) in the installation image.

1. Run `uup_download_windows.cmd`

The process will take a while: it takes 35 minutes on a beafy desktop computer with a 150 Mbps bandwidth. Once it's done, you'll find the ISO image (~6 GB) in the folder where you ran the script. You can use it to create a bootable USB drive with [Rufus](https://rufus.ie/).

## Get rid of US language in Windows 11

In Windows 11 settings (`Win`+`i`), select _Time & language_ > _Language & region_:

1. Open the Language options of any listed language, press _Add a keyboard_, select _US Qwerty_ to add it, then click on the triple dots next to _US Qwerty_ and select _Remove_ to remove it.

1. _Related settings_ section, _Administrative language settings_ option, _Administrative_ tab, _Language for non-Unicode programs_ > press the _Change system locale..._ button, replace _US English_ with the layout of your main language.

1. Reboot.

[Source](https://superuser.com/questions/1680608/how-to-get-rid-of-us-language-in-windows-11/1749153)

## Automation and bloatware removal

### Install Windows without 3rd party bloatware

1. At the initial install, select "_English (World)_" as the _Time & Currency format_ [Source](https://twitter.com/thiojoe/status/1686565269907636224)

1. After installation, open Windows Settings > _Time & Language & Region_ > _Country or region_: set the country you actually are located in.

### Disable Web Results in Windows 11 Start or Search Menu

Option 1:

1. Run in PowerShell:

   ```powershell
   reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 00000000 /f
   reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v AllowSearchToUseLocation /t REG_DWORD /d 00000000 /f
   reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 00000000 /f
   ```

1. Reboot

Option 2:

1. Run `gpedit.msc`

1. User Configuration > Administrative Templates > Windows Components > File Explorer

1. Enable `Turn off display of recent search entries in the File Explorer search box`

1. Reboot

### Use classic context menu in File Explorer in Windows 11

```powershell
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
```

### Things to do right after a Windows 11 installation

1. Run Windows Update and reboot until there are no more updates available
1. Run `winget source update` to update `winget` to its latest version (see https://github.com/microsoft/winget-cli/issues/3832)
1. Windows Update: select _Get the latest updates as soon as they're available_
1. Notifications & actions:
   - Notifications: off
   - Additional settings: disable all
1. Personalization > Taskbar:
   - disable search, task view, widgets and Chat
   - Taskbar behaviors > Taskbar alignment: Left
1. Edit power plan > Power Options > Choose what the power buttons do > Change settings that are currently unavailable: select _Hibernate_
1. Change system sounds > Sounds > Sound Schemes: _No Sounds_
1. Install your motherboard drivers (chipset, audio, LAN, etc.)
1. Install your GPU drivers
1. File Explorer > View:
   - Options > View: select _Expand to open folder_ and _Show all folders_
1. Settings > Personalization > Start: Disable _Show recommended files in Start, recent files in File Explorer, and items in Jump Lists_   
1. Download _Incosolata Nerd Font_ from [here](https://www.nerdfonts.com/font-downloads), right click on all TTF files, choose _Install_, set it as default font in Windows Terminal
1. Apply all the changes described in the following sections.

### Turn on fast startup

Control panel > Power options > Choose what the power buttons do > Turn on fast startup

### Disable hyper key (Win+Alt+Ctrl+Shift) opening Microsoft Office

```powershell
REG ADD HKCU\Software\Classes\ms-officeapp\Shell\Open\Command /t REG_SZ /d rundll32
```

[Source](https://superuser.com/a/1794781/54747)

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

### Disable computer wake up on key press or mouse movement

In an elevated PowerShell console run the following command:

```powershell
powercfg /DEVICEQUERY wake_programmable | Select-String -Pattern "mouse|keyboard" | ForEach-Object { $_.ToString() } | ForEach-Object { powercfg /DEVICEDISABLEWAKE $_ }
```

You might have to run the command again after a plugging in a new mouse or keyboard.

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
