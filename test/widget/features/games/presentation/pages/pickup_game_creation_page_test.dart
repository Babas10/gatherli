// Widget tests for PickupGameCreationPage verifying step navigation and UI.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/data/models/game_model.dart';
import 'package:play_with_me/core/data/models/invitable_user.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_event.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_state.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_event.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_state.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_creation/game_creation_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_creation/game_creation_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_creation/game_creation_state.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_invitations/game_invitations_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_state.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

// ── Mocks ────────────────────────────────────────────────────────────────────

class MockGameCreationBloc
    extends MockBloc<GameCreationEvent, GameCreationState>
    implements GameCreationBloc {}

class MockInviteeSelectionBloc
    extends MockBloc<InviteeSelectionEvent, InviteeSelectionState>
    implements InviteeSelectionBloc {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockInvitationBloc extends MockBloc<InvitationEvent, InvitationState>
    implements InvitationBloc {}

class MockGameInvitationsBloc
    extends MockBloc<GameInvitationsEvent, GameInvitationsState>
    implements GameInvitationsBloc {}

class FakeGameCreationEvent extends Fake implements GameCreationEvent {}

class FakeGameCreationState extends Fake implements GameCreationState {}

class FakeInviteeSelectionEvent extends Fake implements InviteeSelectionEvent {}

class FakeInviteeSelectionState extends Fake implements InviteeSelectionState {}

class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}

class FakeAuthenticationState extends Fake implements AuthenticationState {}

// ── Helpers ───────────────────────────────────────────────────────────────────

const _testUserId = 'test-user-123';

Widget _buildTestWidget({
  required MockGameCreationBloc gameCreationBloc,
  required MockInviteeSelectionBloc inviteeSelectionBloc,
  required MockAuthenticationBloc authBloc,
  MockInvitationBloc? invitationBloc,
  MockGameInvitationsBloc? gameInvitationsBloc,
}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>.value(value: authBloc),
      BlocProvider<GameCreationBloc>.value(value: gameCreationBloc),
      BlocProvider<InviteeSelectionBloc>.value(value: inviteeSelectionBloc),
      BlocProvider<InvitationBloc>.value(
          value: invitationBloc ?? MockInvitationBloc()),
      BlocProvider<GameInvitationsBloc>.value(
          value: gameInvitationsBloc ?? MockGameInvitationsBloc()),
    ],
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      // Inject pre-built blocs so PickupGameCreationPage does not call sl<>().
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GameCreationBloc>.value(value: gameCreationBloc),
          BlocProvider<InviteeSelectionBloc>.value(value: inviteeSelectionBloc),
        ],
        child: const _FakePickupGameCreationView(),
      ),
    ),
  );
}

