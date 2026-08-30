// Validates DeepLinkBloc emits correct states during initialization, token/activity-link reception, and clearing.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/domain/entities/activity_link_target.dart';
import 'package:play_with_me/core/presentation/bloc/deep_link/deep_link_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/deep_link/deep_link_event.dart';
import 'package:play_with_me/core/presentation/bloc/deep_link/deep_link_state.dart';
import 'package:play_with_me/core/services/deep_link_service.dart';
import '../../../../../helpers/mocks.dart';

class MockDeepLinkService extends Mock implements DeepLinkService {}

void main() {
  late MockDeepLinkService mockDeepLinkService;
  late MockPendingInviteStorage mockStorage;
  late MockPendingActivityLinkStorage mockActivityStorage;
  late MockFirebaseAnalytics mockAnalytics;
  late MockDeferredDeepLinkOrchestrator mockOrchestrator;

  setUp(() {
    mockDeepLinkService = MockDeepLinkService();
    mockStorage = MockPendingInviteStorage();
    mockActivityStorage = MockPendingActivityLinkStorage();
    mockAnalytics = MockFirebaseAnalytics();
    mockOrchestrator = MockDeferredDeepLinkOrchestrator();
    when(
      () => mockAnalytics.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockOrchestrator.ensureChecked()).thenAnswer((_) async => null);
    // Default baseline: no pending/initial activity link, empty foreground
    // stream — overridden per-test where activity-link behavior is exercised.
    when(() => mockActivityStorage.retrieve()).thenAnswer((_) async => null);
    when(
      () => mockDeepLinkService.getInitialActivityLink(),
    ).thenAnswer((_) async => null);
    when(
      () => mockDeepLinkService.activityLinkStream,
    ).thenAnswer((_) => const Stream.empty());
  });

  DeepLinkBloc buildBloc() {
    return DeepLinkBloc(
      deepLinkService: mockDeepLinkService,
      pendingInviteStorage: mockStorage,
      pendingActivityLinkStorage: mockActivityStorage,
      analytics: mockAnalytics,
      deferredDeepLinkOrchestrator: mockOrchestrator,
    );
  }

  group('DeepLinkBloc', () {
    test('initial state is DeepLinkInitial', () {
      when(
        () => mockDeepLinkService.inviteTokenStream,
      ).thenAnswer((_) => const Stream.empty());
      final bloc = buildBloc();
      expect(bloc.state, const DeepLinkInitial());
      bloc.close();
    });

    group('InitializeDeepLinks', () {
      blocTest<DeepLinkBloc, DeepLinkState>(
        'emits [DeepLinkPendingInvite] when stored token exists',
        setUp: () {
          when(
            () => mockStorage.retrieve(),
          ).thenAnswer((_) async => 'stored-token');
          when(() => mockStorage.clear()).thenAnswer((_) async {});
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const InitializeDeepLinks()),
        expect: () => [const DeepLinkPendingInvite(token: 'stored-token')],
        verify: (_) {
          verify(() => mockOrchestrator.ensureChecked()).called(1);
          verify(() => mockStorage.retrieve()).called(1);
          verifyNever(() => mockDeepLinkService.getInitialInviteToken());
          verify(
            () => mockAnalytics.logEvent(name: 'invite_link_tapped'),
          ).called(1);
        },
      );

      blocTest<DeepLinkBloc, DeepLinkState>(
        'awaits ensureChecked() before reading PendingInviteStorage, so a '
        'deferred deep link token is not missed on cold start',
        setUp: () {
          final callOrder = <String>[];
          when(() => mockOrchestrator.ensureChecked()).thenAnswer((_) async {
            callOrder.add('ensureChecked');
            // Simulate the platform check still being in flight.
            await Future<void>.delayed(const Duration(milliseconds: 10));
            return null;
          });
          when(() => mockStorage.retrieve()).thenAnswer((_) async {
            callOrder.add('retrieve');
            return 'stored-token';
          });
          when(() => mockStorage.clear()).thenAnswer((_) async {});
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
          addTearDown(() {
            expect(callOrder, ['ensureChecked', 'retrieve']);
          });
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const InitializeDeepLinks()),
        wait: const Duration(milliseconds: 50),
        expect: () => [const DeepLinkPendingInvite(token: 'stored-token')],
      );

      blocTest<DeepLinkBloc, DeepLinkState>(
        'emits [DeepLinkPendingInvite] when initial deep link token exists',
        setUp: () {
          when(() => mockStorage.retrieve()).thenAnswer((_) async => null);
          when(
            () => mockDeepLinkService.getInitialInviteToken(),
          ).thenAnswer((_) async => 'initial-token');
          when(() => mockStorage.isConsumed('initial-token')).thenReturn(false);
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const InitializeDeepLinks()),
        expect: () => [const DeepLinkPendingInvite(token: 'initial-token')],
      );

      blocTest<DeepLinkBloc, DeepLinkState>(
        'emits [DeepLinkNoInvite] when no stored or initial token exists',
        setUp: () {
          when(() => mockStorage.retrieve()).thenAnswer((_) async => null);
          when(
            () => mockDeepLinkService.getInitialInviteToken(),
          ).thenAnswer((_) async => null);
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const InitializeDeepLinks()),
        expect: () => [const DeepLinkNoInvite()],
      );

      blocTest<DeepLinkBloc, DeepLinkState>(
        'listens to foreground token stream after initialization',
        setUp: () {
          when(() => mockStorage.retrieve()).thenAnswer((_) async => null);
          when(
            () => mockDeepLinkService.getInitialInviteToken(),
          ).thenAnswer((_) async => null);
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => Stream.value('stream-token'));
          when(
            () => mockStorage.store('stream-token'),
          ).thenAnswer((_) async {});
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const InitializeDeepLinks()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          const DeepLinkNoInvite(),
          const DeepLinkPendingInvite(token: 'stream-token'),
        ],
      );
    });

    group('InviteTokenReceived', () {
      blocTest<DeepLinkBloc, DeepLinkState>(
        'emits [DeepLinkPendingInvite] and stores token',
        setUp: () {
          when(() => mockStorage.store('new-token')).thenAnswer((_) async {});
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const InviteTokenReceived('new-token')),
        expect: () => [const DeepLinkPendingInvite(token: 'new-token')],
        verify: (_) {
          verify(() => mockStorage.store('new-token')).called(1);
          verify(
            () => mockAnalytics.logEvent(name: 'invite_link_tapped'),
          ).called(1);
        },
      );
    });

    group('ClearPendingInvite', () {
      blocTest<DeepLinkBloc, DeepLinkState>(
        'emits [DeepLinkNoInvite] and clears storage',
        setUp: () {
          when(() => mockStorage.clear()).thenAnswer((_) async {});
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const ClearPendingInvite()),
        expect: () => [const DeepLinkNoInvite()],
        verify: (_) {
          verify(() => mockStorage.clear()).called(1);
        },
      );
    });

    group('InitializeDeepLinks — activity links', () {
      blocTest<DeepLinkBloc, DeepLinkState>(
        'emits [DeepLinkPendingActivityLink] when stored activity link exists',
        setUp: () {
          when(() => mockStorage.retrieve()).thenAnswer((_) async => null);
          when(
            () => mockActivityStorage.retrieve(),
          ).thenAnswer((_) async => 'game:game-123');
          when(() => mockActivityStorage.clear()).thenAnswer((_) async {});
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const InitializeDeepLinks()),
        expect: () => [
          const DeepLinkPendingActivityLink(target: GameLinkTarget('game-123')),
        ],
        verify: (_) {
          verify(() => mockActivityStorage.retrieve()).called(1);
          verifyNever(() => mockDeepLinkService.getInitialActivityLink());
          verify(
            () => mockAnalytics.logEvent(name: 'activity_link_tapped'),
          ).called(1);
        },
      );

      blocTest<DeepLinkBloc, DeepLinkState>(
        'emits [DeepLinkPendingActivityLink] when initial activity link exists',
        setUp: () {
          when(() => mockStorage.retrieve()).thenAnswer((_) async => null);
          when(
            () => mockDeepLinkService.getInitialInviteToken(),
          ).thenAnswer((_) async => null);
          when(
            () => mockDeepLinkService.getInitialActivityLink(),
          ).thenAnswer((_) async => const TrainingSessionLinkTarget('t-1'));
          when(
            () => mockActivityStorage.isConsumed('training:t-1'),
          ).thenReturn(false);
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const InitializeDeepLinks()),
        expect: () => [
          const DeepLinkPendingActivityLink(
            target: TrainingSessionLinkTarget('t-1'),
          ),
        ],
      );

      blocTest<DeepLinkBloc, DeepLinkState>(
        'invite token takes priority over a pending activity link at cold start',
        setUp: () {
          when(
            () => mockStorage.retrieve(),
          ).thenAnswer((_) async => 'stored-token');
          when(() => mockStorage.clear()).thenAnswer((_) async {});
          when(
            () => mockActivityStorage.retrieve(),
          ).thenAnswer((_) async => 'game:game-123');
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const InitializeDeepLinks()),
        expect: () => [const DeepLinkPendingInvite(token: 'stored-token')],
        verify: (_) {
          verifyNever(() => mockActivityStorage.retrieve());
        },
      );

      blocTest<DeepLinkBloc, DeepLinkState>(
        'listens to foreground activity link stream after initialization',
        setUp: () {
          when(() => mockStorage.retrieve()).thenAnswer((_) async => null);
          when(
            () => mockDeepLinkService.getInitialInviteToken(),
          ).thenAnswer((_) async => null);
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
          when(
            () => mockDeepLinkService.activityLinkStream,
          ).thenAnswer((_) => Stream.value(const GameLinkTarget('stream-game')));
          when(
            () => mockActivityStorage.store('game:stream-game'),
          ).thenAnswer((_) async {});
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const InitializeDeepLinks()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          const DeepLinkNoInvite(),
          const DeepLinkPendingActivityLink(target: GameLinkTarget('stream-game')),
        ],
      );
    });

    group('ActivityLinkReceived', () {
      blocTest<DeepLinkBloc, DeepLinkState>(
        'emits [DeepLinkPendingActivityLink] and stores encoded target',
        setUp: () {
          when(
            () => mockActivityStorage.store('championshipMatch:c-1:m-1'),
          ).thenAnswer((_) async {});
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(
          const ActivityLinkReceived(
            ChampionshipMatchLinkTarget(championshipId: 'c-1', matchId: 'm-1'),
          ),
        ),
        expect: () => [
          const DeepLinkPendingActivityLink(
            target: ChampionshipMatchLinkTarget(
              championshipId: 'c-1',
              matchId: 'm-1',
            ),
          ),
        ],
        verify: (_) {
          verify(
            () => mockActivityStorage.store('championshipMatch:c-1:m-1'),
          ).called(1);
          verify(
            () => mockAnalytics.logEvent(name: 'activity_link_tapped'),
          ).called(1);
        },
      );
    });

    group('ClearPendingActivityLink', () {
      blocTest<DeepLinkBloc, DeepLinkState>(
        'emits [DeepLinkNoInvite] and clears storage',
        setUp: () {
          when(() => mockActivityStorage.clear()).thenAnswer((_) async {});
          when(
            () => mockDeepLinkService.inviteTokenStream,
          ).thenAnswer((_) => const Stream.empty());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const ClearPendingActivityLink()),
        expect: () => [const DeepLinkNoInvite()],
        verify: (_) {
          verify(() => mockActivityStorage.clear()).called(1);
        },
      );
    });
  });
}
