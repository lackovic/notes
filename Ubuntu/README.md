# Ubuntu

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
