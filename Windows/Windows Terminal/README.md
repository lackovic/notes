
# Windows Terminal

[Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/) is a terminal application for users of command-line tools and shells like Command Prompt, PowerShell, and WSL, which provides multiple tab support as well as theming and customization.

![Image description](https://raw.githubusercontent.com/lackovic/notes/master/Windows/Windows%20Terminal/img/windows-terminal-640.png)


<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
_Table of Contents_

- [Benefits](#benefits)
- [Installation](#installation)
- [Configuration](#configuration)
- [Run PowerShell Core as Administrator in a Windows Terminal tab](#run-powershell-core-as-administrator-in-a-windows-terminal-tab)
- [File explorer integration](#file-explorer-integration)
- [Enable Ctrl+F4 for closing the current tab/pane](#enable-ctrlf4-for-closing-the-current-tabpane)
- [Useful shortcuts](#useful-shortcuts)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Benefits

- You have all your environments a click or shortcut away, without having to type or remember anything: e.g. `ssh user@ip` or `wsl -d distribution_name`, etc;

- the different theme/color setup makes you more aware of the environment where you are working on, thus reducing the risk of making unwanted operations in the wrong environment: e.g. with Ubuntu colors you are in an Ubuntu server, with a red background you are in production, etc;

- being the configuration in one JSON file, you only need to set it up once and then you can reuse it with little modifications for all your machines.

## Installation

```powershell
# latest stable
choco install microsoft-windows-terminal

# pre-release (or Preview version)
choco install microsoft-windows-terminal --pre
```

## Configuration

See [`.\settings.json`](settings.json) for examples on how to set:

- [WSL profiles](https://github.com/lackovic/notes/blob/0d0bbf06c573ac2a976b071d39ebb0e62198e3e5/Windows/Windows%20Terminal/settings.json#L58-L62)
- [SSH profiles](https://github.com/lackovic/notes/blob/0d0bbf06c573ac2a976b071d39ebb0e62198e3e5/Windows/Windows%20Terminal/settings.json#L50-L55)
- [profile defaults](https://github.com/lackovic/notes/blob/0d0bbf06c573ac2a976b071d39ebb0e62198e3e5/Windows/Windows%20Terminal/settings.json#L29-L30)
- [custom icons](https://github.com/lackovic/notes/blob/0d0bbf06c573ac2a976b071d39ebb0e62198e3e5/Windows/Windows%20Terminal/settings.json#L37) - you also need to put a 32x32 PNG in `%LOCALAPPDATA%\packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\RoamingState`
- [color schemes](https://github.com/lackovic/notes/blob/0d0bbf06c573ac2a976b071d39ebb0e62198e3e5/Windows/Windows%20Terminal/settings.json#L89-L178)
- [key bindings](https://github.com/lackovic/notes/blob/0d0bbf06c573ac2a976b071d39ebb0e62198e3e5/Windows/Windows%20Terminal/settings.json#L183-L205)

Place your icon files in `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\RoamingState`.

Some sample icons che be found in the [icons](./icons/) folder.

## Run PowerShell Core as Administrator in a Windows Terminal tab

```powershell
# Install gsudo:
choco install gsudo -y

# Update the current session with environment variables changes:
refreshenv

# Generate a GUID:
[guid]::NewGuid()

# Add a new profile in Windows Terminal settings:
{
   "guid": "{new-guid-generated-above}",
   "hidden": false,
   "name": "PowerShell Core Admin",
   "commandline": "gsudo.exe pwsh"
}
```

- [Source](https://github.com/microsoft/terminal/issues/632#issuecomment-582782751)

## File explorer integration

You can right click on a folder in File Explorer and select _Open in Windows Terminal_. See [Windows Terminal Preview 1.1 Release](https://devblogs.microsoft.com/commandline/windows-terminal-preview-1-1-release/).

## Enable Ctrl+F4 for closing the current tab/pane

Add the following to the `actions` array of your `settings.json`:

```js
{ "command": "closePane", "keys": "ctrl+f4" }
```

## Useful shortcuts

- `Ctrl`+`Shift`+`n`, where `n` is a number: opens the n-th terminal type in a new tab (e.g. `1` for PowerShell, `2` for Ubuntu, etc).

- `Ctrl`+`Shift`+`w`: closes the current tab.

- `Ctrl`+`Shift`+`t`: opens a new tab with the same terminal type as the current tab.

- `Alt`+`Shift`+`d`: splits the current pane horizontally or vertically (same terminal type).
