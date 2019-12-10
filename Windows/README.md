# Windows

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