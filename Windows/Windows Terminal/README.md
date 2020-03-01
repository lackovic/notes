# Windows Terminal

Windows Terminal is a terminal application for users of command-line tools and shells like Command Prompt, PowerShell, and WSL, which provides multiple tab support as well as theming and customization.

![Image description](https://raw.githubusercontent.com/lackovic/notes/master/Windows/Windows%20Terminal/img/windows-terminal-640.png)

## Installation

```powershell
choco install microsoft-windows-terminal
```

## Configuration

See [`.\profiles.json`](profiles.json) for examples on how to set:

- [WSL profiles](https://github.com/lackovic/notes/blob/a69ac7066798699f53ac56c8344896b29ccf2ba2/Windows/Windows%20Terminal/profiles.json#L35-L41)
- [SSH profiles](https://github.com/lackovic/notes/blob/a69ac7066798699f53ac56c8344896b29ccf2ba2/Windows/Windows%20Terminal/profiles.json#L28-L34)
- [profile defaults](https://github.com/lackovic/notes/blob/a69ac7066798699f53ac56c8344896b29ccf2ba2/Windows/Windows%20Terminal/profiles.json#L10-L13)
- [custom icons](https://github.com/lackovic/notes/blob/a69ac7066798699f53ac56c8344896b29ccf2ba2/Windows/Windows%20Terminal/profiles.json#L25) - you also need to put a 32x32 PNG in `%LOCALAPPDATA%\packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\RoamingState`
- [color schemes](https://github.com/lackovic/notes/blob/a69ac7066798699f53ac56c8344896b29ccf2ba2/Windows/Windows%20Terminal/profiles.json#L58-L171)

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
