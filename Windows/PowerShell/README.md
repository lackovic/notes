# PowerShell 

Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Know the version](#know-the-version)
- [PowerShell Core](#powershell-core)
  - [Install the latest version of PowerShell Core](#install-the-latest-version-of-powershell-core)
  - [Add git integration](#add-git-integration)
  - [Set the default starting directory](#set-the-default-starting-directory)
  - [Enable partial matching of a command with up and down keys](#enable-partial-matching-of-a-command-with-up-and-down-keys)
  - [Have syntax highlighting](#have-syntax-highlighting)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Know the version

```shell
$PSVersionTable
```

## PowerShell Core

### Install the latest version of PowerShell Core

1. [Install Chocolatey](https://chocolatey.org/install)

1. Run:

   ```shell
   choco install powershell-core
   ```

### Add git integration

1. Run:

   ```shell
   PowerShellGet\Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
   ```

2. Add to your profile (e.g. - `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

   ```shell
   Import-Module posh-git
   ```

### Set the default starting directory

Add to your profile (e.g. - `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

```shell
Set-Location C:\src
```

### Enable partial matching of a command with up and down keys

Add to your profile (e.g. - `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

```shell
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
```

### Have syntax highlighting

Install [PsReadLine](https://github.com/PowerShell/PSReadLine) and [PSColor](https://github.com/Davlind/PSColor):

1. Run:

   ```shell
   Install-Module -Name PSReadLine -RequiredVersion 2.0.0-beta5 -AllowPrerelease
   Install-Module PSColor
   ```

   Note: the [latest beta](https://github.com/PowerShell/PSReadLine/releases) of PSReadLine is needed due to [this bug](https://github.com/PowerShell/PSReadLine/issues/854).

2. Add to your profile (e.g. - `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

   ```shell
   Import-Module PSReadLine
   Import-Module PSColor
   ```

3. To customize the colors follow [these instructions](https://github.com/Davlind/PSColor#configuration).

### List local users, their home directory and occupied space

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