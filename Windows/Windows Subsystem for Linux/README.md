# Windows Subsystem for Linux (WSL)

The Windows Subsystem for Linux (WSL 1) allows to use different Linux distros directly from your Windows 10 machine.

## Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Enable WSL](#enable-wsl)
- [See your distros and their WSL versions](#see-your-distros-and-their-wsl-versions)
- [Manage multiple distributions](#manage-multiple-distributions)
- [Use chromedriver on WSL](#use-chromedriver-on-wsl)
- [Windows Subsystem for Linux 2 (WSL 2)](#windows-subsystem-for-linux-2-wsl-2)
  - [Install WSL 2](#install-wsl-2)
    - [Prerequisites](#prerequisites)
      - [Windows Insider Program troubleshooting](#windows-insider-program-troubleshooting)
    - [Installation Instructions](#installation-instructions)
  - [Switch WSL version](#switch-wsl-version)
  - [Known issues](#known-issues)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Enable WSL

Run in PowerShell:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux"
```

## See your distros and their WSL versions

Run in PowerShell:

```powershell
# Windows version < 2004
wsl --list -all

# Windows version >= 2004
wsl --list -v
```

## Manage multiple distributions

Install [LxRunOffline](https://github.com/DDoSolitary/LxRunOffline) with:

```powershell
choco install lxrunoffline
```

This allows, among other things, to install, uninstall, move, duplicate a distribution.

Type `lxrunoffline` to see the list of supported actions.

## Use chromedriver on WSL

WSL doesn't support GUI applications, and Chrome is especially difficult to get working, even with the headless option. The solution proposed here is to install chromedriver in Windows and run it from WSL.

1. Download the latest [chromedriver_win32.zip](https://sites.google.com/a/chromium.org/chromedriver/)
1. Extract it in a folder (e.g. - `%USERPROFILE%/bin` in Command Prompt, or `~/bin` in PowerShell)
1. Add the folder path to your System Environment `PATH` variable
1. Rename `chromedriver.exe` to `chromedriver`

Now relaunch your terminal to pick up the new environment variables. You can `echo $PATH` to ensure the new path is there. Once you enter WSL if you run `chromedriver` you should see something like this:

```shell
Starting ChromeDriver 79.0.3945.36 on port 9515
Only local connections are allowed.
Please protect ports used by ChromeDriver and related test frameworks to prevent access by malicious code.
```

## Windows Subsystem for Linux 2 (WSL 2)

Windows Subsystem for Linux 2 (WSL 2) was announced at the Microsoft Build 2019 conference and is shipped with the Windows 10 Insider Preview Build 18917. WSL 2 architecture is drastically changed and brings increased file system performance and full system call compatibility, uses virtualization technology (based on Hyper-V) and uses a lightweight utility VM on a real Linux kernel.

- [Release blog](https://devblogs.microsoft.com/commandline/wsl-2-is-now-available-in-windows-insiders/)

- [Microsoft WSL 2 Docs](https://docs.microsoft.com/en-us/windows/wsl/wsl2-index)

### Install WSL 2

#### Prerequisites

1. [Telemetry data must be enabled](https://github.com/Disassembler0/Win10-Initial-Setup-Script/blob/317c49038941ccea1c74c6838bc1d383a1078341/Win10.psm1#L59-L79)

1. You must join the [Windows Insider Program](https://insider.windows.com/en-us/) and select the 'Slow' or 'Fast' ring

#####  Windows Insider Program troubleshooting

- if you are having an issue with Docker asking for a password, follow [these instructions](https://github.com/docker/for-win/issues/616#issuecomment-528390516) to fix it.

- if your computer get stuck at booting, disable the secure boot in the BIOS

#### Installation Instructions

- [Microsoft Docs / Install WSL 2](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install)

### Switch WSL version

```powershell
wsl --set-version <distro> <version>
```

### Known issues

As of Windows 10 version 2004 build 19041.1:

- tunneling `127.0.0.1` [works only in the `Windows->WSL` direction](https://devblogs.microsoft.com/commandline/whats-new-for-wsl-in-insiders-preview-build-18945/), but not in the `WSL->Windows` one. Subscribe to [this issue](https://github.com/microsoft/WSL/issues/4619) to know when access to windows services via localhost:port will be implemented in WSL 2.

- **WSL 2 with NTFS is unusably slow**, but with EXT4 is very close to native Linux performance ([source](https://vxlabs.com/2019/12/06/wsl2-io-measurements/)): in order to benefit of WSL 2 performance boost you need to copy and run your application in WSL2's local filesystem (EXT4 on a Hyper-V VHD) - e.g. `/home/`

