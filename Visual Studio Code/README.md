# Visual Studio Code

_Table of Contents_

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Useful workspace settings](#useful-workspace-settings)
- [Favorite shortcuts](#favorite-shortcuts)
- [Favorite user settings](#favorite-user-settings)
- [Top Extensions](#top-extensions)
- [Useful Extensions](#useful-extensions)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Useful workspace settings

```js
// Hide VsCode configuration files from sidebar explorer
"files.exclude": { ".vscode": true },

// Use relative path for Typescript auto-imports
"typescript.preferences.importModuleSpecifier": "relative"

// Use single quotes in Typescript auto-imports
"typescript.preferences.quoteStyle": "single"

// Automatically update TypeScript import paths on file rename/move
"typescript.updateImportsOnFileMove.enabled": "always"
```

## Favorite shortcuts

| Key                       | Command                           |
| ------------------------- | --------------------------------- |
| `Ctrl+Shift+P`            | Show all commands                 |
| `Ctrl+P`                  | Go to file..., quick open         |
| `Ctrl+Shift+O`            | Go to symbol in the current file  |
| `Ctrl+T`                  | Go to symbol in the whole project |
| `Ctrl+K M`                | Change language mode              |
| `Ctrl+K O`                | Show opened file in new window    |
| `Ctrl+Shift+P dupl Enter` | Duplicate workspace in new window |
| `Shift+Alt+Down`          | Copy line down / Duplicate line   |
| `Ctrl+Shift+N`            | New window                        |
| `Ctrl+R`                  | Open recent folder                |
| `Ctrl+.`                  | Show the quickfix menu            |
| `Ctrl+,`                  | Open settings                     |
| `Ctrl+Shift+.`            | Focus and select breadcrumbs      |
| `Ctrl+Shift+G G`          | Show source control               |
| `Ctrl+Shift+E`            | Show and focus explorer           |
| `Ctrl+B`                  | Toggle sidebar visibility         |
| `Ctrl+0`                  | Focus into sidebar                |
| `Ctrl+1`                  | Focus into editor                 |
| `Ctrl+/`                  | Toggle comment on selected lines  |

[All shortcuts](https://code.visualstudio.com/docs/getstarted/keybindings)

## Favorite user settings

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
  "window.title": "${rootName}",
  "window.zoomLevel": 0,
  "workbench.editor.wrapTabs": true,
  "workbench.settings.useSplitJSON": true,
  "workbench.settings.editor": "json"
}
```

## Top Extensions

- [Better Comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)
- [Bracket Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer)
- [Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)
- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- [Partial Diff](https://marketplace.visualstudio.com/items?itemName=ryu1kn.partial-diff)
- [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [Sort lines](https://marketplace.visualstudio.com/items?itemName=Tyriar.sort-lines)
- [Surround](https://marketplace.visualstudio.com/items?itemName=yatki.vscode-surround)
- [Text Marker (Highlighter)](https://marketplace.visualstudio.com/items?itemName=ryu1kn.text-marker)
- [Selected Lines Count](https://marketplace.visualstudio.com/items?itemName=gurumukhi.selected-lines-count)
- [Rewrap](https://marketplace.visualstudio.com/items?itemName=stkb.rewrap)

## Useful Extensions

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
