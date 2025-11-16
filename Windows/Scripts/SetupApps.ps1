<#
.SYNOPSIS
    Install commonly used applications via Winget.
.NOTES
    Comment out any applications you do not wish to install.
#>

#Requires -RunAsAdministrator

winget source update

# General Apps
winget install -h --id Google.Chrome
winget install -h --id Telegram.TelegramDesktop
winget install -h --id Mega.MEGASync
winget install -h --id DominikReichl.KeePass
winget install -h --id AutoHotkey.AutoHotkey
winget install -h --id Microsoft.PowerShell
winget install -h --id HermannSchinagl.LinkShellExtension
winget install -h --id Microsoft.VisualStudioCode
winget install -h --id Git.Git
winget install -h --id FastStone.Viewer
winget install -h --id LocalSend.LocalSend
winget install -h --id TGRMNSoftware.BulkRenameUtility
winget install -h --id SumatraPDF.SumatraPDF
winget install -h --id Spotify.Spotify
winget install -h --id GIMP.GIMP.3
winget install -h --id RIA.eIDsoftware
winget install -h --id CodecGuide.K-LiteCodecPack.Mega
winget install -h --id Avidemux.Avidemux
winget install -h --id JAMSoftware.TreeSize.Frees
winget install -h --id RIA.eIDsoftware

# Gaming Apps
winget install -h --id Discord.Discord
winget install -h --id Valve.Steam
winget install -h --id Amazon.Games
winget install -h --id GOG.Galaxy
winget install -h --id EpicGames.EpicGamesLauncher

# Work Apps
winget install -h --id JetBrains.IntelliJIDEA.Ultimate
winget install -h --id SlackTechnologies.Slack
winget install -h --id DBeaver.DBeaver.Community
winget install -h --id Docker.DockerDesktop
winget install -h --id Schniz.fnm
winget install -h --id Bruno.Bruno
winget install -h --id Gravitational.Teleport
winget install -h --id Google.GoogleDrive

# Windows Subsystem for Linux
wsl --install
