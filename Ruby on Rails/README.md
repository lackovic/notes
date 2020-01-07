# Ruby on Rails

*Contents*
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Access Rails console](#access-rails-console)
- [Clean up unused gems in your bundler directory](#clean-up-unused-gems-in-your-bundler-directory)
- [Format .erb files in VsCode](#format-erb-files-in-vscode)
- [Run (focus on) one test only out of a suite of tests](#run-focus-on-one-test-only-out-of-a-suite-of-tests)
- [RubyMine](#rubymine)
  - [Install a theme from a jar file](#install-a-theme-from-a-jar-file)
  - [Select a theme](#select-a-theme)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Access Rails console

```shell
bundle exec rails c
```

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

## Run (focus on) one test only out of a suite of tests

```shell
bundle exec rspec path/file_spec.rb:32
```

## RubyMine

### Install a theme from a jar file

File → Settings → Plugins → Marketplace → Three dots → Install plugin from disk → Select the jar → Restart the IDE

### Select a theme

File → Settings → Appearance & Behavior → Appearance → Theme