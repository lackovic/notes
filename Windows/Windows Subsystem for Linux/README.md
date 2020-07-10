# Windows Subsystem for Linux (WSL)

The Windows Subsystem for Linux (WSL 1) allows to use different Linux distros directly from your Windows 10 machine.

## Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Enable WSL](#enable-wsl)
- [Install your Linux distribution of choice](#install-your-linux-distribution-of-choice)
- [Run WSL with a non-admin account](#run-wsl-with-a-non-admin-account)
- [Set a default user other than root](#set-a-default-user-other-than-root)
- [See your distros and their WSL versions](#see-your-distros-and-their-wsl-versions)
- [Manage multiple distributions](#manage-multiple-distributions)
- [Use chromedriver on WSL](#use-chromedriver-on-wsl)
- [WSL 2](#wsl-2)
  - [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Installation Instructions](#installation-instructions)
    - [Troubleshooting](#troubleshooting)
  - [Switch WSL version](#switch-wsl-version)
  - [Install Docker on WSL 2](#install-docker-on-wsl-2)
  - [Run a Linux GUI application in WSL 2](#run-a-linux-gui-application-in-wsl-2)
  - [Install IntelliJ IDEA Ultimate on ArchWSL in WSL 2](#install-intellij-idea-ultimate-on-archwsl-in-wsl-2)
  - [Known issues](#known-issues)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Enable WSL

Run in PowerShell:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux"
```

## Install your Linux distribution of choice

For Arch you can use [yuk7/ArchWSL](https://github.com/yuk7/ArchWSL) (don't forget to follow the [setup steps](https://github.com/yuk7/ArchWSL/wiki/How-to-Setup#setting-for-arch), especially the commands for keyring initialization, which are necessary to use `pacman`).

For other distrubutions you can pick [from this list](https://chocolatey.org/packages?q=%22wsl-%22) and install it with Chocolatey.

For example:

```powershell
choco install wsl-ubuntu-1804
```

## Run WSL with a non-admin account

Will get rid of the _Access Denied_ error:

- Right click on the folder `C:\ProgramData\chocolatey\lib\wsl-ubuntu-1804\tools\unzipped` (replace `wsl-ubuntu-1804` with the distribution you have installed)

- Properties > Security > Edit

- Users: allow full control

- Press OK (it will take a few tens of seconds) and OK again

## Set a default user other than root

- enter your WSL distro

- `sudo adduser username` 

- `usermod -aG sudo username` 

- exit your WSL distro

- navigate to `C:\ProgramData\chocolatey\lib\wsl-ubuntu-1804\tools\unzipped` (replace `wsl-ubuntu-1804` with the distribution you have installed)

- `.\ubuntu1804.exe config --default-user username` (replace `ubuntu1804` with the equivalent of the distribution you have installed)

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

## WSL 2

Windows Subsystem for Linux 2 (WSL 2) was announced at the Microsoft Build 2019 conference and is shipped with the Windows 10 Insider Preview Build 18917. WSL 2 architecture is drastically changed and brings increased file system performance and full system call compatibility, uses virtualization technology (based on Hyper-V) and uses a lightweight utility VM on a real Linux kernel.

- [Release blog](https://devblogs.microsoft.com/commandline/wsl-2-is-now-available-in-windows-insiders/)

- [Microsoft WSL 2 Docs](https://docs.microsoft.com/en-us/windows/wsl/wsl2-index)

- [Linux GUI applications in the Windows Subsystem for Linux (WSL) survey](https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbRzbKcfZyZQ9Drbxd4NOp_ZBUOFZVQ1A2UUlWRzBNMUtPOFFVVkRQWTNRQS4u)

### Installation

#### Prerequisites

- You must have Windows 10 version `2004` or above installed (you can force the update from [here](https://www.microsoft.com/en-us/software-download/windows10))

#### Installation Instructions

- [Microsoft Docs / Install WSL 2](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install)

#### Troubleshooting

- if you are gettin the error "WSL 2 requires an update to its kernel component" then:

   - download the [Linux kernel update package](https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel)

   - right click on the `wsl_update_x64.msi` file and select _Uninstall_

   - right click on the `wsl_update_x64.msi` file and select _Install_

- if you are having an issue with Docker asking for a password, follow [these instructions](https://github.com/docker/for-win/issues/616#issuecomment-528390516) to fix it.

- if your computer get stuck at booting, disable the secure boot in the BIOS

### Switch WSL version

```powershell
wsl --set-version <distro> <version>
```

### Install Docker on WSL 2

- [Docker Desktop WSL 2 backend](https://docs.docker.com/docker-for-windows/wsl/)

- [Using Remote Containers in WSL 2](https://code.visualstudio.com/blogs/2020/07/01/containers-wsl)

### Run a Linux GUI application in WSL 2

1. On Windows:

   1. [Install _VcXsrv_ with Chocolatey](https://chocolatey.org/packages/vcxsrv)

   1. Control Panel\System and Security\Windows Defender Firewall\Allowed apps

      - Select _VcXsrv windows xserver_

      - Check both Private and Public checkboxes

      - Press _OK_ at the bottom of the window

   1. Open _XLaunch_ with the following settings:

      - Multiple Windows
      - Display number = 0
      - Start no client
      - Disable access control

1. On WSL:

   1. Append to your `~/.bashrc`:

      ```sh
      export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
      export LIBGL_ALWAYS_INDIRECT=1
      ```

      and then run `source ~/.bashrc`

   1. Run the command to start your GUI application

Some applications may require a desktop environment (like _Xfce_, _Gnome_ or _KDE_) or a window manager (like _Blackbox_ or _Fluxbox_) to run properly.

If you are getting the error `xrdb: Can't open display` try other solutions on [this issue](https://github.com/QMonkey/wsl-tutorial/issues/11#issuecomment-650833026).

Sources: 

- [wsl2-tutorial](https://github.com/QMonkey/wsl-tutorial/blob/master/README.wsl2.md)
- [What's the easiest way to run GUI apps on Windows Subsystem for Linux as of 2018?](https://askubuntu.com/questions/993225/whats-the-easiest-way-to-run-gui-apps-on-windows-subsystem-for-linux-as-of-2018)
- [Developing "in" Windows Subsystem for Linux](https://intellij-support.jetbrains.com/hc/en-us/community/posts/360004275400-Developing-in-Windows-Subsystem-for-Linux)

### Install IntelliJ IDEA Ultimate on ArchWSL in WSL 2

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

### Known issues

As of Windows 10 version 2004 build 19041.1:

- tunneling `127.0.0.1` [works only in the `Windows->WSL` direction](https://devblogs.microsoft.com/commandline/whats-new-for-wsl-in-insiders-preview-build-18945/), but not in the `WSL->Windows` one. Subscribe to [this issue](https://github.com/microsoft/WSL/issues/4619) to know when access to windows services via localhost:port will be implemented in WSL 2.

- **WSL 2 with NTFS is unusably slow**, but with EXT4 is very close to native Linux performance ([source](https://vxlabs.com/2019/12/06/wsl2-io-measurements/)): in order to benefit of WSL 2 performance boost you need to copy and run your application in WSL2's local filesystem (EXT4 on a Hyper-V VHD) - e.g. `/home/`

