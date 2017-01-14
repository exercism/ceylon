# xceylon

Exercism problems in Ceylon.

[![Build Status](https://travis-ci.org/exercism/xceylon.svg?branch=master)](https://travis-ci.org/exercism/xceylon)

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
This directory should contain the following files and directories, where `<slug>` is the slug of the exercise, and `<Slug>` is the CamelCased version:

* `source/<slug>/module.ceylon`: the [module descriptor](https://ceylon-lang.org/documentation/tour/modules/#dependencies_and_module_descriptors).
  * This file will declare the module and any dependencies.
  * Typically, the only dependency will be on [`ceylon.test`](https://herd.ceylon-lang.org/modules/ceylon.test) at the current Ceylon version.
  * We don't expect to have other dependencies, but we may consider adding dependencies for an exercise if it would be unnecessarily difficult and/or cumbersome without those particular dependencies.
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
  * Other files may be included in the `example/` directory if appropriate.

## License

The MIT License (MIT)

Copyright (c) 2016 Katrina Owen, _@kytrinyx.com

### Ceylon icon 
The Ceylon icon is assumed to be owned by Red Hat, Inc. It appears to be released under the [Creative Commons Attribution Share-Alike 3.0 license](https://creativecommons.org/licenses/by-sa/3.0/). We have modified its colour scheme for use on Exercism.
