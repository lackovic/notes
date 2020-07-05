# Colorize your cat output
alias dog='pygmentize -O console256 -g'

# Human readable files list in terminal
# -l = use a long listing format
# -h = print sizes like 1K, 234M, 2G, etc.
# -p = append `/` indicator to directories
# -a = hidden files/directories
alias lsh='ls -lhpa --color --group-directories-first'

# Make grep ignore case and highlight matching string
alias grep="grep --ignore-case --color"

# Begin in your home directory
cd ~

# Show the git branch name in terminal (like posh-git)
# https://askubuntu.com/questions/730754/how-do-i-show-the-git-branch-with-colours-in-bash-prompt
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
