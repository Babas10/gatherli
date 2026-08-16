// Base class for all Use Cases / Interactors.
//
// Architecture: UI → BLoC → UseCase → Repository → Firebase
//
// Use Cases encapsulate a single piece of business logic, independent of UI
// and Firebase. They are easily unit-tested without mocking Firestore.
//
// Usage:
//   class MyUseCase extends UseCase<MyInput, MyOutput> {
//     @override
//     Future<MyOutput> execute(MyInput input) async { ... }
//   }
abstract class UseCase<Input, Output> {
  const UseCase();

  Future<Output> execute(Input input);

  /// Convenience call operator — allows `useCase(input)` syntax.
  Future<Output> call(Input input) => execute(input);
}

/// Use Case with no input parameter.
abstract class NoInputUseCase<Output> {
  const NoInputUseCase();

  Future<Output> execute();

  Future<Output> call() => execute();
}
