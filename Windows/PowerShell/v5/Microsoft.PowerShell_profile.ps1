# 1. Copy this file to %USERPROFILE%\Documents\WindowsPowerShell\
# 2. Run as admin "Set-ExecutionPolicy Bypass" to enable running scripts in your system
# More info https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-5.1

# Provide color highlighting for some basic PowerShell output
# 1. Download https://github.com/Davlind/PSColor/raw/master/release/PSColor.zip
# 2. Extract it to a folder named PSColor in any of your PowerShell module paths (run $env:PSModulePath to see your paths)
# More info https://github.com/Davlind/PSColor
Import-Module PSColor
$global:PSColor.File.Code.Pattern = '\.(java|c|cpp|cs|js|jsx|ts|tsx|css|html)$'
$global:PSColor.File.Text.Pattern = '\.(txt|cfg|conf|ini|csv|log|config|xml|yml|md|markdown|json)$'

# Prompt renderers
#
# Option 1: https://github.com/JanDeDobbeleer/oh-my-posh
# 1. winget install --id JanDeDobbeleer.OhMyPosh
# 2. oh-my-posh font install Inconsolata
# 3. To enable language versions in your theme see https://github.com/JanDeDobbeleer/oh-my-posh/discussions/5902#discussioncomment-11284862
# 4. Uncomment the following line to enable Oh My Posh:
#oh-my-posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/powerlevel10k_rainbow.omp.json | Invoke-Expression

# Option 2: https://github.com/dahlbyk/posh-git
# 1. Run as admin "PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force"
# 2. Uncomment the following lines to enable posh-git:
#Import-Module posh-git
# 3. Uncomment the following lines to prefix each prompt with date and time:
#$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "HH:mm:ss") '
#$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Magenta

# See system information win Winfetch
# Run as admin "Install-Script -Name pwshfetch-test-1"
Set-Alias winfetch pwshfetch-test-1

# To set the default starting folder uncomment the following line:
#Set-Location C:\src

# Setup to use fnm https://github.com/Schniz/fnm#shell-setup
fnm env --use-on-cd | Out-String | Invoke-Expression
