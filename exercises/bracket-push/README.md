# Bracket Push

Given a string containing brackets `[]`, braces `{}` and parentheses `()`,
verify that all the pairs are matched and nested correctly.

## Running Ceylon Tests

Before tests can be run, your code must be compiled via [`ceylon compile`](https://ceylon-lang.org/documentation/current/reference/tool/ceylon/subcommands/ceylon-compile.html).

We run tests with the [`ceylon test`](https://ceylon-lang.org/documentation/reference/tool/ceylon/subcommands/ceylon-test.html) command.

`ceylon test` expects a module name to run the tests on.
In the Ceylon track, each exercise has just a single module.

Therefore, you can run the tests with:

```bash
ceylon compile && ceylon test $(basename source/*)
```

## Source

Ginna Baker

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
