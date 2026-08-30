// BLoC for managing deep link state and pending invites.
import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/entities/activity_link_target.dart';
import 'package:play_with_me/core/presentation/bloc/base_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/deep_link/deep_link_event.dart';
import 'package:play_with_me/core/presentation/bloc/deep_link/deep_link_state.dart';
import 'package:play_with_me/core/services/deep_link_service.dart';
import 'package:play_with_me/core/services/deferred_deep_link/deferred_deep_link_orchestrator.dart';
import 'package:play_with_me/core/services/pending_activity_link_storage.dart';
import 'package:play_with_me/core/services/pending_invite_storage.dart';

class DeepLinkBloc extends BaseBloc<DeepLinkEvent, DeepLinkState> {
  final DeepLinkService _deepLinkService;
  final PendingInviteStorage _pendingInviteStorage;
  final PendingActivityLinkStorage _pendingActivityLinkStorage;
  final FirebaseAnalytics _analytics;
  final DeferredDeepLinkOrchestrator _deferredDeepLinkOrchestrator;

  DeepLinkBloc({
    required DeepLinkService deepLinkService,
    required PendingInviteStorage pendingInviteStorage,
    required PendingActivityLinkStorage pendingActivityLinkStorage,
    required FirebaseAnalytics analytics,
    required DeferredDeepLinkOrchestrator deferredDeepLinkOrchestrator,
  }) : _deepLinkService = deepLinkService,
       _pendingInviteStorage = pendingInviteStorage,
       _pendingActivityLinkStorage = pendingActivityLinkStorage,
       _analytics = analytics,
       _deferredDeepLinkOrchestrator = deferredDeepLinkOrchestrator,
       super(const DeepLinkInitial()) {
    on<InitializeDeepLinks>(_onInitialize);
    on<InviteTokenReceived>(_onInviteTokenReceived);
    on<ClearPendingInvite>(_onClearPendingInvite);
    on<ActivityLinkReceived>(_onActivityLinkReceived);
    on<ClearPendingActivityLink>(_onClearPendingActivityLink);
  }

  Future<void> _onInitialize(
    InitializeDeepLinks event,
    Emitter<DeepLinkState> emit,
  ) async {
    // Wait for the deferred deep link check (started, unawaited, before
    // runApp() in main_common.dart) to finish storing any recovered token
    // before reading storage below. ensureChecked() is single-flight, so
    // this does not re-run the platform check.
    await _deferredDeepLinkOrchestrator.ensureChecked();

    // Check for stored pending invite first (survives app restart during auth).
    // Invite takes priority over a pending activity link if both are
    // somehow present — a rare edge case (user tapped two different links
    // before ever logging in); the activity link is simply picked up on a
    // later cold start.
    final storedToken = await _pendingInviteStorage.retrieve();
    if (storedToken != null) {
      // Clear storage immediately — token now lives in BLoC state only.
      // This prevents stale tokens from re-triggering on every restart.
      await _pendingInviteStorage.clear();
      // Deferred deep link: user tapped the invite link before app was installed.
      await _analytics.logEvent(name: 'invite_link_tapped');
      emit(DeepLinkPendingInvite(token: storedToken));
      // Still start the foreground listener
      _startLinkListener();
      return;
    }

    // Check for stored pending activity link (survives app restart during auth).
    final storedActivityLink = await _pendingActivityLinkStorage.retrieve();
    if (storedActivityLink != null) {
      await _pendingActivityLinkStorage.clear();
      final target = ActivityLinkTarget.decode(storedActivityLink);
      if (target != null) {
        await _analytics.logEvent(name: 'activity_link_tapped');
        emit(DeepLinkPendingActivityLink(target: target));
        _startLinkListener();
        return;
      }
    }

    // Check for initial deep link (cold start).
    // Skip if already consumed (getInitialLink() persists across hot restarts).
    final initialToken = await _deepLinkService.getInitialInviteToken();
    if (initialToken != null &&
        !_pendingInviteStorage.isConsumed(initialToken)) {
      emit(DeepLinkPendingInvite(token: initialToken));
      _startLinkListener();
      return;
    }

    final initialTarget = await _deepLinkService.getInitialActivityLink();
    if (initialTarget != null &&
        !_pendingActivityLinkStorage.isConsumed(initialTarget.encode())) {
      emit(DeepLinkPendingActivityLink(target: initialTarget));
    } else {
      emit(const DeepLinkNoInvite());
    }

    _startLinkListener();
  }

  void _startLinkListener() {
    // Listen for foreground deep links
    trackSubscription(
      _deepLinkService.inviteTokenStream.listen((token) {
        if (token != null) {
          add(InviteTokenReceived(token));
        }
      }),
    );
    trackSubscription(
      _deepLinkService.activityLinkStream.listen((target) {
        if (target != null) {
          add(ActivityLinkReceived(target));
        }
      }),
    );
  }

  Future<void> _onInviteTokenReceived(
    InviteTokenReceived event,
    Emitter<DeepLinkState> emit,
  ) async {
    // Store token only for unauthenticated users who need to survive
    // the registration/login flow. The listeners in play_with_me_app.dart
    // will clear this after consuming the token.
    await _pendingInviteStorage.store(event.token);
    await _analytics.logEvent(name: 'invite_link_tapped');
    emit(DeepLinkPendingInvite(token: event.token));
  }

  Future<void> _onClearPendingInvite(
    ClearPendingInvite event,
    Emitter<DeepLinkState> emit,
  ) async {
    // Mark the current token as consumed before clearing,
    // so getInitialLink() won't re-trigger it on hot restart.
    final currentState = state;
    if (currentState is DeepLinkPendingInvite) {
      await _pendingInviteStorage.markConsumed(currentState.token);
    }
    await _pendingInviteStorage.clear();
    emit(const DeepLinkNoInvite());
  }

  Future<void> _onActivityLinkReceived(
    ActivityLinkReceived event,
    Emitter<DeepLinkState> emit,
  ) async {
    // Store only for unauthenticated users who need to survive the
    // registration/login flow. The listeners in play_with_me_app.dart
    // will clear this after consuming the target.
    await _pendingActivityLinkStorage.store(event.target.encode());
    await _analytics.logEvent(name: 'activity_link_tapped');
    emit(DeepLinkPendingActivityLink(target: event.target));
  }

  Future<void> _onClearPendingActivityLink(
    ClearPendingActivityLink event,
    Emitter<DeepLinkState> emit,
  ) async {
    // Mark the current target as consumed before clearing,
    // so getInitialActivityLink() won't re-trigger it on hot restart.
    final currentState = state;
    if (currentState is DeepLinkPendingActivityLink) {
      await _pendingActivityLinkStorage.markConsumed(
        currentState.target.encode(),
      );
    }
    await _pendingActivityLinkStorage.clear();
    emit(const DeepLinkNoInvite());
  }
}
