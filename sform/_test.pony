use "ponytest"

actor Main is TestList
  new create(env: Env) => PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestBasic)
    test(_TestLiterals)
    test(_TestEscape)

class iso _TestBasic is UnitTest
  fun name(): String => "sform/basic"

  fun apply(h: TestHelper) =>
    h.assert_eq[String]("connect to localhost:80 and enjoy",
      Sform("connect to %:% and enjoy")("localhost")("80").string())

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
