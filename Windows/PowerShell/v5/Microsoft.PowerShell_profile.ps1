# 1. Copy this file to %USERPROFILE%\Documents\WindowsPowerShell\
# 2. Run as admin "Set-ExecutionPolicy Bypass" to enable running scripts in your system
# More info https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-5.1

# Allow to quit the current terminal with Ctrl+D
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

# Provide color highlighting for some basic PowerShell output
# Run as admin "Install-Module PSColor"
# More info https://github.com/Davlind/PSColor
Import-Module PSColor
$global:PSColor.File.Code.Pattern = '\.(java|c|cpp|cs|js|jsx|ts|tsx|css|html)$'
$global:PSColor.File.Text.Pattern = '\.(txt|cfg|conf|ini|csv|log|config|xml|yml|md|markdown|json)$'

# Integrate Git and PowerShell
# Run as admin "PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force"
# More info https://github.com/dahlbyk/posh-git
Import-Module posh-git

# Prefix each prompt with date and time with posh-git
$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "HH:mm:ss") '
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Magenta

# Prefix each prompt with date and time without posh-git
# function prompt {            
#     "$(Get-Date -Format "yyyy/MM/dd HH:mm.ss") $(get-location) > "
# }

# Set default folder
Set-Location C:\src
