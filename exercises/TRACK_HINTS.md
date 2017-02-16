## Running Ceylon Tests

We run tests with the [ceylon test](https://ceylon-lang.org/documentation/reference/tool/ceylon/subcommands/ceylon-test.html) command.

`ceylon test` expects a module name to run the tests on.
In the Ceylon track, each exercise has just a single module.
Therefore, you can run the tests with:

```bash
ceylon test $(basename source/*)
```
