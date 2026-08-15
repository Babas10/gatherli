// Connectivity service — detects offline state and notifies the app.
// Wire this to all list pages to show OfflineBanner when disconnected.
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService._();
  static final ConnectivityService instance = ConnectivityService._();

  final _connectivity = Connectivity();
  final _controller = StreamController<bool>.broadcast();

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isOnline = true;

  bool get isOnline => _isOnline;

  /// Call once at app startup in main().
  void initialize() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      final online = results.any((r) => r != ConnectivityResult.none);
      if (online != _isOnline) {
        _isOnline = online;
        _controller.add(online);
      }
    });

    // Check current state immediately
    _connectivity.checkConnectivity().then((results) {
      _isOnline = results.any((r) => r != ConnectivityResult.none);
      _controller.add(_isOnline);
    });
  }

  /// Stream of online/offline state changes.
  Stream<bool> get onConnectivityChanged => _controller.stream;

  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }
}
