# Windows Subsystem for Linux (WSL2)

WSL2 compared to WSL1 brings increased file system performance, full system call compatibility, virtualization technology (based on Hyper-V), a lightweight utility VM on a real Linux kernel allowing Docker containers to run natively without emulation. The Linux filesystem in WSL2 uses EXT4 directly over a virtual pmem device, thus achieving very close to native Linux performance. In order to benefit from WSL2 performance boost you need to run your applications in WSL2's local filesystem (e.g. `/home/user/src/`) and not in the mounted NTFS filesystem (e.g. `/mnt/c/`).

## Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Installation](#installation)
- [Basic Commands](#basic-commands)
- [Docker](#docker)
- [Run Linux GUI applications](#run-linux-gui-applications)
- [Install IntelliJ IDEA](#install-intellij-idea)
  - [On Ubuntu](#on-ubuntu)
  - [On ArchWSL](#on-archwsl)
- [Manage multiple distributions](#manage-multiple-distributions)
- [Use chromedriver on WSL](#use-chromedriver-on-wsl)
- [Useful links](#useful-links)
- [Troubleshooting](#troubleshooting)
  - [WSL2 requires an update to its kernel component](#wsl2-requires-an-update-to-its-kernel-component)
  - [Docker asking for a password](#docker-asking-for-a-password)
  - [The computer gets stuck at booting](#the-computer-gets-stuck-at-booting)
  - [WSL2 with NTFS is slow](#wsl2-with-ntfs-is-slow)
- [Known issues](#known-issues)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

Follow the [Microsoft Installation Guide for WSL2](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install).

## Basic Commands

In PowerShell:

```powershell
# Switch WSL version
wsl --set-version <distro> <version>

# List your distributions and their WSL versions
wsl --list -v
```

## Docker

- [Docker Desktop WSL 2 backend](https://docs.docker.com/docker-for-windows/wsl/)

- [Using Remote Containers in WSL 2](https://code.visualstudio.com/blogs/2020/07/01/containers-wsl)

## Run Linux GUI applications

Setup:

1. On Windows:

   1. [Install _VcXsrv_ with Chocolatey](https://chocolatey.org/packages/vcxsrv)

   1. In the folder `%PROGRAMFILES%\VcXsrv`:
      
      - right click on `vcxsrv.exe`
      - Properties > Compatibility > Change high DPI settings
      - Check _Override high DPI scaling behavior_
      - Select _Application_

   1. Control Panel\System and Security\Windows Defender Firewall\Allowed apps

      - Select _VcXsrv windows xserver_

      - Check both Private and Public checkboxes

      - Press _OK_ at the bottom of the window

   1. Download [`config.xlaunch`](./config.xlaunch) to your file system (save it in `%AppData%\Microsoft\Windows\Start Menu\Programs\Startup` if you want to make XLaunch automatically run at startup) and double click on it to run XLaunch

      The _XLaunch_ configuration should be:

         - Multiple Windows
         - Display number = 0
         - Start no client
         - Disable access control

1. On WSL:

   1. Append to your `~/.profile` (in Ubuntu):

      ```sh
      export DISPLAY=${DISPLAY:-$(grep -Po '(?<=nameserver ).*' /etc/resolv.conf):0}
      export LIBGL_ALWAYS_INDIRECT=1
      ```

      and then close and open another terminal window or run `source ~/.profile` (only needed once).

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

### On Ubuntu

1. Download the [`tar.gz` file for Linux](https://www.jetbrains.com/idea/download/#section=linux) and extract in `/opt/intellij/`

1. Run `/opt/intellij/bin/idea.sh`

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

```sh
Starting ChromeDriver 79.0.3945.36 on port 9515
Only local connections are allowed.
Please protect ports used by ChromeDriver and related test frameworks to prevent access by malicious code.
```

## Link Windows's Chrome and chromedriver to WSL through symlinks

Make Windows’s Chrome browser and the chromedriver accessible from WSL, through symlinks.

1. Create a file as google-chrome in `/usr/bin` and link it to the Chrome browser on Windows. `ln -s '/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe' /usr/bin/google-chrome`
2. Create a file as chromedriver in `/usr/bin` and link it to the chromedriver in Windows. `ln -s /mnt/c/{YourChromedriverPathInWindows} /usr/bin/chromedriver`

Note: The location of Chrome browser and chromedriver will be different on your system. Check and substitute the right paths when using above commands. You may need to run as a root user for this to work. And make sure your chrome browser version compatible with downloaded chromedriver.

## Useful links

- [Microsoft WSL 2 Docs](https://docs.microsoft.com/en-us/windows/wsl/wsl2-index)

- [Linux GUI applications in the Windows Subsystem for Linux (WSL) survey](https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbRzbKcfZyZQ9Drbxd4NOp_ZBUOFZVQ1A2UUlWRzBNMUtPOFFVVkRQWTNRQS4u)

- [wsl2-hacks](https://github.com/shayne/wsl2-hacks)

## Troubleshooting

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
