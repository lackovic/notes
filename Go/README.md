# Go

Created by a small team at Google in 2007, composed by Robert Griesemer, Rob Pike, and Ken Thompson. Ken Thomson is the creator of the B programming language, which was the direct predecessor of the C programming language. He also created the Unix operating system, and the UTF-8 character encoding. Rob Pike is the creator of the Plan 9 operating system, and the Limbo programming language. Robert Griesemer is the creator of the Java HotSpot virtual machine, and the Java programming language.

Go was created to resolve the problems of the existing languages, such as the slow build time of C++, the verbosity of Java and complexity of its type system, the slow performance of Python and JavaScript and the lack of good concurrency support in all of them. These languages where invented at a time when computers didn't have a lot of memory, and the programs typically ran on a single core. Go is a strong and statically typed, compiled language in the tradition of C, with the added benefits of memory safety, garbage collection, structural typing, and CSP-style concurrency.

CSP-style concurrency (Communicating Sequential Processes) is a concurrency model that was developed by Tony Hoare in the 1970s. It is based on the idea of having concurrent processes communicate with each other by sending and receiving messages. This is in contrast to the shared memory model of concurrency, where concurrent processes communicate with each other by reading and writing to shared memory. The shared memory model of concurrency is the model used by C, C++, and Java. The CSP-style concurrency model is the model used by Go, Erlang, and Clojure.

The key features of Go are:
- Fast compilation
- Garbage collection
- Built-in concurrency
- Static typing
- Simplicity
- Safety
- Built-in tooling

Go has a built-in library (called "standard library") full of features like a testing framework, JSON and CSV encoding/decoding, html templating, http server and router, time operations and manipulation, regular expressions, cryptographic operations such as hashing and encryption, images encoding/decoding for formats like JPEG, PNG, GIF, file compression and decompression, and many more. Having such a rich standard library means that you don't have to rely on third-party libraries for many common tasks.

Go is used by many companies, including Google, Facebook, Twitter, Dropbox, Docker, Kubernetes, and many more. Many popular projects are written in Go, including Docker, Kubernetes, Hugo, InfluxDB, Terraform, and many more.

Go doesn't have a built-in dependency injection framework. This is because Go has a built-in dependency injection mechanism called "interfaces". An interface is a type that specifies a set of methods. A type that implements all the methods of an interface implements that interface. This means that you can use a type that implements an interface anywhere that interface is used. This is called "implicit implementation". This is in contrast to "explicit implementation", where you have to explicitly declare that a type implements an interface. Implicit implementation is a form of dependency injection, because it allows you to inject a type that implements an interface into a function or method that expects that interface.

