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
