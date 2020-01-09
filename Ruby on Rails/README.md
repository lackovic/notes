# Ruby on Rails

*Contents*
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Introduction](#introduction)
- [Clean up unused gems in your bundler directory](#clean-up-unused-gems-in-your-bundler-directory)
- [Format .erb files in VsCode](#format-erb-files-in-vscode)
- [Testing](#testing)
- [Rails console](#rails-console)
  - [Enter Rails console](#enter-rails-console)
  - [Enable syntax highlighting](#enable-syntax-highlighting)
  - [CRUD database operations](#crud-database-operations)
- [RubyMine](#rubymine)
  - [Install a theme from a jar file](#install-a-theme-from-a-jar-file)
  - [Select a theme](#select-a-theme)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Introduction

**Ruby** is an interpreted scripting object-oriented programming language. **Ruby on Rails** ("RoR") is an open-source framework, written in Ruby, for implementing web applications.

## Clean up unused gems in your bundler directory

```shell
# Print the changes, but do not clean the unused gems.
bundle clean --dry-run

# Force a clean even if --path is not set.
bundle clean --force
```

- [Docs](https://bundler.io/man/bundle-clean.1.html)


## Format .erb files in VsCode

This is not a good solution but it is the best I could find.
Add to your workspace settings:
```json
"files.associations": {
   "*.html.erb": "html"
}
```

- [Prettier .erb support request](https://github.com/prettier/plugin-ruby/issues/371)

## Testing

```shell
# Run (focus on) one test only out of a suite of tests
bundle exec rspec path/file_spec.rb:32
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

## RubyMine

### Install a theme from a jar file

File → Settings → Plugins → Marketplace → Three dots → Install plugin from disk → Select the jar → Restart the IDE

### Select a theme

File → Settings → Appearance & Behavior → Appearance → Theme