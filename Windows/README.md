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