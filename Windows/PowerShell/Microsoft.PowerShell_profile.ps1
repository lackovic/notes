# >>> Setup 
# 1. Copy this file:
#    for PowerShell 5 to %USERPROFILE%\Documents\WindowsPowerShell\
#    for PowerShell 6-7 to %USERPROFILE%\Documents\PowerShell\
# 2. Run as admin "Set-ExecutionPolicy Bypass" to enable running scripts in your system
#    More info https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-5.1

# >>> Prompt renderers
#
# Option 1: https://github.com/dahlbyk/posh-git
# 1. Run as admin "PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force"
# 2. Uncomment the following lines to enable posh-git:
# Import-Module posh-git
# 3. Uncomment the following lines to prefix each prompt with date and time:
# $GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "HH:mm:ss") '
# $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Magenta
#
# Option 2: https://github.com/JanDeDobbeleer/oh-my-posh
# 1. winget install --id JanDeDobbeleer.OhMyPosh
# 2. oh-my-posh font install Inconsolata
# 3. To enable language versions in your theme see https://github.com/JanDeDobbeleer/oh-my-posh/discussions/5902#discussioncomment-11284862
# 4. Uncomment the following line to enable Oh My Posh:
#oh-my-posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/powerlevel10k_rainbow.omp.json | Invoke-Expression

# >>> Color highlighting
#
# 1. Download https://github.com/Davlind/PSColor/raw/master/release/PSColor.zip
# 2. Extract the content of PSColor.zip to $HOME\Documents\PowerShell\Modules\PSColor
# 3. Run Get-ChildItem -Recurse "$HOME\Documents\PowerShell\Modules\PSColor" | Unblock-File
# 4. Uncomment the following lines to enable PSColor:
#Import-Module PSColor
#$global:PSColor.File.Code.Pattern = '\.(java|c|cpp|cs|js|jsx|ts|tsx|css|html)$'
#$global:PSColor.File.Text.Pattern = '\.(txt|cfg|conf|ini|csv|log|config|xml|yml|md|markdown|json)$'

# >>> Key bindings
#
# 1. Set Ctrl+D to exit the shell
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

# >>> Winfetch
# Run as admin "Install-Script -Name pwshfetch-test-1"
#Set-Alias winfetch pwshfetch-test-1

# To set the default starting folder uncomment the following line:
#Set-Location C:\src

# Setup to use fnm https://github.com/Schniz/fnm#shell-setup
#fnm env --use-on-cd | Out-String | Invoke-Expression

# >>> Functions

function Disable-History {
    <#
    .SYNOPSIS
        Disables the persistent PSReadLine history for the current session.
    #>
    $global:PSReadLineOldHistorySaveStyle = (Get-PSReadLineOption).HistorySaveStyle
    Set-PSReadLineOption -HistorySaveStyle SaveNothing
    Write-Host "Persistent PSReadLine history disabled for this session." -ForegroundColor Yellow
}

function Remove-KeywordFromHistory {
    <#
    .SYNOPSIS
        Removes from the persistent PSReadLine history file the commands containing a specified keyword.
    .PARAMETER Keyword
        The keyword to search for in the persistent history.
    .EXAMPLE
        Remove-PSReadLineHistoryByKeyword -Keyword "password"
    .EXAMPLE
        Remove-PSReadLineHistoryByKeyword secret
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Keyword
    )

    $historyPath = (Get-PSReadlineOption).HistorySavePath
    if (Test-Path $historyPath) {
        $lines = Get-Content $historyPath
        $filtered = $lines | Where-Object { $_ -notlike "*$Keyword*" }
        $removedCount = $lines.Count - $filtered.Count
        $filtered | Set-Content $historyPath
        Write-Host "Removed $removedCount entries from persistent PSReadLine history." -ForegroundColor Green
    }
    else {
        Write-Host "PSReadLine history file not found at $historyPath." -ForegroundColor Yellow
    }
    Write-Host "Persistent history cleanup completed." -ForegroundColor Green
}

function Remove-DuplicateHistory {
    <#
    .SYNOPSIS
        Removes duplicate entries from PSReadLine history, keeping only the last occurrence.
    #>
    $historyPath = (Get-PSReadlineOption).HistorySavePath
    if (Test-Path $historyPath) {
        $lines = Get-Content $historyPath
        # Create a hashtable to track the last index of each command
        $lastIndex = @{}
        for ($i = 0; $i -lt $lines.Count; $i++) {
            $lastIndex[$lines[$i]] = $i
        }
        # Keep only lines that are at their last occurrence index
        $unique = for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lastIndex[$lines[$i]] -eq $i) {
                $lines[$i]
            }
        }
        $unique | Set-Content $historyPath
    }
}

# Set up a prompt command to remove duplicates after each command
Set-PSReadLineOption -AddToHistoryHandler {
    param($command)
    # Remove duplicates from history file
    Remove-DuplicateHistory
    return $true
}

# Don't record space-prefixed commands
Set-PSReadLineOption -AddToHistoryHandler {
    param([string]$line)
    return $line.Length -gt 3 -and $line[0] -ne ' ' -and $line[0] -ne ';'
}
