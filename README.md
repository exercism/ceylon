# xceylon

[![Build Status](https://travis-ci.org/exercism/xceylon.svg?branch=master)](https://travis-ci.org/exercism/xceylon)

Exercism problems in Ceylon.

## Contributing Guide

### Asking for help

If you're ever unsure about how to help, don't worry!
You can just ask in the [Exercism Gitter support](https://gitter.im/exercism/support) channel or by creating an issue [for the Ceylon track](https://github.com/exercism/xceylon/issues/new) and we are happy to help you!

### How to contribute

The Exercism-wide [contributing guide](https://github.com/exercism/x-common/blob/master/CONTRIBUTING.md) covers topics relevant to contributing to the entire Exercism project, including but not limited to the Ceylon track.

* To report a bug or ask a question, [create an issue](https://help.github.com/articles/creating-an-issue/).
* If you already have a fix for a bug, you could [create a pull request](https://help.github.com/articles/creating-a-pull-request-from-a-fork/).

Depending on what your contribution deals with, you may have to direct it at a certain repository:

* If your contribution deals with the README for a problem, it should go to [x-common](https://github.com/exercism/x-common).
* Otherwise, it probably deals with matters specific to the Ceylon track, in which case it goes to this repository.
* If you're not sure, you can try here and we will let you know if it should go in x-common.

#### Porting an exercise

The Exercism site provides a list of [exercises not on the Ceylon track](http://exercism.io/languages/ceylon/todo).
A possible contribution would be to choose one of these exercises and add it to this track.
The common contributing guide has a [section on porting an exercise](https://github.com/exercism/x-common/blob/master/CONTRIBUTING.md#porting-an-exercise-to-another-language-track).

Note that you will need to add the problem to the `exercises` section in `config.json` as well, otherwise it will not be available via `exercism fetch` (or any other means, other than by cloning the repository).

The order in which the exercises are listed in `config.json` is the order in which they will be served by default by `exercism fetch ceylon`.

For the Ceylon track, the files needed to port an exercise are described in the next section about [exercise structure](#exercise-structure).

### Exercise structure

Each exercise is located in the `exercises` directory, in a directory with the same name as its slug (the `leap` exercise will be at `exercises/leap`, etc.).
This directory should contain the following files and directories, where `<slug>` is the slug of the exercise with all hyphens deleted, and `<Slug>` is the CamelCased version:

* `source/<slug>/module.ceylon`: the [module descriptor](https://ceylon-lang.org/documentation/tour/modules/#dependencies_and_module_descriptors).
  * This file declares the module and any dependencies.
  * Typically, the only dependency will be on [`ceylon.test`](https://herd.ceylon-lang.org/modules/ceylon.test) at the current Ceylon version.
  * We don't expect to declare any other dependencies in this module descriptor.
  * The student is of course free to add any dependencies here if the student's individual submission requires them.
* `source/<slug>/<Slug>.ceylon`: the stub solution.
  * This file provides just the type signatures needed to make the tests compile.
  * The implementations for all functions should all be `return nothing;`, which will intentionally fail the tests.
* `source/<slug>/<Slug>Test.ceylon`: The test file.
  * If there is an `exercises/<slug>/canonical-data.json` in the `x-common` repository, the test cases should typically be those described in that file.
  * If you believe a case should be added or removed, try discussing it in the `x-common` repository to see if it would apply to all tracks.
  * If a modification to the cases only makes sense for the Ceylon track, please note the change in the test file.
  * If no JSON file is present, you may use the same tests as other languages implementing that exercise.
  * Typically, we like to use [parameterized tests](https://ceylon-lang.org/blog/2016/02/22/ceylon-test-new-and-noteworthy/#parameterized_tests) to express the tests with minimal duplication in test code.
* `example/<Slug>.ceylon`: An example solution that passes the tests.
  * This will not be served to students (all paths containing `example` are not served).
  * Instead, it is used in our [Travis CI run](.travis.yml) to make sure that the exercise is solvable and that the tests make sense.
* *optional*: `example/module.ceylon`: The module descriptor for the example solution.
  * This is necessary only if the example solution has dependencies other than `ceylon.test`.
  * Wherever possible, the dependencies should be limited to modules under the `ceylon.*` namespace, to avoid burdening Travis CI with having to fetch many external dependencies.
  * We may consider adding external dependencies for an example solution if the exercise would be unnecessarily difficult and/or cumbersome without those particular dependencies.
* *optional*: `example/*.ceylon`
  * Other files may be included in the `example/` directory if appropriate.

As a reminder, the README does not need to be added to this track - it is automatically created using the data in [x-common](https://github.com/exercism/x-common).
However, if there is any Ceylon-specific information that you would like appended to the README, place this in a `HINTS.md` file in the exercise directory (`exercises/<slug>/HINTS.md`).

### Running the tests

As mentioned, [Travis CI](https://travis-ci.org/exercism/xceylon) runs our tests to ensure that our exercises are solvable.
The tests are run on all pull requests (PRs), and we should strive to only merge PRs for which the tests are passing.

It is possible to run these tests locally as well.
In particular, the [`bin/test-exercise`](bin/test-exercise) will test just one exercise:

```bash
bin/test-exercise exercises/leap
```

This script automates the process of moving the example files in, running the tests, and then moving the example files back.
This is useful when changing an exercise in this repository.
The test can be run locally to make sure everything is working without having to wait for Travis CI.

### Style and conventions

Various choices were made in the past to get the repository to the state it is in now.
These choices aren't set in stone; they could be changed at a later date.
But the rationale behind the current choices made will be noted here.

#### Style

At the time of writing, the current maintainer of the Ceylon track was not able to find any commonly-accepted style guide for Ceylon.
Nor did the maintainer find automatic linter or formatter.
Thus, the maintainer was forced to just figure one out and try to be consistent.
For example, all indents are two spaces because that's the default in the maintainer's editor.

The maintainer is not intent on any particular style as long as all the code in the repository is consistent.
If in the future there happened to be a widely-accepted style guide and/or an automatic formatter, the maintainer would not be opposed to reformatting all code in this repository to comply.

#### Idiomatic Ceylon

All example code should be idiomatic Ceylon, to set a good example for anyone who might look at this repository for solutions to the exercises.
The current maintainer may have trouble with this point, since the current maintainer is only a Ceylon beginner and may not be familiar enough with the language to tell what is idiomatic or not.
Help in this area is especially appreciated.

#### Project structure

The current maintainer finds it regrettable that the exercise slug must be repeated so many times: `exercises/<slug>/source/<slug>/<Slug>.ceylon`.

* `exercises/<slug>` is required by Exercism, otherwise the exercise cannot be served.
* `source/<slug>` is because the exercise files are placed in a module with the same name as the exercise slug.
  * It doesn't seem possible to run [`ceylon test`](https://ceylon-lang.org/documentation/reference/tool/ceylon/subcommands/ceylon-test.html) without a module, since that is one of the arguments it requires.
  * They could all be named `main` or something similarly nondescript, but perhaps that would get confusing.
* `<Slug>.ceylon` is not required for any particular reason.
  * Then again, what else would it be named?
  * Again, `Main.ceylon` seems a bit too confusion-prone.

The current maintainer wishes there was less duplication, but does not really see a good way out.
Any ideas here are welcome.

#### Stubs

We provide the stubs with signatures included because we felt it was not a sufficiently interesting learning experience to make students have to puzzle out the expected signatures by just looking at the tests.

Because Ceylon is a statically-typed language, the entire test suite must type-check before it can be run at all.
Thus, not providing the type signatures forces the students to figure out the types for all the functions being tested, rather than being able to focus on just one at a time.

The Ceylon track is not the only track that had to make this decision.
[Other tracks have discussed this as well](https://github.com/exercism/discussions/issues/114), and come to various conclusions.

If students suggest that they would like to have the challenge of figuring out type signatures, we would gladly change our minds on this point.
They might suggest this on the exercism.io site, or on this repository via issues.
It's likely that the latter is more often monitored.

#### Parameterized tests versus one test at a time

As mentioned above, we used parameterized tests since this avoids test code duplication.

Unfortunately, since by default all cases are enabled, this runs counter to the usual Exercism style in which only a *single test case* is enabled, and the student enables one more test case after making the previous one pass, taking an iterative process.

The [ignore annotation](https://modules.ceylon-lang.org/repo/1/ceylon/test/1.3.2/module-doc/api/index.html#ignore) does not seem like it can be applied to individual cases of a parameterized test.

One possible solution to this would be to comment out all cases except the first.
If this solution were taken, students would need to be aware of this, and be informed that they need to uncomment the cases.
The Travis CI run would need to uncomment the cases as well (without uncommenting any actual comments, which would probably cause syntax errors!).

The current maintainer does not have a good solution to this, so ideas here are welcome.

## License

The MIT License (MIT)

Copyright (c) 2016 Katrina Owen, _@kytrinyx.com

### Ceylon icon 
The Ceylon icon is assumed to be owned by Red Hat, Inc. It appears to be released under the [Creative Commons Attribution Share-Alike 3.0 license](https://creativecommons.org/licenses/by-sa/3.0/). We have modified its colour scheme for use on Exercism.
