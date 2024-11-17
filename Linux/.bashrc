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

# Use Oh My Posh prompt renderer
# 1. curl -s https://ohmyposh.dev/install.sh | bash -s
# 2. oh-my-posh font install Inconsolata
# 3. wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/powerlevel10k_rainbow.omp.json -P .config/
# 4. echo 'eval "$(oh-my-posh init bash --config ~/.config/powerlevel10k_rainbow.omp.json)"' >> ~/.profile
# For enabling language versions display in your theme see https://github.com/JanDeDobbeleer/oh-my-posh/discussions/5902#discussioncomment-11284862

# Uncomment one of the following lines to enable git aliases auto completion
# source /etc/bash_completion.d/git
# source /usr/share/bash-completion/completions/git

# Keep system time in sync, install updates, set Docker containers to not autorestart
alias update='sudo timedatectl set-ntp true; sudo apt update; sudo apt upgrade -y; sudo apt autoremove -y; sdk update; sudo snap refresh; docker update --restart=no $(docker container ls -a -q)'

# Colorize ip output
alias ip='ip -c'
