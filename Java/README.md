# Java

_Table of Contents_
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Spring](#spring)
- [Lombok](#lombok)
  - [Create private constructor](#create-private-constructor)
- [Maven](#maven)
  - [Basic commands](#basic-commands)
- [Gradle](#gradle)
  - [Basic commands](#basic-commands-1)
  - [Plugins](#plugins)
  - [Set console=rich by default](#set-consolerich-by-default)
  - [Print the full stacktrace when logging tests exceptions](#print-the-full-stacktrace-when-logging-tests-exceptions)
  - [Upgrade all dependencies to their latest version](#upgrade-all-dependencies-to-their-latest-version)
- [SDKMAN](#sdkman)
  - [Set up a specific Java version for a project](#set-up-a-specific-java-version-for-a-project)
  - [Switch Java version automatically when you cd into a directory](#switch-java-version-automatically-when-you-cd-into-a-directory)
- [Flyway](#flyway)
- [IntelliJ IDEA](#intellij-idea)
  - [Install on Linux](#install-on-linux)
  - [Find in path regex](#find-in-path-regex)
  - [Object to JSON in debugger](#object-to-json-in-debugger)
  - [Favorite plugins](#favorite-plugins)
  - [Settings](#settings)
    - [Navigate back and forward using mouse buttons clicks](#navigate-back-and-forward-using-mouse-buttons-clicks)
    - [Enable changing the font size with the mouse wheel](#enable-changing-the-font-size-with-the-mouse-wheel)
    - [Prevent IDEA from automatically close opened files](#prevent-idea-from-automatically-close-opened-files)
  - [Shortcuts](#shortcuts)
  - [Useful links](#useful-links)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Spring

- [Write parameterized tests with autowiring dependency injection in Spring Boot 1](https://stackoverflow.com/a/63168806/334569)
- [Setting a TTL for @Cacheable](https://stackoverflow.com/a/44203099/334569)

## Lombok

### Create private constructor

```java
@NoArgsConstructor(access = AccessLevel.PRIVATE)
```

## Maven

### Basic commands

```sh
# Display available updates
mvn versions:display-dependency-updates

# Execute only the tests in SomeTestClass
mvn test -Dtest=SomeTestClass

# Stop immediately after the first failing test
mvn test -Dsurefire.skipAfterFailureCount=1
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

### Upgrade all dependencies to their latest version

Use [Gradle Use Latest Versions Plugin ](https://github.com/patrikerdes/gradle-use-latest-versions-plugin).

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

## Flyway

_Flyway_ is an open-source database migration tool: it is based around just 7 basic commands: `migrate`, `clean`, `info`, `validate`, `undo`, `baseline` and `repair`.

Migrations files names must comply with [Flyway naming pattern](https://flywaydb.org/documentation/concepts/migrations.html#naming).

To check that flyway is configured correctly and to see the list of pending migrations run:

```sh
flyway info
```

To run the pending migrations run:

```sh
flyway migrate
```

Rolling back/undo migrations is availble only for _Flyway Pro_ or _Enterprise Edition_. To roll back with the _Community Edition_ you need to:

- locally:

   1. run `flyway clean`

   1. move the migrations you want to roll back out of `flyway.locations`

   1. run `flyway migrate`

   1. move the migrations you rolled back in `flyway.locations`

- staging/production:

   1. write migrations which revert the changes made in the migrations you want to roll back

   1. commit, push and deploy the migrations

For furthern info check the [Flyway documentation](https://flywaydb.org/documentation/).

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

### Object to JSON in debugger

- [Get object as JSON in IntelliJ Idea from debugger](https://stackoverflow.com/a/60189764/334569)

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

### Useful links

- [KAFKA explained in a children’s book](https://www.gentlydownthe.stream/)
