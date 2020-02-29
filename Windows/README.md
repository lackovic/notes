# Windows

*Table of contents*

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Know the version and build](#know-the-version-and-build)
- [Know the domain](#know-the-domain)
- [Know whether a service is running on a port number](#know-whether-a-service-is-running-on-a-port-number)
- [Create a EXT4 partition](#create-a-ext4-partition)
- [Change Google Chrome cache folder](#change-google-chrome-cache-folder)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Know the version and build

Run in PowerShell:
```shell
winver
```

## Know the domain

Run in PowerShell either of the two:
```shell
systeminfo | findstr /B /C:"Domain"
wmic computersystem get domain
```

## Know whether a service is running on a port number

Run in PowerShell:
```shell
netstat -an -b | grep <port_number>
```

## Create a EXT4 partition

Run in PowerShell:
```shell
choco install partitionwizard ext2fsd -y
```

Use MiniTool Partition Wizard to create a EXT4 partition.
[Ext2Fsd](http://www.ext2fsd.com/) adds EXT4 support to Windows.

## Change Google Chrome cache folder

```powershell
$MyRegKey = Get-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\ChromeHTML\shell\open\command
$NewValue = $MyRegKey.'(Default)' + ' --disk-cache-dir="C:\Temp\Chrome"'
Set-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\ChromeHTML\shell\open\command -Name '(Default)' -Value $NewValue
```

Default value on my machine = `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -- "%1"`