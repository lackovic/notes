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

## Change the screenshots default save location

1. Right click on `%USERPROFILE%\Pictures\Screenshots\`

1. Properties > Location

## Create your own custom keyboard layout

- [Microsoft Keyboard Layout Creator](https://www.microsoft.com/en-us/download/details.aspx?id=22339)
