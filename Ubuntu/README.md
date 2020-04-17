# Ubuntu

_Table of Contents_
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Get your operating system information](#get-your-operating-system-information)
- [Show the git branch name in terminal (like posh-git)](#show-the-git-branch-name-in-terminal-like-posh-git)
- [Colorize Your Cat Output](#colorize-your-cat-output)
- [Human readable files list in terminal](#human-readable-files-list-in-terminal)
- [Copy files from Ubuntu to Windows](#copy-files-from-ubuntu-to-windows)
- [Find all files containing a string](#find-all-files-containing-a-string)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Get your operating system information

```sh
cat /etc/os-release
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

## Colorize Your Cat Output

```sh
sudo apt-get install python-pygments

# Add an alias to your ~/.bashrc
alias dog='pygmentize -g'
```

## Human readable files list in terminal

```sh
# Add an alias to your ~/.bashrc
alias dir='ls -lhp --color --group-directories-first'
```

`-l` = use a long listing format

`-h` = print sizes like 1K, 234M, 2G, etc.

`-p` = append `/` indicator to directories

## Copy files from Ubuntu to Windows

- Install `openssh-server` and `net-tools` on Ubuntu (with `apt`).

- Intall `Putty` on Windows (with [Chocolatey](https://chocolatey.org/packages/putty)).

```sh
# Assuming 192.168.10.12 is your Ubuntu IP address,
# write the following command in a shell on Windows:
pscp user@192.168.10.12:/source/path/on/ubuntu/* c:\Destination\Path\On\Windows
```

## Find all files containing a string

```sh
grep -Ril "string" .
``` 
`R` = recursive

`i` = ignore case

`l` = show the file name, not the result itself

`.` = starting from the current directory
