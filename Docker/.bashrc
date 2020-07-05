# Docker
alias d-clean='docker system prune'
alias d-list='docker container ls -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"'
alias d-stop-all='docker stop $(docker container ls -q)'

# Docker Compose
alias dc-start='docker-compose up -d'
alias dc-build='docker-compose build'
alias dc-stop='docker-compose down --remove-orphans'
alias dc-restart='docker-compose up -d --force-recreate'
alias dc-rebuild='docker-compose down --remove-orphans && docker-compose build && docker-compose up -d'
