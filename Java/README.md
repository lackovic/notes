# Java

## Gradle

### Basic commands

```sh
# Tasks runnable from root project
gradle tasks

# Build displaying more logging information
gradle -i build

# Executes only the tests in SomeTestClass
gradle test --tests SomeTestClass
```

### Plugins

Since Gradle version 3 plugins can be specified through the plugins DSL:

```groovy
plugins {
    id 'java'
}
```

The `plugins {}` block must be a top level statement in the buildscript and cannot be nested inside another construct.

## IntelliJ IDEA

### Find in path regex

```sh
# Find files which contain two strings on any line
(string1)[\s\S]*(string2)|\2[\s\S]*\1

# Find files which contain two strings on the same line
\Qstring1\E.*\Qstring2\E
```

### Favorite plugins

- [Lombok plugin](https://plugins.jetbrains.com/plugin/6317)

- [Visual Studio Code Dark Plus Theme](https://plugins.jetbrains.com/plugin/12255-visual-studio-code-dark-plus-theme)

### Navigate back and forward using mouse buttons clicks

Settings > Keymap > Navigate > Back | Forward > right click > Add mouse shortcut

### Enable mouse scroll zooming

Settings > Editor > General > Change font size with Ctrl+Mouse Wheel

### Shortcuts

Key|Command|Notes
---|-------|----------
`Ctrl+Shift+A` | Find action | *Enables you to search for commands and settings across all menus and tools (similarly to VsCode "Show all commands" - Ctrl+Shift+P)*
`Shift Shift` | Search for a target by name (Search everywhere) | *Find any item in the project or outside of it by its name: files, actions, classes, symbols, settings, and UI elements. (similar - but more powerful - than VsCode "Go to File..., Quick Open" - Ctrl+P)*
`Ctrl+Shift+F` | Find in path | *Search for a text string within a project*
`Ctrl+E` | Open Recent files | 
`Ctrl+Shift+E` | Open Recent Edited files | 
`Ctrl+F12` | Locate a code element | *Open the structure view popup allowing to jump to the desired element*
`Ctrl+Alt+Shift+N` | Navigate to symbol in project (class, method, etc) |
