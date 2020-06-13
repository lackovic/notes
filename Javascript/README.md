# Javascript

_Table of Contents_
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Promises](#promises)
- [Frameworks and Libraries](#frameworks-and-libraries)
  - [AngularJS](#angularjs)
- [NodeJS](#nodejs)
  - [Installation (nvm)](#installation-nvm)
  - [The Event Loop](#the-event-loop)
  - [The Worker Pool (aka the Thread Pool)](#the-worker-pool-aka-the-thread-pool)
  - [Scaling](#scaling)
  - [REPL](#repl)
  - [Conferences videos](#conferences-videos)
  - [Node Package Manager (npm)](#node-package-manager-npm)
    - [Remove modules not listed in package.json](#remove-modules-not-listed-in-packagejson)
    - [Upgrade your dependencies to the latest versions](#upgrade-your-dependencies-to-the-latest-versions)
    - [How to keep your dependencies up to date](#how-to-keep-your-dependencies-up-to-date)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Promises

A promise is an object that may produce a single value some time in the future: either a resolved value, or a reason that it’s not resolved (e.g., a network error occurred). A promise may be in one of 3 possible states:

- fulfilled
- rejected
- pending

Promise users can attach callbacks to handle the fulfilled value or the reason for rejection. Promises are eager, meaning that a promise will start doing whatever task you give it as soon as the promise constructor is invoked.

A chain of promises without a catch at the end can potentially hide an issue by making errors failing silently. If you have to debug a big codebase, you can use the `unhandledRejection` hook to find all unhandled Promise rejections:

```js
process.on('unhandledRejection', (err) => {
  console.log(err)
})
```

## Frameworks and Libraries

A framework owns the main() function, it performs some function like managing a collection of windows on the screen, it can run even without customization. The framework defines the overall nature of the program, while your code provides specific customizations.

A library is a box of tools used by your code. Your code owns main() and provides the overall structure of the program. The library does some specific task, like sending traffic over the network, computing bessel functions, etc. A library can do big things, like draw a view of a three-dimensional space full of objects, but only after you tell it about the objects.

- [Source](https://qr.ae/pNt5QI)

### AngularJS

A framework mainly maintained by Google, was superseded by [Angular](https://en.wikipedia.org/wiki/Angular_(web_framework)) in 2016.

* [Angular 1 Style Guide](https://github.com/johnpapa/angular-styleguide/tree/master/a1) by John Papa
* [AngularJS styleguide (ES2015)](https://github.com/toddmotto/angularjs-styleguide) by Todd Motto
* [AngularJS with Gulp Step by Step](https://youtu.be/p9ZngMW80-k) by Mark Winterbottom
* [Designing and Building Component-based AngularJS Applications](https://app.pluralsight.com/library/courses/component-based-angularjs-applications) by Miguel Castro
* [Ultimate AngularJS Component Oriented Design Guide](http://gautierdelorme.com/2016/04/20/ultimate-angularjs-component-oriented-design-guide.html) by Gautier Delorme

## NodeJS

Node.js is a JavaScript runtime or platform which is built on Google Chrome’s JavaScript v8 engine. This runtime allows executing the JavaScript code on any machine outside a browser (this means that it is the server that executes the Javascript and not the browser).

Node.js is single-threaded and employs a concurrency model based on an event loop. It doesn’t block the execution instead registers a callback which allows the application to continue: that means Node.js can handle concurrent operations without creating multiple threads of execution thus can scale pretty well.

The areas where it’s perfect to use Node.js are:

- I/O bound Applications
- Data Streaming Applications
- Data Intensive Real-time Applications (DIRT)
- JSON APIs based Applications
- Single Page Applications

Node.js is not suitable for heavy applications involving more of CPU usage.

Node.js uses an _event-driven architecture_: it has an _Event Loop_ for orchestration and a _Worker Pool_ for expensive tasks.

### Installation (nvm)

The best way to install Node.js is through _nvm (Node Version Manager)_.

On linux, follow [these instructions](https://github.com/nvm-sh/nvm#install--update-script).

On Windows, [install it with Chocolatey](https://chocolatey.org/packages/nvm).

### The Event Loop

Node.js processes incoming requests in the event loop: it's what allows Node.js to perform non-blocking operations despite the fact that JavaScript is single-threaded. 

The Event Loop notices each new client connection and orchestrates the generation of a response. All incoming requests and outgoing responses pass through the Event Loop. This means that if the Event Loop spends too long at any point, all current and new clients will not get a turn. You should make sure you never block the Event Loop. In other words, each of your JavaScript callbacks should complete quickly.

A good way to ensure this is to reason about the "computational complexity" of your callbacks. If your callback takes a constant number of steps no matter what its arguments are, then you'll always give every pending client a fair turn. If your callback takes a different number of steps depending on its arguments, then you should think about how long the arguments might be.

Two common ways to block the Event Loop are (1) using a _vulnerable_ regular expression or (2) using `JSON.parse` and `JSON.stringify`.

If you want to do complex calculations in JavaScript without blocking the Event Loop, you have two options: partitioning or offloading.

- [What the heck is the event loop anyway? | Philip Roberts | JSConf EU](https://youtu.be/8aGhZQkoFbQ)

### The Worker Pool (aka the Thread Pool)

Node.js runs JavaScript code in the Event Loop (initialization and callbacks), and offers a Worker Pool to handle expensive tasks like file I/O. Node.js scales well, sometimes better than more heavyweight approaches like Apache. The secret to the scalability of Node.js is that it uses a small number of threads to handle many clients. If Node.js can run with fewer threads, then it can spend more of your system's time and memory working on clients rather than on paying space and time overheads for threads (memory, context-switching). But because Node.js has only a few threads, you must structure your application to use them wisely. A good rule of thumb for keeping your Node.js server speedy is: Node.js is fast when the work associated with each client at any given time is "small".

Node.js uses the Worker Pool to handle "expensive" tasks. This includes I/O for which an operating system does not provide a non-blocking version, as well as particularly CPU-intensive tasks. The Node.js module APIs that make use of this Worker Pool are:

- I/O-intensive: DNS, File System
- CPU-intensive: Crypto, Zlib

- [Don't Block the Event Loop (or the Worker Pool)](https://nodejs.org/uk/docs/guides/dont-block-the-event-loop/)

### Scaling

It can handle concurrent operations without creating multiple threads of execution (low resource cost per connection).

In a one-thread-per-client system like Apache, each pending client is assigned its own thread. If a thread handling one client blocks, the operating system will interrupt it and give another client a turn. The operating system thus ensures that clients that require a small amount of work are not penalized by clients that require more work.

Because Node.js handles many clients with few threads, if a thread blocks handling one client's request, then pending client requests may not get a turn until the thread finishes its callback or task. The fair treatment of clients is thus the responsibility of your application. This means that you shouldn't do too much work for any client in any single callback or task.

This is part of why Node.js can scale well, but it also means that you are responsible for ensuring fair scheduling.

### REPL

The REPL stands for _Read Eval Print Loop__: it is a simple program that accepts the commands, evaluates them, and finally prints the results. REPL provides an environment similar to that of Unix/Linux shell or a window console, in which we can enter the command and the system, in turn, responds with the output. REPL performs the following tasks.

- READ: it Reads the input from the user, parses it into JavaScript data structure and then stores it in the memory.
- EVAL: it Executes the data structure.
- PRINT: it Prints the result obtained after evaluating the command.
- LOOP: it Loops the above command until the user presses Ctrl+C two times.

### Conferences videos

- [Node+JS Interactive 2015](https://www.youtube.com/watch?v=O28Knn00qYo&list=PLfMzBWSH11xYjL8oFumSfzOf6-kr8_t-o)
- [Node+JS Interactive 2016 - Europe](https://www.youtube.com/watch?v=GD-Fw6VNtUc&list=PLfMzBWSH11xZKfC2b-XWJRMtl9y-jtQBN)
- [Node+JS Interactive 2016 - North America](https://www.youtube.com/watch?v=HxGt_3F0ULg&list=PLfMzBWSH11xYaaHMalNKqcEurBH8LstB8)
- [Node.js Live Events 2016 - Paris & London](https://www.youtube.com/watch?v=czbfOM6DY1Q&list=PLfMzBWSH11xZWvE3iuTw6tdzp90gnODdp)
- [Node+JS Interactive 2017 - Vancouver](https://www.youtube.com/watch?v=zphcsoSJMvM&list=PLfMzBWSH11xa-iNnQG2555lgi4574nZOh)
- [Node+JS Interactive 2018](https://www.youtube.com/watch?v=7-tcLvyaEBM&list=PLfMzBWSH11xaZvhv1X5Fq1H-oMdnAtG6k)
- [Node+JS Interactive 2019](https://www.youtube.com/watch?v=3JNYBdS-uXU&list=PLfMzBWSH11xZPfWcC0DqFqKo_reMP58mw)

### Node Package Manager (npm)

The _Node Package Manager_ provides the following two main functionalities:

- online repository for node.js packages/modules which are present at <nodejs.org>.

- command line utility to install packages, do version management and dependency management of Node.js packages.

NPM comes bundled along with Node.js installable.

#### Remove modules not listed in package.json

```powershell
npm prune
```

#### Upgrade your dependencies to the latest versions

```powershell
npm install -g npm-check-updates
ncu
ncu -u
```

See:
- [npm-check-updates](https://www.npmjs.com/package/npm-check-updates)

#### How to keep your dependencies up to date

- [npm-outdated](https://docs.npmjs.com/cli/outdated.html)
- [npm-update](https://docs.npmjs.com/cli/update.html)
- [npm-check](https://www.npmjs.com/package/npm-check)
- [Validating dependencies in the project with npm-check and depcheck](https://medium.com/@wlodarczyk_j/validating-dependencies-in-the-project-with-npm-check-and-depcheck-20e83345fc1f)
- [Semantic versioning](https://semver.org/)
