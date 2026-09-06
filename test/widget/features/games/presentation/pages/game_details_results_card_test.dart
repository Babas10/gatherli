// Regression test for the Game Results card's quick-score row: must not
// overflow horizontally when combined team names are longer than a single
// short word (issue #935).
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/data/models/chat_message_model.dart';
import 'package:play_with_me/core/data/models/game_model.dart';
import 'package:play_with_me/core/data/models/user_model.dart';
import 'package:play_with_me/core/domain/repositories/game_repository.dart';
import 'package:play_with_me/core/domain/repositories/invitation_repository.dart';
import 'package:play_with_me/core/domain/repositories/message_repository.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_event.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_state.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_event.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_state.dart';
import 'package:play_with_me/features/games/presentation/pages/game_details_page.dart';

import '../../../../../unit/core/data/repositories/mock_game_repository.dart';
import '../../../../../unit/core/data/repositories/mock_user_repository.dart';
import '../../../../../helpers/test_app.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockInvitationBloc extends MockBloc<InvitationEvent, InvitationState>
    implements InvitationBloc {}

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

class MockInvitationRepository extends Mock implements InvitationRepository {}

class _FakeMessageRepository implements MessageRepository {
  @override
  Stream<List<ChatMessageModel>> getMessages({required String contextPath}) =>
      Stream.value([]);

  @override
  Future<void> sendMessage({
    required String contextPath,
    required String senderId,
    required String senderDisplayName,
    required String text,
    String? teamId,
  }) async {}
}

void main() {
  late MockGameRepository mockGameRepository;
  late MockUserRepository mockUserRepository;
  late MockAuthenticationBloc mockAuthBloc;
  late MockInvitationBloc mockInvitationBloc;
  late MockFirebaseAnalytics mockAnalytics;
  final sl = GetIt.instance;

  const playerAId = 'player-a1';
  const playerBId = 'player-a2';
  const playerCId = 'player-b1';
  const playerDId = 'player-b2';

  final completedGame = TestGameData.testGame.copyWith(
    id: 'completed-game-1',
    status: GameStatus.completed,
    playerIds: [playerAId, playerBId, playerCId, playerDId],
    teams: const GameTeams(
      teamAPlayerIds: [playerAId, playerBId],
      teamBPlayerIds: [playerCId, playerDId],
    ),
    result: const GameResult(games: [], overallWinner: 'teamA'),
  );

  setUp(() {
    mockGameRepository = MockGameRepository();
    mockUserRepository = MockUserRepository();
    mockAuthBloc = MockAuthenticationBloc();
    mockInvitationBloc = MockInvitationBloc();
    mockAnalytics = MockFirebaseAnalytics();
    when(
      () => mockAnalytics.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockInvitationBloc.state).thenReturn(const InvitationInitial());

    // Long, realistic two-word display names on both teams — previously
    // overflowed the quick-score Row by ~93px (issue #935).
    mockUserRepository.addUser(
      const UserModel(uid: playerAId, email: 'a1@test.com', displayName: 'Alexandra Wellington'),
    );
    mockUserRepository.addUser(
      const UserModel(uid: playerBId, email: 'a2@test.com', displayName: 'Bartholomew Jenkins'),
    );
    mockUserRepository.addUser(
      const UserModel(uid: playerCId, email: 'b1@test.com', displayName: 'Christopher Montgomery'),
    );
    mockUserRepository.addUser(
      const UserModel(uid: playerDId, email: 'b2@test.com', displayName: 'Dominique Fitzgerald'),
    );

    if (sl.isRegistered<GameRepository>()) {
      sl.unregister<GameRepository>();
    }
    sl.registerSingleton<GameRepository>(mockGameRepository);

    if (sl.isRegistered<FirebaseAnalytics>()) {
      sl.unregister<FirebaseAnalytics>();
    }
    sl.registerSingleton<FirebaseAnalytics>(mockAnalytics);

    if (sl.isRegistered<InvitationRepository>()) {
      sl.unregister<InvitationRepository>();
    }
    sl.registerSingleton<InvitationRepository>(MockInvitationRepository());

    if (sl.isRegistered<MessageRepository>()) {
      sl.unregister<MessageRepository>();
    }
    sl.registerSingleton<MessageRepository>(_FakeMessageRepository());
  });

  tearDown(() {
    sl.reset();
  });

  Widget createWidgetUnderTest() {
    return testApp(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>.value(value: mockAuthBloc),
          BlocProvider<InvitationBloc>.value(value: mockInvitationBloc),
        ],
        child: GameDetailsPage(
          gameId: completedGame.id,
          gameRepository: mockGameRepository,
          userRepository: mockUserRepository,
        ),
      ),
    );
  }

  testWidgets(
    'Game Results card does not overflow with long combined team names',
    (tester) async {
      mockGameRepository.addGame(completedGame);
      when(() => mockAuthBloc.state).thenReturn(
        const AuthenticationAuthenticated(
          UserEntity(uid: playerAId, email: '', isEmailVerified: true),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Game Results'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
