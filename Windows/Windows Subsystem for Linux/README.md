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
- [Backup - export/import distributions](#backup---exportimport-distributions)
- [Manage multiple distributions](#manage-multiple-distributions)
- [Use ChromeDriver/Chrome in WSL](#use-chromedriverchrome-in-wsl)
  - [Option 1: run Chrome as GUI applicationi in WSL2](#option-1-run-chrome-as-gui-applicationi-in-wsl2)
  - [Option 2: use chromedriver from Windows](#option-2-use-chromedriver-from-windows)
  - [Option 3: use an alias in WSL to reference to Chrome in Windows](#option-3-use-an-alias-in-wsl-to-reference-to-chrome-in-windows)
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

## Use ChromeDriver/Chrome in WSL

### Option 1: run Chrome as GUI applicationi in WSL2

Install Chrome in WSL2 and [run it as Linux GUI application](#run-linux-gui-applications), as explained above. See the [Chrome README](../../Chrome/README.md) for how to install Chrome in Ubuntu WSL2.

### Option 2: use chromedriver from Windows

Another solution is to install ChromeDriver in Windows and run it from WSL:

1. Download the latest [chromedriver_win32.zip](https://sites.google.com/a/chromium.org/chromedriver/) (make sure your Chrome browser version is compatible with the downloaded chromedriver)
1. Extract it in a folder (e.g. - `%USERPROFILE%/bin` in Command Prompt, or `~/bin` in PowerShell)
1. Add the folder path to your System Environment `PATH` variable
1. Rename `chromedriver.exe` to `chromedriver`
1. Relaunch your terminal to pick up the new environment variables
1. Run `echo $PATH` to ensure the new path is there
1. Run `chromedriver` in WSL, you should see something like this:

```sh
Starting ChromeDriver 79.0.3945.36 on port 9515
Only local connections are allowed.
Please protect ports used by ChromeDriver and related test frameworks to prevent access by malicious code.
```

If you still can't access chromedriver and Chrome in WSL, you can try to make them accessible from WSL through symlinks:

```sh
ln -s '/mnt/c/<YourChromePathInWindows>/chrome.exe' /usr/bin/google-chrome
ln -s '/mnt/c/<YourChromedriverPathInWindows>' /usr/bin/chromedriver
```

Replace the placeholders with the correct paths in your system.

### Option 3: use an alias in WSL to reference to Chrome in Windows

Add the following alias to your `~/.profile` (or `~/.bash_aliases` or `~/.bash_rc`):

```sh
alias chrome="powershell.exe -Command start chrome"
```

## Useful links

- [Microsoft WSL 2 Docs](https://docs.microsoft.com/en-us/windows/wsl/wsl2-index)

- [Linux GUI applications in the Windows Subsystem for Linux (WSL) survey](https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbRzbKcfZyZQ9Drbxd4NOp_ZBUOFZVQ1A2UUlWRzBNMUtPOFFVVkRQWTNRQS4u)

- [wsl2-hacks](https://github.com/shayne/wsl2-hacks)

## Troubleshooting

### Time not synced

Manual solution: run `sudo hwclock -s` or `sudo ntpdate time.windows.com` (more accurate) after you reboot or resume from sleep/hibernate;

Automatic solution: apply this workaround which uses _Windows Events_ to trigger the clock sync via `hwclock` on resume from sleep.

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
