# pony-sform

An alternative string format library for pony.

Intended to be a convenient tool for doing simple string formatting in
the style of `printf`/`sprintf` rather than concatenating strings
together using `+` or `String.append`. Right now, there is no support
for more complex formatting rules, so for any kind of more involved
formatting I recommend using the builtin `format` library.

## Status

[![CircleCI](https://circleci.com/gh/krig/pony-sform.svg?style=svg)](https://circleci.com/gh/krig/pony-sform)

Note that the code currently doesn't check that the number of
values passed in actually match the number of formatting marks in the
string: Too few, and there will be `%` markers left in the printed
string. Too many, and only as many as needed by the format string are
used.

## Usage

``` pony

use "sform"

actor Main
  new create(env: Env) =>
    let name = "alice"
    let when: U64 = 2018
    env.out.print(Sform("% (%) says: %")(name)(when)("Hello, world!").string())
    let str = Sform("a % %")("formatted")("string").string()

```

### Formatting literals

Literal numbers are ambiguous types and can't be passed directly to
the `Sform.apply` method. Therefore, they need to be typed. This can
either be done by explicitly casting them as so: `F32(2.4)`, or by
using the `a` method:

``` pony
Sform("Formatting %, a number").a[F32](2.4).string()
```

### Escaping percent characters

To print a `%` character, double it up:

```
Sform("The first %% is ignored, the second %")("is replaced").string()
```

## Installation

* Install [pony-stable](https://github.com/ponylang/pony-stable)
* Update your `bundle.json`

```json
{ 
  "type": "github",
  "repo": "krig/pony-sform"
}
```

* `stable fetch` to fetch your dependencies
* `use "sform"` to include this package
* `stable env ponyc` to compile your application