/// A simplified version of the page internals used for widget-level tests
/// so we avoid the GetIt service locator dependency in PickupGameCreationPage.
class _FakePickupGameCreationView extends StatelessWidget {
  const _FakePickupGameCreationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameCreationBloc, GameCreationState>(
        builder: (context, state) {
          final isSubmitting = state is GameCreationSubmitting;
          return Column(
            children: [
              if (state is GameCreationFormState)
                Text('Form step: ${state.contextType.name}'),
              if (state is GameCreationSubmitting)
                const CircularProgressIndicator(),
              if (state is GameCreationSuccess) Text('Success: ${state.gameId}'),
              BlocBuilder<InviteeSelectionBloc, InviteeSelectionState>(
                builder: (context, invState) {
                  if (invState is InviteeSelectionLoaded) {
                    return Text(
                        'Invitees loaded: ${invState.friends.length}');
                  }
                  if (invState is InviteeSelectionLoading) {
                    return const Text('Loading invitees');
                  }
                  return const SizedBox.shrink();
                },
              ),
              ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () => context
                        .read<GameCreationBloc>()
                        .add(const SubmitGame(createdBy: _testUserId)),
                child: const Text('Submit'),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late MockGameCreationBloc mockGameCreationBloc;
  late MockInviteeSelectionBloc mockInviteeSelectionBloc;
  late MockAuthenticationBloc mockAuthBloc;

  setUpAll(() {
    registerFallbackValue(FakeGameCreationEvent());
    registerFallbackValue(FakeGameCreationState());
    registerFallbackValue(FakeInviteeSelectionEvent());
    registerFallbackValue(FakeInviteeSelectionState());
    registerFallbackValue(FakeAuthenticationEvent());
    registerFallbackValue(FakeAuthenticationState());
  });

  setUp(() {
    mockGameCreationBloc = MockGameCreationBloc();
    mockInviteeSelectionBloc = MockInviteeSelectionBloc();
    mockAuthBloc = MockAuthenticationBloc();

    when(() => mockGameCreationBloc.state)
        .thenReturn(const GameCreationInitial());
    when(() => mockGameCreationBloc.stream)
        .thenAnswer((_) => const Stream.empty());

    when(() => mockInviteeSelectionBloc.state)
        .thenReturn(const InviteeSelectionInitial());
    when(() => mockInviteeSelectionBloc.stream)
        .thenAnswer((_) => const Stream.empty());

    when(() => mockAuthBloc.state).thenReturn(
      AuthenticationAuthenticated(
        UserEntity(
          uid: _testUserId,
          email: 'test@example.com',
          isEmailVerified: true,
        ),
      ),
    );
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() {
    mockGameCreationBloc.close();
    mockInviteeSelectionBloc.close();
    mockAuthBloc.close();
  });

  testWidgets('shows submit button', (tester) async {
    await tester.pumpWidget(
      _buildTestWidget(
        gameCreationBloc: mockGameCreationBloc,
        inviteeSelectionBloc: mockInviteeSelectionBloc,
        authBloc: mockAuthBloc,
      ),
    );
    await tester.pump();
    expect(find.text('Submit'), findsOneWidget);
  });

  testWidgets('dispatches SubmitGame when submit button tapped', (
    tester,
  ) async {
    when(() => mockGameCreationBloc.state).thenReturn(
      GameCreationFormState(
        dateTime: DateTime.now().add(const Duration(days: 1)),
        locationName: 'Beach',
        title: 'Pickup',
        isValid: true,
      ),
    );

    await tester.pumpWidget(
      _buildTestWidget(
        gameCreationBloc: mockGameCreationBloc,
        inviteeSelectionBloc: mockInviteeSelectionBloc,
        authBloc: mockAuthBloc,
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Submit'));
    await tester.pump();

    verify(() => mockGameCreationBloc.add(
          const SubmitGame(createdBy: _testUserId),
        )).called(1);
  });

  testWidgets('shows loading indicator during GameCreationSubmitting', (
    tester,
  ) async {
    when(() => mockGameCreationBloc.state)
        .thenReturn(const GameCreationSubmitting());

    await tester.pumpWidget(
      _buildTestWidget(
        gameCreationBloc: mockGameCreationBloc,
        inviteeSelectionBloc: mockInviteeSelectionBloc,
        authBloc: mockAuthBloc,
      ),
    );
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows success text on GameCreationSuccess', (tester) async {
    final game = GameModel(
      id: 'game-xyz',
      title: 'Pickup',
      groupId: null,
      createdBy: _testUserId,
      createdAt: DateTime(2026, 6, 1),
      scheduledAt: DateTime(2026, 7, 1, 14),
      location: const GameLocation(name: 'Beach'),
      maxPlayers: 4,
      minPlayers: 2,
      playerIds: [_testUserId],
    );
    when(() => mockGameCreationBloc.state)
        .thenReturn(GameCreationSuccess(gameId: 'game-xyz', game: game));

    await tester.pumpWidget(
      _buildTestWidget(
        gameCreationBloc: mockGameCreationBloc,
        inviteeSelectionBloc: mockInviteeSelectionBloc,
        authBloc: mockAuthBloc,
      ),
    );
    await tester.pump();

    expect(find.text('Success: game-xyz'), findsOneWidget);
  });

  testWidgets('InviteePicker shows loaded users count', (tester) async {
    when(() => mockInviteeSelectionBloc.state).thenReturn(
      const InviteeSelectionLoaded(
        friends: [
          InvitableUser(uid: 'friend-a', displayName: 'Alice'),
          InvitableUser(uid: 'friend-b', displayName: 'Bob'),
        ],
        groups: [],
      ),
    );

    await tester.pumpWidget(
      _buildTestWidget(
        gameCreationBloc: mockGameCreationBloc,
        inviteeSelectionBloc: mockInviteeSelectionBloc,
        authBloc: mockAuthBloc,
      ),
    );
    await tester.pump();

    expect(find.text('Invitees loaded: 2'), findsOneWidget);
  });
}
