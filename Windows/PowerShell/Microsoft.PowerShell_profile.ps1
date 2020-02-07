Import-Module posh-git

Import-Module PSReadLine
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Import-Module PSColor
$global:PSColor.File.Code.Pattern = '\.(java|c|cpp|cs|js|jsx|ts|tsx|css|html)$'
$global:PSColor.File.Text.Pattern = '\.(txt|cfg|conf|ini|csv|log|config|xml|yml|md|markdown|json)$'

Set-Location C:\src

# ssh aliases

Function connectToServer1 { ssh deploy@192.168.0.186 }
Set-Alias -Name ubuntu -Value connectToServer1

# Docker aliases
function Start-Docker { docker-compose up -d }
Set-Alias dstart Start-Docker

function Build-Docker { docker-compose build }
Set-Alias dbuild Build-Docker

function Stop-Docker { docker-compose down --remove-orphans }
Set-Alias dstop Stop-Docker

function Restart-Docker { docker-compose up -d --force-recreate }
Set-Alias drestart Restart-Docker

function Rebuild-Docker { docker-compose down --remove-orphans; docker-compose build; docker-compose up -d }
Set-Alias drebuild Rebuild-Docker

function Clean-Docker { docker system prune }
Set-Alias dclean Clean-Docker

