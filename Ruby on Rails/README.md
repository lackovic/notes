# Ruby on Rails

## Clean up unused gems in your bundler directory

```shell
# Print the changes, but do not clean the unused gems.
bundle clean --dry-run
# Force a clean even if --path is not set.
bundle clean --force
```

- [Docs](https://bundler.io/man/bundle-clean.1.html)

## Format .erb files in VsCode

Add to your workspace settings:
```json
"files.associations": {
   "*.html.erb": "html"
}
```

- [Prettier .erb support request](https://github.com/prettier/plugin-ruby/issues/371)
