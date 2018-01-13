# fmt

An alternative string format library for pony.

Intended to be a more convenient replacement for simple string
concatenation where complex number formatting or alignment is not
required than the builtin `format` library.

Note that the code currently doesn't check that the number of
values passed in actually match the number of formatting marks in the
string: Too few, and there will be `%` markers left in the printed
string. Too many, and only as many as needed by the format string are
used.

Usage example:

``` pony

use "fmt"

actor Main
  new create(env: Env) =>
    Fmt("listening on %:%")("localhost")("80").print(env.out)
    let str = Fmt("a formatted %")("string").string()

```

## Formatting literals

Literal numbers are ambiguous types and can't be passed directly to
the `Fmt.apply` method. Therefore, they need to be typed. This can
either be done by explicitly casting them as so: `F32(2.4)`, or by
using the `a` method:

``` pony
Fmt("Formatting %, a number").a[F32](2.4).string()
```

## Escaping percent characters

To print a `%` character, double it up:

```
Fmt("The first %% is ignored, the second %")("is replaced").string()
```
