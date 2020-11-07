# Java

_Table of Contents_
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Spring](#spring)
- [Lombok](#lombok)
  - [Create private constructor](#create-private-constructor)
- [Gradle](#gradle)
  - [Basic commands](#basic-commands)
  - [Plugins](#plugins)
  - [Set console=rich by default](#set-consolerich-by-default)
  - [Print the full stacktrace when logging tests exceptions](#print-the-full-stacktrace-when-logging-tests-exceptions)
- [SDKMAN](#sdkman)
  - [Set up a specific Java version for a project](#set-up-a-specific-java-version-for-a-project)
  - [Switch Java version automatically when you cd into a directory](#switch-java-version-automatically-when-you-cd-into-a-directory)
- [IntelliJ IDEA](#intellij-idea)
  - [Install on Linux](#install-on-linux)
  - [Find in path regex](#find-in-path-regex)
  - [Favorite plugins](#favorite-plugins)
  - [Settings](#settings)
    - [Navigate back and forward using mouse buttons clicks](#navigate-back-and-forward-using-mouse-buttons-clicks)
    - [Enable changing the font size with the mouse wheel](#enable-changing-the-font-size-with-the-mouse-wheel)
    - [Prevent IDEA from automatically close opened files](#prevent-idea-from-automatically-close-opened-files)
  - [Shortcuts](#shortcuts)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Spring

- [Write parameterized tests with autowiring dependency injection in Spring Boot 1](https://stackoverflow.com/a/63168806/334569)
- [Setting a TTL for @Cacheable](https://stackoverflow.com/a/44203099/334569)

## Lombok

### Create private constructor

```java
@NoArgsConstructor(access = AccessLevel.PRIVATE)
```

## Gradle

### Basic commands

```sh
# Tasks runnable from root project
gradle tasks

# Build displaying more logging information
gradle -i build

# Executes only the tests in SomeTestClass
gradle test --tests SomeTestClass

# Executes only one specific test method
gradle test --tests SomeTestClass.specificMethod

# Stop immediately after the first failing test
gradle test --fail-fast
```

### Plugins

Since Gradle version 3 plugins can be specified through the plugins DSL:

```groovy
plugins {
    id 'java'
}
```

The `plugins {}` block must be a top level statement in the buildscript and cannot be nested inside another construct.

### Set console=rich by default

Both in _Gradle_ and _Gradle Wrapper_, add the following line to your `./gradle.properties`:

```
org.gradle.console=rich
```

### Print the full stacktrace when logging tests exceptions

Add the following block to your `./build.gradle`:

```groovy
test {
    testLogging.exceptionFormat = 'full'
}
```

## SDKMAN

SDKMAN allows to install multiple versions of Java and conveniently switch between them.

### Set up a specific Java version for a project

1. cd into the base directory of your project

1. use SDKMAN to switch to the desired Java version

1. run `sdk env init` (this will generate a `.sdkmanrc` file in the current directory, pre-populated with the Java version in use)

From now on when you enter your project base directory you can switch to the chosen Java version by simply running:

```sh
$ sdk env
```

### Switch Java version automatically when you cd into a directory

Set the folling in your `~/.sdkman/etc/config`:

```sh
sdkman_auto_env=true 
```

## IntelliJ IDEA

### Install on Linux

[Install as a snap package](https://www.jetbrains.com/help/idea/installation-guide.html#snap) to have your installation always up to date.

Alternatively, install manually with the following steps:

1. Download [IntelliJ IDEA](https://www.jetbrains.com/idea/download/#section=linux)

1. Unpack the `tar.gz` file to an empty directory using the following command:

   ```sh
   tar -xzf idea-2020.2.1.tar.gz
   ```

1. Run `bin/idea.sh`

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

### Settings

#### Navigate back and forward using mouse buttons clicks

Keymap > Navigate > Back | Forward > right click > Add mouse shortcut

#### Enable changing the font size with the mouse wheel

Editor > General > Change font size with Ctrl+Mouse Wheel

#### Prevent IDEA from automatically close opened files

Editor > General > Editor Tabs > Tab limit = 100

### Shortcuts

Key|Command|Notes
---|-------|----------
`Ctrl+Shift+A` | Find action | *Enables you to search for commands and settings across all menus and tools (similarly to VsCode "Show all commands" - Ctrl+Shift+P)*
`Shift Shift` | Search for a target by name (Search everywhere) | *Find any item in the project or outside of it by its name: files, actions, classes, symbols, settings, and UI elements. (similar - but more powerful - than VsCode "Go to File..., Quick Open" - Ctrl+P)*
`Ctrl+Shift+F` | Find in path | *Search for a text string within a project*
`Ctrl+E` | Open Recent files | 
`Ctrl+Shift+E` | Open Recent Edited files | 
`Ctrl+F12` | Locate a code element | *Open the structure view popup allowing to jump to the desired element*
`Ctrl+N` | Navigate to class |
`Ctrl+Shift+N` | Navigate to file by file name |
`Ctrl+Alt+Shift+N` | Navigate to symbol in project (class, method, etc) |
