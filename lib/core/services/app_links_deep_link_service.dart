// App Links / Universal Links implementation of DeepLinkService.
import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:play_with_me/core/domain/entities/activity_link_target.dart';
import 'package:play_with_me/core/services/deep_link_service.dart';

class AppLinksDeepLinkService implements DeepLinkService {
  final AppLinks _appLinks;
  final StreamController<String?> _tokenController =
      StreamController<String?>.broadcast();
  final StreamController<ActivityLinkTarget?> _activityLinkController =
      StreamController<ActivityLinkTarget?>.broadcast();
  StreamSubscription<Uri>? _linkSubscription;

  // Memoized so both getInitialInviteToken() and getInitialActivityLink()
  // read the same one-shot initial link without double-invoking the native
  // channel or racing each other.
  Future<Uri?>? _initialUriFuture;

  AppLinksDeepLinkService({AppLinks? appLinks})
    : _appLinks = appLinks ?? AppLinks() {
    debugPrint('[DeepLinkService] Service created, starting listener...');
    _listenForLinks();
  }

  void _listenForLinks() {
    debugPrint('[DeepLinkService] Subscribing to uriLinkStream...');
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        debugPrint('[DeepLinkService] Foreground link received: $uri');
        final token = _extractToken(uri);
        debugPrint('[DeepLinkService] Extracted token: $token');
        if (token != null) {
          _tokenController.add(token);
          return;
        }
        final target = _extractActivityLinkTarget(uri);
        debugPrint('[DeepLinkService] Extracted activity link target: $target');
        if (target != null) {
          _activityLinkController.add(target);
        }
      },
      onError: (error) {
        debugPrint('[DeepLinkService] Link stream error: $error');
      },
    );
  }

  @override
  Stream<String?> get inviteTokenStream => _tokenController.stream;

  @override
  Stream<ActivityLinkTarget?> get activityLinkStream =>
      _activityLinkController.stream;

  Future<Uri?> _getInitialUri() {
    return _initialUriFuture ??= _fetchInitialUri();
  }

  // Wrapped in its own async function (rather than .catchError()) so both
  // synchronous throws and asynchronous rejections from getInitialLink() are
  // caught the same way the original single-caller implementation did.
  Future<Uri?> _fetchInitialUri() async {
    try {
      return await _appLinks.getInitialLink();
    } catch (e) {
      debugPrint('[DeepLinkService] Failed to get initial link: $e');
      return null;
    }
  }

  @override
  Future<String?> getInitialInviteToken() async {
    final initialUri = await _getInitialUri();
    debugPrint('[DeepLinkService] Initial link: $initialUri');
    if (initialUri != null) {
      return _extractToken(initialUri);
    }
    return null;
  }

  @override
  Future<ActivityLinkTarget?> getInitialActivityLink() async {
    final initialUri = await _getInitialUri();
    if (initialUri != null) {
      return _extractActivityLinkTarget(initialUri);
    }
    return null;
  }

  String? _extractToken(Uri uri) {
    debugPrint('[DeepLinkService] Parsing URI: $uri');
    final segments = uri.pathSegments;

    // HTTPS: https://gatherli.org/invite/{token}
    //   host=gatherli.org, pathSegments=[invite, token]
    if (segments.length == 2 && segments[0] == 'invite') {
      final token = segments[1];
      if (token.isNotEmpty) return token;
    }

    // Custom scheme: gatherli://invite/{token}
    //   host=invite, pathSegments=[token]
    if (uri.scheme == 'gatherli' &&
        uri.host == 'invite' &&
        segments.length == 1) {
      final token = segments[0];
      if (token.isNotEmpty) return token;
    }

    debugPrint('[DeepLinkService] Could not extract token from URI');
    return null;
  }

  ActivityLinkTarget? _extractActivityLinkTarget(Uri uri) {
    final segments = uri.pathSegments;

    // HTTPS shapes:
    //   https://gatherli.org/game/{gameId}
    //   https://gatherli.org/training/{sessionId}
    //   https://gatherli.org/championship/{championshipId}/match/{matchId}
    if (segments.length == 2 && segments[0] == 'game' && segments[1].isNotEmpty) {
      return GameLinkTarget(segments[1]);
    }
    if (segments.length == 2 &&
        segments[0] == 'training' &&
        segments[1].isNotEmpty) {
      return TrainingSessionLinkTarget(segments[1]);
    }
    if (segments.length == 4 &&
        segments[0] == 'championship' &&
        segments[1].isNotEmpty &&
        segments[2] == 'match' &&
        segments[3].isNotEmpty) {
      return ChampionshipMatchLinkTarget(
        championshipId: segments[1],
        matchId: segments[3],
      );
    }

    // Custom scheme shapes:
    //   gatherli://game/{gameId}
    //   gatherli://training/{sessionId}
    //   gatherli://championship/{championshipId}/match/{matchId}
    if (uri.scheme == 'gatherli') {
      if (uri.host == 'game' && segments.length == 1 && segments[0].isNotEmpty) {
        return GameLinkTarget(segments[0]);
      }
      if (uri.host == 'training' &&
          segments.length == 1 &&
          segments[0].isNotEmpty) {
        return TrainingSessionLinkTarget(segments[0]);
      }
      if (uri.host == 'championship' &&
          segments.length == 3 &&
          segments[0].isNotEmpty &&
          segments[1] == 'match' &&
          segments[2].isNotEmpty) {
        return ChampionshipMatchLinkTarget(
          championshipId: segments[0],
          matchId: segments[2],
        );
      }
    }

    return null;
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    _tokenController.close();
    _activityLinkController.close();
  }
}
