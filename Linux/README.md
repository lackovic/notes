# Linux

_Table of Contents_
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Get your operating system information](#get-your-operating-system-information)
- [Get your hardware information](#get-your-hardware-information)
- [Show the git branch name in terminal (like posh-git)](#show-the-git-branch-name-in-terminal-like-posh-git)
- [Colorize your cat output](#colorize-your-cat-output)
- [Display line numbers in your cat output](#display-line-numbers-in-your-cat-output)
- [Display line numbers in VIM](#display-line-numbers-in-vim)
- [Print a file from line to line](#print-a-file-from-line-to-line)
- [Human readable files list in terminal](#human-readable-files-list-in-terminal)
- [Copy files from Linux to Windows](#copy-files-from-linux-to-windows)
- [Find all files containing a string](#find-all-files-containing-a-string)
- [List running processes](#list-running-processes)
- [Services commands](#services-commands)
- [Validate shell scripts](#validate-shell-scripts)
- [Favorite bash aliases](#favorite-bash-aliases)

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

## Show the git branch name in terminal (like posh-git)

```sh
force_color_prompt=yes
color_prompt=yes
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi
unset color_prompt force_color_prompt
```

- [Source](https://askubuntu.com/questions/730754/how-do-i-show-the-git-branch-with-colours-in-bash-prompt)

## Colorize your cat output

```sh
sudo apt-get install python-pygments

# Add an alias to your ~/.bashrc
alias dog='pygmentize -g'
```

## Display line numbers in your cat output

```sh
cat -n <file-path>
```

## Display line numbers in VIM

- open vim
- press `:`
- enter `set number`

If you want to be displayed by default, append `set number` to your `~/.vimrc`.

## Print a file from line to line

```sh
sed -n 10,20p <file-path>
```

## Human readable files list in terminal

```sh
# Add an alias to your ~/.bashrc
alias dir='ls -lhp --color --group-directories-first'
```

`-l` = use a long listing format

`-h` = print sizes like 1K, 234M, 2G, etc.

`-p` = append `/` indicator to directories

## Copy files from Linux to Windows

- Install `openssh-server` and `net-tools` on Linux

- Intall `Putty` on Windows (with [Chocolatey](https://chocolatey.org/packages/putty))

```sh
# Assuming 192.168.10.12 is your Linux IP address,
# write the following command in a shell on Windows:
pscp user@192.168.10.12:/source/path/on/linux/* c:\Destination\Path\On\Windows
```

## Find all files containing a string

```sh
grep -Ril "string" .
``` 
`R` = recursive

`i` = ignore case

`l` = show the file name, not the result itself

`.` = starting from the current directory

## List running processes

```sh
ps aux | grep procName
pgrep -f procName
top
htop
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
``` 

## Validate shell scripts

- [ShellCheck](https://www.shellcheck.net/)

## Favorite bash aliases

```sh
alias dog='pygmentize -O console256 -g'
alias dir='ls -lhp --color --group-directories-first'
alias gts='git status'
alias grs='git reset --hard && git clean -f -d'
``` 
