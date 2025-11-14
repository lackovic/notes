<#
.SYNOPSIS
    Configure various Windows settings for improved usability and performance.
.EXAMPLE
    WARNING! This script must be executed in this specific way to avoid execution policy errors:
    powershell.exe -ExecutionPolicy Bypass -File .\SetupConfig.ps1

.NOTES
    Comment out any settings you do not wish to apply.
#>

#Requires -RunAsAdministrator

# >>> Taskbar >>>

# Disable Taskbar Search box
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

# Disable Taskbar Task View button
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0

# Disable Taskbar Widgets (News and Interests)
Write-Host "*** Warning *** Disabling Taskbar Widgets (News and Interests) is not automated yet, please do it manually." -ForegroundColor Yellow

# Disable Taskbar Chat button
Write-Host "*** Warning *** Disabling Taskbar Chat button is not automated yet, please do it manually." -ForegroundColor Yellow

# Set Taskbar alignment to Left (0 = Left, 1 = Center)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Type DWord -Value 0

# >>> Explorer >>>

# Hide desktop icons
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name HideIcons -Value 1

# Enable showing hidden files and file extensions in Windows Explorer
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0

# Enable classic context menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

# Enable "Expand to open folder" in Navigation pane
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -Value 1 -Type DWord

# Restart Explorer to apply the above changes
Stop-Process -Name explorer -Force

# >>> Notification >>>

# Disable Notifications
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0 -Force

# Enable Notifications > Do not disturb
Write-Host "*** Warning *** Enabling Notifications > Do not disturb is not automated yet, please do it manually." -ForegroundColor Yellow

# Disable Notifications > Additional settings > "Show the Windows welcome experience..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Value 0 -Type DWord

# Disable Notifications > Additional settings > "Suggest ways to get the most out of Windows..."
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0

# Disable Notifications > Additional settings > "Get tips and suggestions when I use Windows"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0 -Type DWord

# >>> Power >>>

# Set lid close action to "Do Nothing" for both battery and plugged in
powercfg /setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
powercfg /setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
powercfg /setactive SCHEME_CURRENT

# Enable hibernate option in power menu
powercfg /hibernate on
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power' -Name HibernateEnabled -Value 1
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' -Name ShowHibernateOption -Value 1 -Force

# Control panel > Power options > Choose what the power buttons do > Turn on fast startup
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 1 -Type DWord

# Disable computer wake up on key press or mouse movement
# You might have to run this command again after a plugging in a new mouse or keyboard, or after a major Windows update
powercfg /DEVICEQUERY wake_programmable | Select-String -Pattern "mouse|keyboard" | ForEach-Object { $_.ToString() } | ForEach-Object { powercfg /DEVICEDISABLEWAKE $_ }

# >>> Visual and audio >>>

# Set Sounds > More sounds settings > Sounds > Sound Scheme to "No Sounds"
Set-ItemProperty -Path "HKCU:\AppEvents\Schemes" -Name "(Default)" -Value ".None" -Type String
Get-ChildItem -Path "HKCU:\AppEvents\Schemes\Apps" -Recurse | 
    Where-Object { $_.PSChildName -eq ".Current" } | 
    ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name "(Default)" -Value "" -Type String }

# Disable Accessibility > Visual effects > Transparency effects
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name EnableTransparency -Type DWord -Value 0

# Disable Accessibility > Visual effects > Animation effects
# https://github.com/Raphire/Win11Debloat/issues/120
Write-Host "*** Warning *** Disabling Accessibility > Visual effects > Animation effects is not automated yet, please do it manually." -ForegroundColor Yellow

# >>> Other Settings >>>

# Disable Personalization > Start "Show recommended files in Start, recent files in File Explorer, and items in Jump Lists"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value 0 -Type DWord

# Disable Personalization > Start "Show recommendetions for tips, shortcuts, new apps, and more"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_IrisRecommendations" -Value 0 -Type DWord

# Enable Windows Update "Get the latest updates as soon as they're available"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "IsContinuousInnovationOptedIn" -Value 1 -Type DWord

# Enable System > Clipboard > Clipboard history
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Value 1 -Type DWORD -Force

# Disable Cortana and web search integration in Windows Search
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 00000000 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v AllowSearchToUseLocation /t REG_DWORD /d 00000000 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 00000000 /f

# Disable hyper key (Win+Alt+Ctrl+Shift) opening Microsoft Office
REG ADD HKCU\Software\Classes\ms-officeapp\Shell\Open\Command /t REG_SZ /d rundll32 /f

# Enable Windows Security > App & browser control > Reputation-based protection
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost" -Name "EnableWebContentEvaluation" -Type DWord -Value 1

# >>> Bloatware Removal >>>

# Microsoft Teams
Get-AppxPackage -Name "MicrosoftTeams" | Remove-AppxPackage
Get-AppxPackage -Name "MSTeams" | Remove-AppxPackage

# Microsoft To Do
Get-AppxPackage -Name "Microsoft.Todos" | Remove-AppxPackage

# Microsoft Clipchamp
Get-AppxPackage -Name "Clipchamp.Clipchamp" | Remove-AppxPackage

# Microsoft Copilot
winget uninstall -h --id 9WZDNCRD29V9

# News
Get-AppxPackage -Name "Microsoft.BingNews" | Remove-AppxPackage

# OneDrive
winget uninstall -h --id Microsoft.OneDrive

# Outlook (new)
Get-AppxPackage -Name "Microsoft.OutlookForWindows" | Remove-AppxPackage

# Paint
Get-AppxPackage -Name "Microsoft.Paint" | Remove-AppxPackage

# Phone Link
Get-AppxPackage -Name "Microsoft.YourPhone" | Remove-AppxPackage

# Photos
Get-AppxPackage -Name "Microsoft.Windows.Photos" | Remove-AppxPackage

# Solitaire & Casual Games
Get-AppxPackage -Name "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxPackage

# Sticky Notes
Get-AppxPackage -Name "Microsoft.MicrosoftStickyNotes" | Remove-AppxPackage

# Xbox (multiple components)
Get-AppxPackage -Name "Microsoft.GamingApp" | Remove-AppxPackage
Get-AppxPackage -Name "Microsoft.Xbox.TCUI" | Remove-AppxPackage
Get-AppxPackage -Name "Microsoft.XboxApp" | Remove-AppxPackage
Get-AppxPackage -Name "Microsoft.XboxGameOverlay" | Remove-AppxPackage
Get-AppxPackage -Name "Microsoft.XboxGamingOverlay" | Remove-AppxPackage
Get-AppxPackage -Name "Microsoft.XboxIdentityProvider" | Remove-AppxPackage
Get-AppxPackage -Name "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage
Get-ProvisionedAppxPackage -Online | Where-Object { $_.PackageName -match "xbox" } | ForEach-Object { Remove-ProvisionedAppxPackage -Online -AllUsers -PackageName $_.PackageName }
