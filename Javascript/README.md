# Javascript

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