# Linux

_Table of Contents_

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Get your operating system information](#get-your-operating-system-information)
- [Get your hardware information](#get-your-hardware-information)
- [Remove the green background color from the directory listing](#remove-the-green-background-color-from-the-directory-listing)
- [Display line numbers in your cat output](#display-line-numbers-in-your-cat-output)
- [Print a file from line to line](#print-a-file-from-line-to-line)
- [Copy files from Linux to Windows](#copy-files-from-linux-to-windows)
- [Find files by name and show all their properties](#find-files-by-name-and-show-all-their-properties)
- [Find all files containing a string](#find-all-files-containing-a-string)
- [List running processes](#list-running-processes)
- [Set an empty password for a user](#set-an-empty-password-for-a-user)
- [Services commands](#services-commands)
- [CLI Tools](#cli-tools)
- [Shell scripts](#shell-scripts)
  - [Validation](#validation)
  - [Debugging](#debugging)
- [Set vim as default editor](#set-vim-as-default-editor)
- [Install the latest version of Neovim on Ubuntu](#install-the-latest-version-of-neovim-on-ubuntu)
- [Arch Linux](#arch-linux)
  - [Update the system](#update-the-system)
  - [Search for a package](#search-for-a-package)
  - [Install AUR (Arch User Repository) packages](#install-aur-arch-user-repository-packages)
  - [Install Java through SDKMAN](#install-java-through-sdkman)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Get your operating system information

```sh
cat /etc/os-release
# or
lsb_release -a
```

## Get your hardware information

```sh
lshw -short
```

## Remove the green background color from the directory listing

```sh
dircolors -p > ~/.dircolors
vim ~/.dircolors
# Remove ;41 ;42 ;43 ;44 from the lines beginning with
# SETUID, SETGID, CAPABILITY, STICKY_OTHER_WRITABLE, OTHER_WRITABLE and STICKY
vim ~/.bashrc
# Append the following line
eval 'dircolors ~/.dircolors' > /dev/null
```

- [Source](https://unix.stackexchange.com/questions/94498/what-causes-this-green-background-in-ls-output)

## Display line numbers in your cat output

```sh
cat -n <file-path>
```

## Print a file from line to line

```sh
sed -n 10,20p <file-path>
```

## Copy files from Linux to Windows

- Install `openssh-server` and `net-tools` on Linux

- Intall `Putty` on Windows (with [Chocolatey](https://chocolatey.org/packages/putty))

```sh
# Assuming 192.168.10.12 is your Linux IP address,
# write the following command in a shell on Windows:
pscp user@192.168.10.12:/source/path/on/linux/* c:\Destination\Path\On\Windows
```

## Find files by name and show all their properties

```sh
find . -name <file_name_or_pattern> | xargs ls -lhpa --color --group-directories-first
```

## Find all files containing a string

```sh
grep -Rin "string" .
```

`R` = recursive

`i` = ignore case

`n` = show the line number and content

`.` = starting from the current directory

Use `l` instead of `n` to show the file name only.

## List running processes

```sh
ps aux | grep procName
pgrep -f procName
top
htop
```

## Set an empty password for a user

```sh
sudo passwd -d username
```

## Services commands

```sh
# List running services
ls /etc/init.d

# Start/stop a service
sudo -u root bash
/etc/init.d/<my-service> start/stop
# if you don't find there, check
/var/spool/cron/*
# if not there, check:
/etc/monit.d/*

# List services listening to ports
sudo netstat -tulpn | grep LISTEN
```

## CLI Tools

- [Witowski Favorite CLI Tools](https://switowski.com/blog/favorite-cli-tools)

## Shell scripts

### Validation

- [ShellCheck](https://www.shellcheck.net/)

### Debugging

Prepend the following to your script:

```sh
# Exit immediately if a command exits with a non-zero status
set -e

# Print the last failed command, line number and exit code
trap 'prev_cmd=$curr_cmd; prev_ln=$curr_ln; curr_cmd=$BASH_COMMAND; curr_ln=${LINENO}' DEBUG
trap 'echo -e $"\n   ERROR in ${BASH_SOURCE}:$prev_ln >>> $prev_cmd <<< FAILED with EXIT CODE $?\n"' EXIT
```

## Set vim as default editor

```sh
sudo update-alternatives --config editor
```

## Install the latest version of Neovim on Ubuntu

```sh
sudo snap install nvim --classic
```

## Arch Linux

### Update the system

```sh
sudo pacman -Syu
```

- `S` = Synchronize packages. Packages are installed directly from the remote repositories, including all dependencies required to run the packages
- `y` = Download a fresh copy of the master package database from the server(s) defined in pacman.conf
- `u` = Upgrades all packages that are out-of-date

### Search for a package

To search for example for _OpenJDK_, run:

```sh
sudo pacman -Ss OpenJDK
```

- `S` = Synchronize packages. Packages are installed directly from the remote repositories, including all dependencies required to run the packages
- `s` = Search each package in the sync databases for names or descriptions that match regexp

### Install AUR (Arch User Repository) packages

For WSL2 see [this issue](https://github.com/yuk7/ArchWSL/issues/142).

1. Install the prerequisites:

   ```sh
   pacman -S --needed base-devel
   ```

1. Install Yay as AUR helper:

   ```sh
   git clone https://aur.archlinux.org/yay.git
   cd yay/
   makepkg -si
   ```

1. Install the package of your choice with:

   ```sh
   yay -S <package-name>
   ```

Resources:

- [AUR packages search](https://aur.archlinux.org/packages/)

- [AUR wiki](https://wiki.archlinux.org/index.php/Arch_User_Repository)

- [AUR helpers](https://wiki.archlinux.org/index.php/AUR_helpers)

### Install Java through SDKMAN

1. Install the prerequisites:

   ```sh
   sudo pacman -Sy which unzip zip
   ```

1. Follow the [installation instructions](https://sdkman.io/install).

1. To see the list of available Java versions: it

   ```sh
   sdk list java
   ```

1. To install a particular version of Java run:

   ```sh
   sdk install java <identifier>
   ```
