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
- [Find the differences between two files](#find-the-differences-between-two-files)
- [Find all files containing a string](#find-all-files-containing-a-string)
- [List running processes](#list-running-processes)
- [Set an empty password for a user](#set-an-empty-password-for-a-user)
- [Services commands](#services-commands)
- [CLI Tools](#cli-tools)
- [Shell scripts](#shell-scripts)
  - [Validation](#validation)
  - [Debugging](#debugging)
- [Presentations from command line](#presentations-from-command-line)
- [Set your terminal default editor](#set-your-terminal-default-editor)
- [cd to the previous directory](#cd-to-the-previous-directory)
- [Neovim](#neovim)
  - [Install the latest version on Ubuntu](#install-the-latest-version-on-ubuntu)
  - [Setup](#setup)
    - [LazyVim](#lazyvim)
    - [Using NvChad](#using-nvchad)
      - [NvChad useful commands](#nvchad-useful-commands)
    - [Using kickstart](#using-kickstart)
  - [Vim usesul commands](#vim-usesul-commands)
  - [Learning resources](#learning-resources)
  - [Troubleshooting](#troubleshooting)
  - [Must have plugins](#must-have-plugins)
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

## Find the differences between two files

```sh
comm -3 old.csv new.csv
# or
diff --suppress-common-lines --side-by-side old.csv new.csv
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

## Presentations from command line

- [mdp](https://github.com/visit1985/mdp)
- [tpp](https://synflood.at/tpp.html)
- [sent](https://tools.suckless.org/sent/)

## Set your terminal default editor

```sh
sudo update-alternatives --config editor
```

## cd to the previous directory

```sh
cd -
```

## Neovim

Neovim is a cross-platform fork of Vim with code highlighting, syntax checking, code completion, inlay hints, type hints, a built-in debugger, a terminal emulator, a file manager, a markdown previewer, a git client and much more. It has better defaults than Vim, for example `autoindent` and `hlsearch` (highlight all matches). It has been the most loved editor in the Stack Overflow Developer Survey for the last 2 years ([source](https://survey.stackoverflow.co/2022#integrated-development-environment)).

### Install the latest version on Ubuntu

Use [bob](https://github.com/MordechaiHadad/bob/releases). Example:

```sh
wget https://github.com/MordechaiHadad/bob/releases/download/<latest_version>/bob-linux-x86_64.zip
unzip bob-linux-x86_64.zip
cd bob-linux-x86_64/
chmod +x bob
echo "export PATH=\"~/.local/share/bob/nvim-bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc
./bob install stable
./bob use stable
```

### Setup

#### LazyVim

LazyVim is a popular Neovim configuration framework designed to provide users with a pre-configured, feature-rich setup for Neovim. It offers a curated set of plugins (for syntax highlighting, code completion, file navigation, git integration, etc.), sensible defaults, and optimized settings to enhance productivity and ease of use. At its core, LazyVim leverages the `lazy.nvim` plugin manager, which allows for efficient and lazy-loading of plugins, resulting in faster startup times and improved performance.

1. Install a [Nerd font](https://www.nerdfonts.com/font-downloads) of your choice (e.g. Inconsolata):
   ```sh
   wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Inconsolata.zip
   unzip Inconsolata.zip -d ~/.local/share/fonts
   fc-cache -fv
   ```
   If you are using WSL, you need to install the font on Windows and set it in the terminal settings.

1. Install LazyVim prerequisites: `sudo apt install luarocks ripgrep xclip`

1. Install LazyVim following [these instructions](https://www.lazyvim.org/installation)

1. Start Neovim and wait for the plugins to be installed

1. Append the following lines to `~/.config/nvim/init.lua`:

   ```lua
   -- place yanked text into the global clipboard
   vim.opt.clipboard = "unnamedplus"
   ```

1. Inside Neovim run `:checkhealth` and fix any issues.

#### Using NvChad

Set one of the [Nerd Fonts](https://www.nerdfonts.com/font-downloads) as your terminal font, then run:

```sh
rm -rf ~/.local/share/nvim/
rm -rf ~/.config/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
```

##### NvChad useful commands

- Change theme with `space t h`
- Install a syntax highlighter with `:TSInstall <language>`
- Display the file tree with `Ctrl`+`n`
- Mark a file with `m`
- Create, rename, copy and paste a file with `a`, `r`, `c` and `p` (creating a folder is done by following the name with the slash `/`)
- Open the find file meny with `space f f`
- Search in the opened files names with `space f b`
- Search in the current file with `space s`
- Toggle the line numbers with `space n`
- Toggle the relative line numbers with `space r n`
- Cycle through the tabs (aka buffers) with `tab` and `shift tab`
- Close the current tab with `space x`

#### Using kickstart

```sh
sudo apt install gcc
mkdir -p ~/.config/nvim
git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/nvim
echo "vim.wo.relativenumber = true" >> ~/.config/nvim/init.lua  
nvim
```

### Vim usesul commands

- Jump back to previous location `Ctrl`+`o`
- Jump forward to next location `Ctrl`+`i`
- Undo/Redo `u`/`Ctrl`+`r`
- Copy current line `yy`
- Paste line from clipboard `p`
- Delete current line `dd`
- Jump the next/previous word `w`/`b`
- Select text (Visual) `v`
- Format current selected text `gq` (comes from plugin?)
- Change current word `cw`
- Copy the entire file to the clipboard `ggyG`
- Search for a word `/<word>`
- Search for the next/previous word `n`/`N`

### Learning resources

- Type `vimtutor` in your terminal and follow the instructions.
- [Vim Adventures](https://vim-adventures.com/)
- [Vim Cheat Sheet](https://devhints.io/vim)
- [The Primeagen: Vim As Your Editor](https://www.youtube.com/watch?v=X6AR2RMB5tE&list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R&pp=iAQB)
- [The Primeagen: Vim Life](https://www.youtube.com/watch?v=y6VJBeZEDZU&list=PLm323Lc7iSW9CtibHhhQErDh167XfL4EU&pp=iAQB)

### Troubleshooting

When running `:checkhealth` I get a lot of errors like:
```
invalid node type at position 242 for language arduino
```
See [this gist](https://gist.github.com/lackovic/1916b5cc0ca22496ea3061f4ae3b5aff).

If you run `:echo nvim_get_runtime_file('parser', v:true)` and you get two parsers then you need to remove one of the two

### Must have plugins

- [tpope/vim-surround](https://github.com/tpope/vim-surround)
- [phaazon/hop.nvim](https://github.com/phaazon/hop.nvim)

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
