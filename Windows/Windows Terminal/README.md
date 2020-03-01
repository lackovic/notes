# Windows Terminal

Windows Terminal is a terminal application for users of command-line tools and shells like Command Prompt, PowerShell, and WSL, which provides multiple tab support as well as theming and customization.

## Installation

```powershell
choco install microsoft-windows-terminal
```

## Configuration

See [`.\profiles.json`](profiles.json) for examples on how to set WSL and ssh profiles, profile defaults and color schemes.

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
