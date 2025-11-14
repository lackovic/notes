<#
.SYNOPSIS
    Install commonly used applications via Winget.
.NOTES
    Comment out any applications you do not wish to install.
#>

#Requires -RunAsAdministrator

winget source update

# General Apps
winget install chrome
winget install vscode
winget install -h --id Git.Git
winget install -h --id DominikReichl.KeePass
winget install -h --id FastStone.Viewer
winget install -h --id AutoHotkey.AutoHotkey
winget install -h --id Microsoft.PowerShell
winget install -h --id LocalSend.LocalSend
winget install -h --id Mega.MEGASync

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
