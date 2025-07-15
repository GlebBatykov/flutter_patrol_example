/// Обертка над тестами.
///
/// В методе inject должны содержаться тесты которые
/// относятся только к тестированию одного конкретного функционала.
abstract interface class TestInjector {
  const TestInjector();

  void inject();
}
