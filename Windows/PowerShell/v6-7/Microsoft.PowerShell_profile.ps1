# File location = %USERPROFILE%\Documents\PowerShell\
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7

Import-Module posh-git
$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "yyyy/MM/dd HH:mm.ss") '
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Magenta

Import-Module PSReadLine
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Import-Module PSColor
$global:PSColor.File.Code.Pattern = '\.(java|c|cpp|cs|js|jsx|ts|tsx|css|html)$'
$global:PSColor.File.Text.Pattern = '\.(txt|cfg|conf|ini|csv|log|config|xml|yml|md|markdown|json)$'

Set-Location C:\src

Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

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

