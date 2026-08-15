// Base BLoC that automatically cancels all StreamSubscriptions on close().
// Extend this instead of Bloc<E, S> whenever you hold stream subscriptions.
//
// Usage:
//   class MyBloc extends BaseBloc<MyEvent, MyState> {
//     MyBloc() : super(MyInitial()) {
//       _sub = myRepository.watchItems().listen(_onItems);
//       trackSubscription(_sub);   // auto-cancelled on close()
//     }
//   }
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(super.initialState);

  final List<StreamSubscription<dynamic>> _subscriptions = [];

  /// Register a subscription to be automatically cancelled when the BLoC closes.
  void trackSubscription(StreamSubscription<dynamic> subscription) {
    _subscriptions.add(subscription);
  }

  @override
  Future<void> close() async {
    for (final sub in _subscriptions) {
      await sub.cancel();
    }
    _subscriptions.clear();
    return super.close();
  }
}
