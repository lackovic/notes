# Visual Studio Code

## Favorite shortcuts, settings and extensions

### Shortcuts

| Key                       | Command                           | Notes                                                                        |
| ------------------------- | --------------------------------- | ---------------------------------------------------------------------------- |
| `Ctrl+Shift+P`            | Show All Commands                 | _Probably the most important shortcut of all, I still often forget about it_ |
| `Ctrl+P`                  | Go to File..., Quick Open         |
| `Ctrl+Shift+O`            | Go to Symbol...                   | _Jumps to variable/function in current file_                                 |
| `Shift+Enter`             | Go to position...                 | _Jumps to a position in the current file (needs the *jumpy* extension)_      |
| `Ctrl+K Z`                | Toggle Zen Mode                   |
| `Ctrl+K M`                | Change Language Mode              | _Select language for the current file_                                       |
| `Ctrl+K O`                | Show Opened File in New Window    | _Open the current file in a new window_                                      |
| `Ctrl+Shift+P dupl Enter` | Duplicate workspace in New Window |
| `Shift+Alt+Down`          | Copy Line Down                    | _Duplicate selection down_                                                   |

[All shortcuts](https://code.visualstudio.com/docs/getstarted/keybindings)

### User settings

```js
{
  "breadcrumbs.enabled": true,
  "diffEditor.ignoreTrimWhitespace": true,
  "editor.cursorSurroundingLines": 5,
  "editor.fontFamily": "Inconsolata, 'Input Mono Light', 'Fira Code', Consolas, 'Courier New', monospace",
  "editor.fontSize": 16,
  "editor.minimap.enabled": true,
  "editor.minimap.scale": 3,
  "editor.mouseWheelZoom": true,
  "explorer.confirmDelete": false,
  "explorer.confirmDragAndDrop": false,
  "files.autoSave": "onWindowChange",
  "window.zoomLevel": 0,
  "workbench.settings.useSplitJSON": true,
  "workbench.settings.editor": "json"
}
```

### Workspace settings

```js
{
    "files.exclude": {
        ".vscode": true
    },
}
```

### Top Extensions

- [Better Comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)
- [Bracket Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer)
- [Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)
- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- [Partial Diff](https://marketplace.visualstudio.com/items?itemName=ryu1kn.partial-diff)
- [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)
- [Sort lines](https://marketplace.visualstudio.com/items?itemName=Tyriar.sort-lines)
- [Surround](https://marketplace.visualstudio.com/items?itemName=yatki.vscode-surround)
- [Text Marker (Highlighter)](https://marketplace.visualstudio.com/items?itemName=ryu1kn.text-marker)
- [Selected Lines Count](https://marketplace.visualstudio.com/items?itemName=gurumukhi.selected-lines-count)

### Useful Extensions

- [Bookmarks](https://marketplace.visualstudio.com/items?itemName=alefragnani.Bookmarks)
- [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- [GraphQL for VSCode](https://marketplace.visualstudio.com/items?itemName=kumar-harsh.graphql-for-vscode)
- [jumpy](https://marketplace.visualstudio.com/items?itemName=wmaurer.vscode-jumpy)
- [Log File Highlighter](https://marketplace.visualstudio.com/items?itemName=emilast.LogFileHighlighter)
- [Markdown Preview Enhanced](https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced)
- [Paste JSON as Code](https://marketplace.visualstudio.com/items?itemName=quicktype.quicktype)
- [PowerShell](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)
- [Project Snippets](https://marketplace.visualstudio.com/items?itemName=rebornix.project-snippets)
- [Subtitles Editor](https://marketplace.visualstudio.com/items?itemName=pepri.subtitles-editor)
- [VS Live Share](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare)
