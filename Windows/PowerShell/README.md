# PowerShell 

Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Know the version](#know-the-version)
- [Get the Windows Update log](#get-the-windows-update-log)
- [Get computer information](#get-computer-information)
- [Registry keys CRUD operations](#registry-keys-crud-operations)
- [List local users, their home directory and occupied space](#list-local-users-their-home-directory-and-occupied-space)
- [PowerShell Core](#powershell-core)
  - [Install the latest version of PowerShell Core](#install-the-latest-version-of-powershell-core)
  - [Add git integration](#add-git-integration)
  - [Set the default starting directory](#set-the-default-starting-directory)
  - [Enable partial matching of a command with up and down keys](#enable-partial-matching-of-a-command-with-up-and-down-keys)
  - [Have syntax highlighting](#have-syntax-highlighting)
  - [Run PowerShell Core as Administrator in a Windows Terminal tab](#run-powershell-core-as-administrator-in-a-windows-terminal-tab)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Know the version

```powershell
$PSVersionTable
```

## Get the Windows Update log

Running the following command will create a `WindowsUpdate.log` file in your Desktop folder:

```powershell
Get-WindowsUpdateLog
```

## Get computer information

```powershell
Get-ComputerInfo
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
   Install-Module -Name PSReadLine -RequiredVersion 2.0.0-beta5 -AllowPrerelease
   Install-Module PSColor
   ```

   Note: the [latest beta](https://github.com/PowerShell/PSReadLine/releases) of PSReadLine is needed due to [this bug](https://github.com/PowerShell/PSReadLine/issues/854).

2. Add to your profile (e.g. - `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

   ```powershell
   Import-Module PSReadLine
   Import-Module PSColor
   ```

3. To customize the colors follow [these instructions](https://github.com/Davlind/PSColor#configuration).

### Run PowerShell Core as Administrator in a Windows Terminal tab

   ```powershell
   # Install gsudo:
   choco install gsudo -y
   # Update the current session with environment variables changes:
   refreshenv
   # Generate a GUID:
   [guid]::NewGuid()
   # Add a new profile in Windows Terminal settings:
   {
      "guid": "{new-guid-generated-above}",
      "hidden": false,
      "name": "PowerShell Core Admin",
      "commandline": "gsudo.exe pwsh"
   }
   ```

- [Source](https://github.com/microsoft/terminal/issues/632#issuecomment-582782751)
