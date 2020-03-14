# File location = %USERPROFILE%\Documents\WindowsPowerShell\
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-5.1

Set-Location C:\src

function prompt {            
    "$(Get-Date -Format "yyyy/MM/dd HH:mm.ss") $(get-location) > "
}

Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