The following notes are based on the current version of Go, which is [1.20.4](https://tip.golang.org/doc/go1.20), as of May 2023.

*Table of contents*

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Installation](#installation)
- [Setup](#setup)
- [Running and compiling](#running-and-compiling)
- [Type inference](#type-inference)
- [Initial values](#initial-values)
- [Arrays](#arrays)
- [Slices](#slices)
- [Maps](#maps)
- [Loops](#loops)
- [Functions](#functions)
- [Structs](#structs)
- [Generics (WIP)](#generics-wip)
- [Fuzzing (WIP)](#fuzzing-wip)
- [Testing (WIP)](#testing-wip)
- [Naming conventions](#naming-conventions)
- [IDEs](#ides)
- [Resources](#resources)
  - [YouTube channels and playlists](#youtube-channels-and-playlists)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

Go can be installed on Windows, macOS, and Linux. The installation instructions for each operating system can be found at https://golang.org/doc/install.

On Windows can be installed with winget:

```powershell
winget install --id GoLang.Go
```

## Setup

All your projects are in the same directory called the "workspace", located in the user's home directory, which by default is called "go". You can see its location by running `go env GOPATH`. The workspace contains three subdirectories:

- `src`, which contains the source files of your projects;
- `pkg`, which contains the compiled packages;
- `bin`, which contains the compiled binaries.

## Running and compiling

```sh
# Run a Go program
go run <filename>

# Compile a Go program and place the compiled binary in the current directory
go build <filename>

# Compile a Go program and place the compiled binary in the bin directory of the workspace
go install <filename>
```

## Type inference

In Go the compiler can infer the type of a variable from its value. This is called "type inference". Type inference is useful because it allows you to omit the type of a variable when you declare it. This makes the code shorter and easier to read.

```go
// Standard declaration
var x int = 1

// Shorthand declaration with type inference
x := 1
```

## Initial values

Every type has an initial value. The initial value of a numeric type is 0, the initial value of a string type is "", and the initial value of a boolean type is false.

```go
// Initial values
var x int // 0
var y string // ""
var z bool // false
```

## Arrays

An array is a fixed-length sequence of elements of a single type. Once an array is created, its length is fixed. The length of an array is part of its type. This means that arrays of different lengths are of different types, and you cannot assign an array of one length to an array of a different length.

```go
// Standard declaration of an array
var x [3]int = [3]int{1, 2, 3}

// Shorthand declaration of an array
x := [3]int{1, 2, 3}
```

## Slices

A slice is a variable-length sequence of elements of a single type. A slice is a reference type, which means that when you assign a slice to a variable or pass a slice to a function, a copy of the slice header is created and assigned or passed. The slice header contains a pointer to the underlying array, the length of the slice, and the capacity of the slice. The capacity of a slice is the maximum number of elements that the slice can hold. The length of a slice is the number of elements that the slice currently holds. The length of a slice can be changed by re-slicing the slice. The capacity of a slice cannot be changed.

```go
// Standard declaration of a slice
var x []int = []int{1, 2, 3}

// Shorthand declaration of a slice
x := []int{1, 2, 3}
```

## Maps

Maps are unordered collections of key-value pairs. The keys of a map must be of a type that can be compared with the `==` operator. The values of a map can be of any type. The keys of a map must be unique. The values of a map can be duplicated.

```go
// Standard declaration of a map
var x map[string]int = map[string]int{"one": 1, "two": 2, "three": 3}

// Shorthand declaration of a map
x := map[string]int{"one": 1, "two": 2, "three": 3}

// Add a key-value pair to a map
x["four"] = 4

// Remove a key-value pair from a map
delete(x, "four")
```

## Loops

The `for` loop is the only loop statement in Go. It can be used to iterate over the elements of an array, slice, or map.

```go
// Iterate over the elements of an array or slice
for i := 0; i < len(x); i++ {
    fmt.Println(x[i])
}

// While loop equivalent
i := 0
for i < 10 {
    fmt.Println(i)
    i++
}

// Iterate over the elements of an array or slice with range
for i, value := range x {
    fmt.Println(i, value)
}

// Iterate over the elements of a map
for key, value := range x {
    fmt.Println(key, value)
}
```

## Functions

Functions in Go are first-class values. This means that you can assign a function to a variable, pass a function to a function, and return a function from a function.

Functions can return multiple values. The type of each return value is specified after the list of parameters. If a function returns multiple values, the return statement must specify the values to return.

```go
// Standard declaration of a function
func add(x int, y int) int {
    return x + y
}

// Return multiple values
func addAndSubtract(x int, y int) (int, int) {
    return x + y, x - y
}

// Assign variables returned from a function that returns multiple values
sum, difference := addAndSubtract(42, 13)

// Return multiple values, one of which is an error
func addPositives(x int, y int) (int, error) {
    if x < 0 || y < 0 {
        return 0, errors.New("x and y must be greater than 0")
    }
    return x + y, nil
}

// Assign a function to a variable
var f func(int, int) int = addPositives

// Pass a function to a function
func apply(f func(int, int) int, x, y int) int {
    return f(x, y)
}

// Return a function from a function
func add(x int) func(int) int {
    return func(y int) int {
        return x + y
    }
}
```

## Structs

A struct is a collection of fields. The fields of a struct can be of any type. The fields of a struct can be accessed using dot notation.

```go
// Standard declaration of a struct
type Person struct {
    Name string
    Age int
}

// Shorthand declaration of a struct
type Person struct {
    Name, Age string
}

// Create a struct
p := Person{"John Doe", 42}

// Access a field of a struct
fmt.Println(p.Name)
```

## Generics (WIP)

Go supports generics since version 1.18. Generics allow you to write functions and data structures that can be used with any type. Generics are implemented using type parameters. Type parameters are specified in square brackets after the name of the function or data structure. Type parameters are specified using the `type` keyword. Type parameters can be used as types in the function or data structure.

```go
// Generic function
func add[T any](x, y T) T {
    return x + y
}

// Generic data structure
type Stack[T any] struct {
    values []T
}

// Generic method
func (s *Stack[T]) Push(value T) {
    s.values = append(s.values, value)
}

// Create a stack of ints
var s Stack[int]

// Create a stack of strings
var s Stack[string]
```

## Fuzzing (WIP)

Fuzzing is a technique for finding bugs in software by providing random input to the software. Go has built-in support for fuzzing. To use fuzzing, you need to create a function that takes a byte slice as input and returns an integer. The function should return 1 if the input is valid and 0 if the input is invalid. The function should panic if the input is invalid. The function should not return an error. The function should not print anything to the console.

```go
// Fuzzing function
func Fuzz(data []byte) int {
    // Do something with the input
    return 1
}
```

## Testing (WIP)

Go has built-in support for testing. To write a test, you need to create a function that takes a pointer to a testing.T as input. The function should call the testing.T.Error or testing.T.ErrorF function if the test fails. The function should call the testing.T.Fatal or testing.T.FatalF function if the test fails and the test should not continue. Tests are run using the `go test` command.

```go
// Test function
func TestSomething(t *testing.T) {
    // Do something
    if something != somethingElse {
        t.Error("something is not equal to somethingElse")
    }
}
```

## Naming conventions

- The name of a variable or function should be in camel case. The first letter of the name should be lowercase, e.g. `person`, `addPerson`, `getPerson`, etc.
- The name of a boolean variable should be a question, e.g. `isPerson`, `hasPerson`, `canPerson`, `shouldPerson`, etc.
- The name of a constant should be all uppercase, using underscores to separate words, e.g. `MAX_INT`.
- The name of a type should be in camel case. The first letter of the name should be uppercase, e.g. `Person`.
- The name of a package should be in lowercase, using underscores to separate words, e.g. `person_utils`.

## IDEs

According to [Go Developer Survey 2022 Q2 Results](https://go.dev/blog/survey2022-q2-results), the 3 most popular IDEs for Go are:

1. Visual Studio Code (used by 45% of respondents)
2. GoLand (used by 34% of respondents)
3. Vim/Neovim (used by 14% of respondents)

## Resources

- [Go by Example](https://gobyexample.com/)
- [A Tour of Go](https://tour.golang.org/welcome/1)
- [Effective Go](https://golang.org/doc/effective_go.html)
- [Go Documentation](https://golang.org/doc/)
- [Go Standard Library](https://golang.org/pkg/)
- [Go Playground](https://play.golang.org/)
- [Go tutorial on TutorialEdge](https://tutorialedge.net/course/golang/)
- [All About GoLang](https://golangdocs.com/)
- [Go tutorial on GoLangTutorial](https://golangtutorial.dev/)
- [Go tutorial on GoLangByExample](https://golangbyexample.com/)
- [The Go Blog](https://go.dev/blog/)
- [Go on Twitter](https://twitter.com/golang)
- [Go Proverbs](https://go-proverbs.github.io/)
- [Practical Go Lessons](https://www.practical-go-lessons.com/)

### YouTube channels and playlists

- [Go Class, by Matt Holiday](https://www.youtube.com/playlist?list=PLoILbKo9rG3skRCj37Kn5Zj803hhiuRK6)
- [Gopher Academy](https://www.youtube.com/channel/UCx9QVEApa5BKLw9r8cnOFEA)
- [Anthony GG](https://www.youtube.com/@anthonygg_/videos)
- [Building Microservices with Go, by Nic Jackson](https://youtube.com/playlist?list=PLmD8u-IFdreyh6EUfevBcbiuCKzFk0EW_)
- [Mario Carrion](https://www.youtube.com/@MarioCarrion/videos)
- [Rob Pike's talks](https://www.youtube.com/results?search_query=Rob+Pike%27s+talks)
- [Golang University 101 - Learn Golang](https://www.youtube.com/watch?v=rFejpH_tAHM&list=PLEcwzBXTPUE9V1o8mZdC9tNnRZaTgI-1P&index=1)
- [Golang University 201 - Intermediate Golang](https://www.youtube.com/watch?v=yeetIgNeIkc&list=PLEcwzBXTPUE_5m_JaMXmGEFgduH8EsuTs)
- [Golang University 301 - Master Golang](https://www.youtube.com/playlist?list=PLEcwzBXTPUE8KvXRFmmfPEUmKoy9LfmAf)
- [The Go Programming Language](https://www.youtube.com/@golang/videos)
- [TutorialEdge](https://www.youtube.com/@Tutorialedge/videos)
- [Ardan Labs](https://www.youtube.com/@ardanlabs/video)
