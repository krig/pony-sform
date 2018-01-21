use "ponytest"

actor Main is TestList
  new create(env: Env) => PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestBasic)
    test(_TestLiterals)
    test(_TestEscape)
    test(_TestStore)

class iso _TestBasic is UnitTest
  fun name(): String => "sform/basic"

  fun apply(h: TestHelper) =>
    let who = "friend"
    h.assert_eq[String]("Welcome to localhost:80, friend!",
      Sform("Welcome to %:%, %!")("localhost").a[U32](80)(who).string())

    let name' = "alice"
    let when: U64 = 2018
    h.assert_eq[String]("alice (2018) says: Hello, world!", Sform("% (%) says: %")(name')(when)("Hello, world!").string())
    h.assert_eq[String]("a formatted string", Sform("a % %")("formatted")("string").string())


class iso _TestLiterals is UnitTest
  fun name(): String => "sform/literals"

  fun apply(h: TestHelper) =>
    h.assert_eq[String]("10",
      Sform("%").a[ISize](10).string())

    h.assert_eq[String]("-10",
      Sform("%").a[ISize](-10).string())

    h.assert_eq[String]("1.1",
      Sform("%").a[F32](1.1).string())

class iso _TestEscape is UnitTest
  fun name(): String => "sform/escape"

  fun apply(h: TestHelper) =>
    h.assert_eq[String](
      "The first % is ignored, the second is replaced",
      Sform("The first %% is ignored, the second %")("is replaced").string())

class iso _TestStore is UnitTest
  fun name(): String => "sform/store"

  fun apply(h: TestHelper) =>
    let a: Array[Sform] = [Sform("foo % % bar"); Sform("wiz % % bin")]
    for (i, partial) in a.pairs() do
      partial(i)
    end
    try
      let first = a.shift()?("a")
      let second = a.shift()?("b")
      h.assert_eq[String]("foo 0 a bar", first.string())
      h.assert_eq[String]("wiz 1 b bin", second.string())
    end
