# Colorize your cat output
alias dog='pygmentize -O console256 -g'

# Human readable files list in terminal
# -l = use a long listing format
# -h = print sizes like 1K, 234M, 2G, etc.
# -p = append `/` indicator to directories
# -a = hidden files/directories
alias dir='ls -lhpA --color --group-directories-first'

# Make grep ignore case and highlight matching string
alias grep="grep --ignore-case --color"

# Identify a zombie process
alias zombie="ps axo stat,ppid,pid,comm | grep -w defunct"

# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# >>> Prompt renderers

# Option 1: like posh-git
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
# Enable git aliases auto completion
source /usr/share/bash-completion/completions/git

# Option 2: oh-my-posh
# 1. curl -s https://ohmyposh.dev/install.sh | bash -s
# 2. oh-my-posh font install Inconsolata
# 3. wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/powerlevel10k_rainbow.omp.json -P .config/
# 4. echo 'eval "$(oh-my-posh init bash --config ~/.config/powerlevel10k_rainbow.omp.json)"' >> ~/.profile
# For enabling language versions display in your theme see https://github.com/JanDeDobbeleer/oh-my-posh/discussions/5902#discussioncomment-11284862

# Install updates, set Docker containers to not autorestart
alias update='sudo apt update; sudo apt upgrade -y; sudo apt autoremove -y; sdk update; sudo snap refresh; docker update --restart=no $(docker container ls -a -q)'

# Colorize ip output
alias ip='ip -c'
