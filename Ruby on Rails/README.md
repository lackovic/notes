# Ruby on Rails

*Contents*
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Introduction](#introduction)
- [Debugging](#debugging)
- [Testing](#testing)
- [Generate your database diagram from Rails schema](#generate-your-database-diagram-from-rails-schema)
- [Gems management](#gems-management)
  - [List installed gems](#list-installed-gems)
  - [Know the version of an installed gem](#know-the-version-of-an-installed-gem)
  - [Clean up unused gems in your bundler directory](#clean-up-unused-gems-in-your-bundler-directory)
  - [Uninstall all Ruby gems](#uninstall-all-ruby-gems)
  - [Display information about the RubyGems environment](#display-information-about-the-rubygems-environment)
  - [Change version of an installed gem](#change-version-of-an-installed-gem)
- [Rails console](#rails-console)
  - [Enter Rails console](#enter-rails-console)
  - [Enable syntax highlighting](#enable-syntax-highlighting)
  - [CRUD database operations](#crud-database-operations)
- [Migrations data types](#migrations-data-types)
- [Resources](#resources)
- [Visual Studio Code](#visual-studio-code)
  - [Recommended extensions](#recommended-extensions)
  - [Format .erb files in VsCode](#format-erb-files-in-vscode)
- [RubyMine](#rubymine)
  - [Windows](#windows)
    - [Installation](#installation)
    - [Setup](#setup)
  - [Find in path regex](#find-in-path-regex)
  - [Favorite plugins](#favorite-plugins)
  - [Install a theme from a jar file](#install-a-theme-from-a-jar-file)
  - [Select a theme](#select-a-theme)
  - [Navigate back and forward using mouse buttons clicks](#navigate-back-and-forward-using-mouse-buttons-clicks)
  - [Enable mouse scroll zooming](#enable-mouse-scroll-zooming)
  - [Shortcuts](#shortcuts)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Introduction

**Ruby** is an interpreted scripting object-oriented programming language. **Ruby on Rails** ("RoR") is an open-source framework, written in Ruby, for implementing web applications.

## Debugging

1. Insert `binding.pry` before the line you want the execution to be paused
1. Run your app or test
1. The execution will pause where you inserted the binding and will give you a rails console.

- See [Debugging With Pry](https://learn.co/lessons/debugging-with-pry)

## Testing

```shell
# Run (focus on) one test only out of a suite of tests
bundle exec rspec path/file_spec.rb:32
```

## Generate your database diagram from Rails schema

1. Open [dbdiagram.io](https://dbdiagram.io/)
1. Click Import → From Rails (schema.rb)
1. Paste (or upload) your schema.rb

## Gems management

### List installed gems

```sh
gem list --local
```

### Know the version of an installed gem

```sh
gem list --local | grep your-gem-name
```

### Clean up unused gems in your bundler directory

```sh
# Print the changes, but do not clean the unused gems.
bundle clean --dry-run

# Force a clean even if --path is not set.
bundle clean --force
```

- [Docs](https://bundler.io/man/bundle-clean.1.html)

### Uninstall all Ruby gems

```sh
# Make sure you upgrade your Rubygems:
gem update --system

# Uninstall all gems:
gem uninstall --all
```

### Display information about the RubyGems environment

```sh
gem env
```

### Change version of an installed gem

1. Install the new version (e.g. `1.17.3`) with:

   ```sh
   gem install bundler:1.17.3
   ```

1. uninstall the previously existing version with:

   ```sh
   gem uninstall bundler
   ```

## Rails console

### Enter Rails console

```shell
# Using your global version of Rails:
rails c

# Testing out some code without changing any data:
# (modifications will be rolled back on exit)
rails c --sandbox

# Using the local version of Rails defined in your Gemfile:
bundle exec rails c
```

### Enable syntax highlighting

Use [pry](https://github.com/pry/pry)

### CRUD database operations

```ruby
# Create
User.create(name: "Douglas")

# Read by ID (returns only one object if found, if not raises an exception):
User.find(42)
# Read by name (returns only one object if found, if not returns nil):
User.find_by(name: "Douglas")
# Read by name (returns an array of objects if found, if not returns an empty array):
User.where(gender: "Male")

# Update
User.find(42).update_attribute(:name, "Douglas")

# Delete only the current object record:
User.delete(42)
User.delete_all(age: 49)
# Delete the current object record and all its descendants records:
User.destroy(42)
User.destroy_all(age: 49)
```

- [Docs](https://www.rubydoc.info/docs/rails/4.1.7/ActiveRecord/Relation)

## Migrations data types

```rb
create_table 'example' do |t|
  t.integer :int                  # int (4 bytes, max 2,147,483,647)
  t.integer :int1,  limit: 1   # tinyint (1 byte, -128 to 127)
  t.integer :int2,  limit: 2   # smallint (2 bytes, max 32,767)
  t.integer :int3,  limit: 3   # mediumint (3 bytes, max 8,388,607)
  t.integer :int4,  limit: 4   # int (4 bytes)
  t.integer :int5,  limit: 5   # bigint (8 bytes, max 9,223,372,036,854,775,807)
  t.integer :int8,  limit: 8   # bigint (8 bytes)
  t.integer :int11, limit: 11  # int (4 bytes)

  t.timestamp    :my_date         # timestamp without time zone
  t.timestamptz  :my_other_date   # timestamp with time zone

  t.string       :str,                 # character varying(255)
  t.string       :str, length: 255     # character varying(512)
  t.string       :str, length: 1024    # character varying(1024)
end
``` 

- [Source](https://gist.github.com/icyleaf/9089250)

## Resources

- [The Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide)
- [Ruby Style Guide](https://github.com/github/rubocop-github/blob/master/STYLEGUIDE.md)

## Visual Studio Code

### Recommended extensions

- [endwise](https://marketplace.visualstudio.com/items?itemName=kaiwood.endwise)
- [Ruby Solargraph](https://marketplace.visualstudio.com/items?itemName=castwide.solargraph) (`gem install solargraph` required)
- [Gem Lens](https://marketplace.visualstudio.com/items?itemName=ninoseki.vscode-gem-lens)

### Format .erb files in VsCode

This is not a good solution but it is the best I could find.
Add to your workspace settings:
```json
"files.associations": {
   "*.html.erb": "html"
}
```

- [Prettier .erb support request](https://github.com/prettier/plugin-ruby/issues/371)

## RubyMine

### Windows

#### Installation

The easiest way to install it is with Chocolatey:

```powershell
choco install rubymine -y
```

#### Setup

1. Install Ruby with Chocolatey, choosing from the [available versions](https://chocolatey.org/packages/ruby#versionhistory)

1. Run `ridk install` and choose options 1, 2 and 3 when asked

1. Run `bundle install` in your project directory (if some of the gems installation fails, try commenting them out from your `Gemfile`)


### Find in path regex

```sh
# Find files which contain two strings on any line
(string1)[\s\S]*(string2)|\2[\s\S]*\1

# Find files which contain two strings on the same line
\Qstring1\E.*\Qstring2\E
```

### Favorite plugins

- [VS Code Keymap](https://plugins.jetbrains.com/plugin/12062-vs-code-keymap)

- [Visual Studio Code Dark Plus Theme](https://plugins.jetbrains.com/plugin/12255-visual-studio-code-dark-plus-theme)

### Install a theme from a jar file

File → Settings → Plugins → Marketplace → Three dots → Install plugin from disk → Select the jar → Restart the IDE

### Select a theme

File → Settings → Appearance & Behavior → Appearance → Theme

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
