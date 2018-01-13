use "ponytest"

actor Main is TestList
  new create(env: Env) => PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestBasic)
    test(_TestLiterals)
    test(_TestEscape)

class iso _TestBasic is UnitTest
  fun name(): String => "fmt/basic"

  fun apply(h: TestHelper) =>
    h.assert_eq[String]("connect to localhost:80 and enjoy",
      Fmt("connect to %:% and enjoy")("localhost")("80").string())

class iso _TestLiterals is UnitTest
  fun name(): String => "fmt/literals"

  fun apply(h: TestHelper) =>
    h.assert_eq[String]("10",
      Fmt("%")(ISize(10)).string())

    h.assert_eq[String]("-10",
      Fmt("%")(ISize(-10)).string())

    h.assert_eq[String]("1.1",
      Fmt("%")(F32(1.1)).string())

class iso _TestEscape is UnitTest
  fun name(): String => "fmt/escape"

  fun apply(h: TestHelper) =>
    h.assert_eq[String](
      "The first % is ignored, the second is replaced",
      Fmt("The first %% is ignored, the second %")("is replaced").string())
