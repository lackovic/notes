# Windows Subsystem for Linux (WSL2)

WSL2 compared to WSL1 brings increased file system performance, full system call compatibility, virtualization technology (based on Hyper-V), a lightweight utility VM on a real Linux kernel allowing Docker containers to run natively without emulation. The Linux filesystem in WSL2 uses EXT4 directly over a virtual pmem device, thus achieving very close to native Linux performance. In order to benefit from WSL2 performance boost you need to run your applications in WSL2's local filesystem (e.g. `/home/user/src/`) and not in the mounted NTFS filesystem (e.g. `/mnt/c/`).

## Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Installation](#installation)
  - [How to Import a Docker Image as a WSL Distribution](#how-to-import-a-docker-image-as-a-wsl-distribution)
- [Configuration](#configuration)
- [Basic Commands](#basic-commands)
- [Docker](#docker)
- [Run Linux GUI applications](#run-linux-gui-applications)
  - [Setup XLaunch (legacy)](#setup-xlaunch-legacy)
- [Install IntelliJ IDEA](#install-intellij-idea)
  - [Windows 11](#windows-11)
  - [Windows 10](#windows-10)
  - [On ArchWSL](#on-archwsl)
- [Backup - export/import distributions](#backup---exportimport-distributions)
- [Manage multiple distributions](#manage-multiple-distributions)
- [Use your Windows browser from WSL](#use-your-windows-browser-from-wsl)
- [Useful links](#useful-links)
- [Troubleshooting](#troubleshooting)
  - [Time not synced](#time-not-synced)
  - [WSL2 requires an update to its kernel component](#wsl2-requires-an-update-to-its-kernel-component)
  - [Docker asking for a password](#docker-asking-for-a-password)
  - [The computer gets stuck at booting](#the-computer-gets-stuck-at-booting)
  - [WSL2 with NTFS is slow](#wsl2-with-ntfs-is-slow)
- [Known issues](#known-issues)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

1. In **Turn Windows features on or off** dialog, ensure the followings are enabled:

   - Hyper-V

   - Windows Hypervisor Platform

   - Windows Subsystem for Linux

   - Virtual Machine Platform

1. Install [Ubuntu 22.04.1 LTS](https://apps.microsoft.com/store/detail/ubuntu-22041-lts/9PN20MSR04DW)

### How to Import a Docker Image as a WSL Distribution

This guide shows how to replicate a Docker image as a WSL distribution. [amazoncorretto:21.0.8-al2023](https://hub.docker.com/layers/library/amazoncorretto/21.0.8-al2023/images/sha256-f3187c24c8a9e06d6cb49e378b397af4ff68e095588573e71aded97db0337249) is used as an example.

Step 1: Pull the Docker Image
```powershell
docker pull amazoncorretto:21.0.8-al2023
```

Step 2: Verify Image Download
```powershell
docker images | findstr amazoncorretto
```
You should see the image with size around 730MB.

Step 3: Create Container from Image
```powershell
docker create --name temp-corretto amazoncorretto:21.0.8-al2023
```

Step 4: Export Container to Tar File
```powershell
docker export temp-corretto -o corretto-al2023.tar
```
This will take several minutes and create a ~940MB tar file.

Step 5: Verify Tar File Creation
```powershell
dir .\corretto-al2023.tar
```
Check that the file size is around 900MB+.

Step 6: Create WSL Directory
```powershell
mkdir "$env:USERPROFILE\WSL\CorrettoAL2023"
```

Step 7: Import to WSL
```powershell
wsl --import CorrettoAL2023 "$env:USERPROFILE\WSL\CorrettoAL2023" ".\corretto-al2023.tar"
```

Step 8: Verify WSL Distribution
```powershell
wsl -l -v
```
You should see `CorrettoAL2023` in the list.

Step 9: Clean Up
```powershell
docker rm temp-corretto
del .\corretto-al2023.tar
```

Step 10: Launch Your New Environment
```powershell
wsl -d CorrettoAL2023
```

Key Notes:
- **PowerShell Syntax:** Use `$env:USERPROFILE` in PowerShell, not `%USERPROFILE%`
- **Export Method:** Always use `docker export -o filename.tar`, never `docker export > filename.tar`
- **File Verification:** A proper tar file should show binary byte patterns, not UTF-16 encoding markers
- **Naming:** You can replace `CorrettoAL2023` with any name you prefer for your WSL distribution

Your new WSL distribution will have the exact same environment, packages, and Java version as the original Docker image.

## Configuration

1. if Linux has been installed with only the `root` user then in WSL run:

   ```sh
   sudo adduser <username> 
   ```

1. set an empty password for your WSL user with the following command:

   ```sh
   sudo passwd -d <username>
   ```
   (secure access to your WSL shell is already protected by your Windows password)

1. install all the updates:

   ```sh
   sudo apt update; sudo apt upgrade -y; sudo apt autoremove -y; sudo snap refresh
   ```

1. set your favorite editor as default editor:

   ```sh
   sudo update-alternatives --config editor
   ```

1. grant root privileges to your user:

   ```sh
   sudo visudo
   ```

   Append after `#User privilege specification`, right below `root`:

   ```sh
   <username> ALL=(ALL:ALL)ALL
   ```

1. if Linux was installed with only the `root` user then in PowerShell run:

   ```powershell
   ubuntu2204.exe config --default-user <username>
   ```
   (secure access to your WSL shell is already protected by your Windows password)

1. In Windows > _Virus and threat protection_ > _Manage settings_ > _Add or remove exclusions_: add an exclusion to the folder `\\wsl.localhost\Ubuntu`

## Basic Commands

In PowerShell:

```powershell
# Switch WSL version
wsl --set-version <distro> <version>

# List your distributions and their WSL versions
wsl --list -v

# Update WSL to its latest version (https://github.com/microsoft/WSL/releases)
wsl --update
```

## Docker

- [Docker Desktop WSL 2 backend](https://docs.docker.com/docker-for-windows/wsl/)

- [Using Remote Containers in WSL 2](https://code.visualstudio.com/blogs/2020/07/01/containers-wsl)

## Run Linux GUI applications

The newest versions of WSL2 have built-in support for GUI applications through the [WSLg](https://github.com/microsoft/wslg): it can run Linux GUI applications directly on Windows, without the need for a third-party X server. It comes enabled by default in Windows 11 and works out of the box. Linux GUI applications get automatically integrated into the Windows Start menu.

### Setup XLaunch (legacy)

The following steps are kept for legacy purposes and for those who prefer to use XLaunch instead of WSLg.

Setup:

1. On Windows:

   1. [Install _VcXsrv_ with winget](https://winget.run/pkg/marha/VcXsrv)

   2. In the folder `%PROGRAMFILES%\VcXsrv`:
      
      - right click on `vcxsrv.exe`
      - Properties > Compatibility > Change high DPI settings
      - Check _Override high DPI scaling behavior_
      - Select _Application_

   3. Control Panel\System and Security\Windows Defender Firewall\Allowed apps

      - Select _VcXsrv windows xserver_

      - Check both Private and Public checkboxes

      - Press _OK_ at the bottom of the window

   4. Download [`config.xlaunch`](./config.xlaunch) to your file system (save it in `%AppData%\Microsoft\Windows\Start Menu\Programs\Startup` if you want to make XLaunch automatically run at startup) and double click on it to run XLaunch

      The _XLaunch_ configuration should be:

         - Multiple Windows
         - Display number = 0
         - Start no client
         - Disable access control

When you want to run a GUI application in WSL2 you need to:

1. On Windows: run _XLaunch_ with the shortcut created above

1. On WSL: run the command to start your GUI application.

Some applications may require a desktop environment (like _Xfce_, _Gnome_ or _KDE_) or a window manager (like _Blackbox_ or _Fluxbox_) to run properly.

If you are getting the error `xrdb: Can't open display` try other solutions on [this issue](https://github.com/QMonkey/wsl-tutorial/issues/11#issuecomment-650833026).

Sources: 

- [wsl2-tutorial](https://github.com/QMonkey/wsl-tutorial/blob/master/README.wsl2.md)
- [What's the easiest way to run GUI apps on Windows Subsystem for Linux as of 2018?](https://askubuntu.com/questions/993225/whats-the-easiest-way-to-run-gui-apps-on-windows-subsystem-for-linux-as-of-2018)
- [Developing "in" Windows Subsystem for Linux](https://intellij-support.jetbrains.com/hc/en-us/community/posts/360004275400-Developing-in-Windows-Subsystem-for-Linux)

## Install IntelliJ IDEA

### Windows 11

1. install the latest Java LTS version with [SDKMAN](https://sdkman.io/

   ```sh
   sdk install java
   ``` 

1. Install IntelliJ IDEA with `sudo snap install intellij-idea-ultimate --classic`

1. Run IntelliJ IDEA from the Windows Start menu or with `intellij-idea-ultimate`

### Windows 10

In WSL:

1. Download the [`tar.gz` file for Linux](https://www.jetbrains.com/idea/download/#section=linux) and extract it in your home directory `~`

1. Run `~/intellij/bin/idea.sh`

### On ArchWSL

Install [yay](../../Linux/README.md#install-aur-arch-user-repository-packages) and then run:

```sh
yay -S snapd genie-systemd
genie -s
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
# log out and back in again to ensure snap's paths are updated correctly
genie -s
sudo snap install intellij-idea-ultimate --classic
```

Run with:

```sh
genie -s
intellij-idea-ultimate
```

## Backup - export/import distributions

Very good for keeping a backup copy and recover it in case you mess up your distribution, but also for occasions like formatting the computer or moving to a new one! Once stripped off private credentials it can even passed over to a new colleague who has just joined your project to speed up the onboarding.

```sh
# List your distributions
wsl --list -v

# Save your distribution to a local file (this operation can take several minutes)
wsl --export Ubuntu-20.04 ./Ubuntu-20.04.tar

# Import a distribution from a local file
mkdir ~/AppData/Local/Ubuntu-20.04
wsl --import Ubuntu-20.04 ~/AppData/Local/Ubuntu-20.04 ./Ubuntu-20.04.tar --version 2
```

- [Source](https://www.hanselman.com/blog/easily-move-wsl-distributions-between-windows-10-machines-with-import-and-export)

## Manage multiple distributions

Install [LxRunOffline](https://github.com/DDoSolitary/LxRunOffline) with:

```powershell
choco install lxrunoffline
```

This allows, among other things, to install, uninstall, move, duplicate a distribution.

Type `lxrunoffline` to see the list of supported actions.

## Use your Windows browser from WSL

Run:

```sh
sudo apt install wslu
```

This solves the issue `/usr/bin/xdg-open: 882: www-browser: not found`. See https://github.com/microsoft/WSL/issues/8892

## Useful links

- [Microsoft WSL 2 Docs](https://docs.microsoft.com/en-us/windows/wsl/wsl2-index)

- [Linux GUI applications in the Windows Subsystem for Linux (WSL) survey](https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbRzbKcfZyZQ9Drbxd4NOp_ZBUOFZVQ1A2UUlWRzBNMUtPOFFVVkRQWTNRQS4u)

- [wsl2-hacks](https://github.com/shayne/wsl2-hacks)

- [cpu benchmark of WSL2 vs Pop OS/Ubuntu 19.10](https://www.linkedin.com/pulse/cpu-benchmark-wsl2-vs-pop-osubuntu-1910-souradeep-chakrabarti/)

- [WSL vs WSL 2 – performance](https://howto.lintel.in/wsl-vs-wsl-2-performance/)

## Troubleshooting

### Time not synced

Maybe fixed by enabling systemd. See:

- https://github.com/microsoft/WSL/issues/8204#issuecomment-1429164579

- https://github.com/microsoft/WSL/issues/5324#issuecomment-1451150152

- https://github.com/microsoft/WSL/issues/8204#issuecomment-1338334154

Manual solution: run `sudo hwclock -s` (syncs with world time) or `sudo ntpdate time.windows.com` (syncs with world time) after you reboot or resume from sleep/hibernate;

Automatic solution: append the following lines to your `~/.profile`.

```sh
# WSL specific (date issue)
uname_out=$(uname -a)
if echo $uname_out | grep -a "Microsoft"; then
    sudo hwclock -s
fi
``` 

See the following issues on GitHub:

- Jun 2019: [Time not synced in WSL2 - causing TLS issues](https://github.com/microsoft/WSL/issues/4149) - closed

- Jun 2019: [system date is not same with windows (WSL 2)](https://github.com/microsoft/WSL/issues/4245) - closed

- Jun 2020: [WSL2 date incorrect after waking from sleep](https://github.com/microsoft/WSL/issues/5324) - open

### WSL2 requires an update to its kernel component

- download the [Linux kernel update package](https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel)

- right click on the `wsl_update_x64.msi` file and select _Uninstall_

- right click on the `wsl_update_x64.msi` file and select _Install_

### Docker asking for a password

Follow [these instructions](https://github.com/docker/for-win/issues/616#issuecomment-528390516) to fix it.

### The computer gets stuck at booting

Disable the secure boot in the BIOS

### WSL2 with NTFS is slow

In order to benefit from WSL2 performance boost ([very close to native Linux performance](https://vxlabs.com/2019/12/06/wsl2-io-measurements/)), you need to copy and run your application in WSL2's local filesystem (EXT4 on a Hyper-V VHD) - e.g. `/home/`.

## Known issues

As of Windows 10 version 2004 build 19041.1:

- tunneling `127.0.0.1` [works only in the `Windows->WSL` direction](https://devblogs.microsoft.com/commandline/whats-new-for-wsl-in-insiders-preview-build-18945/), but not in the `WSL->Windows` one: subscribe to [this issue](https://github.com/microsoft/WSL/issues/4619) to know when access to windows services via `localhost:port` will be implemented in WSL2.
