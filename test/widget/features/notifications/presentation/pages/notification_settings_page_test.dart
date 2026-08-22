// Widget tests for NotificationSettingsPage — 4-category UI (Story N.3)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_state.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_state.dart';
import 'package:play_with_me/features/notifications/domain/entities/notification_preferences_entity.dart';
import 'package:play_with_me/features/notifications/domain/repositories/notification_repository.dart';
import 'package:play_with_me/features/notifications/presentation/pages/notification_settings_page.dart';
import '../../../../../helpers/test_app.dart';

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

class MockInvitationBloc extends Mock implements InvitationBloc {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class FakeNotificationPreferencesEntity extends Fake
    implements NotificationPreferencesEntity {}

void main() {
  late MockNotificationRepository mockRepository;
  late MockInvitationBloc mockInvitationBloc;
  late MockAuthenticationBloc mockAuthBloc;

  setUpAll(() {
    registerFallbackValue(FakeNotificationPreferencesEntity());
  });

  setUp(() {
    mockRepository = MockNotificationRepository();
    mockInvitationBloc = MockInvitationBloc();
    mockAuthBloc = MockAuthenticationBloc();
    when(() => mockInvitationBloc.state).thenReturn(const InvitationInitial());
    when(() => mockInvitationBloc.stream)
        .thenAnswer((_) => const Stream.empty());
    when(() => mockAuthBloc.state).thenReturn(
      const AuthenticationAuthenticated(
        UserEntity(
          uid: 'test-user',
          email: 'test@example.com',
          isEmailVerified: true,
        ),
      ),
    );
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

    final getIt = GetIt.instance;
    if (getIt.isRegistered<NotificationRepository>()) {
      getIt.unregister<NotificationRepository>();
    }
    getIt.registerSingleton<NotificationRepository>(mockRepository);

    when(() => mockRepository.getPreferences())
        .thenAnswer((_) async => const NotificationPreferencesEntity());
    when(() => mockRepository.preferencesStream())
        .thenAnswer((_) => Stream.value(const NotificationPreferencesEntity()));
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Widget createWidgetUnderTest() {
    return testApp(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InvitationBloc>.value(value: mockInvitationBloc),
          BlocProvider<AuthenticationBloc>.value(value: mockAuthBloc),
        ],
        child: const NotificationSettingsPage(),
      ),
    );
  }

  group('NotificationSettingsPage - Basic Rendering', () {
    testWidgets('displays app bar with title', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('initially shows loading indicator', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('loads and displays 4 category toggles', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(find.text('Social'), findsOneWidget);
      expect(find.text('Games'), findsOneWidget);
      expect(find.text('Training'), findsOneWidget);
      expect(find.text('Leagues'), findsOneWidget);
    });
  });

  group('NotificationSettingsPage - Category Toggles', () {
    testWidgets('displays all 4 category switches', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(find.byType(SwitchListTile), findsWidgets);
      expect(find.text('Social'), findsOneWidget);
      expect(find.text('Games'), findsOneWidget);
      expect(find.text('Training'), findsOneWidget);
      expect(find.text('Leagues'), findsOneWidget);
    });

    testWidgets('displays category subtitles', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(
        find.text('Friend requests, group invitations'),
        findsOneWidget,
      );
      expect(
        find.text('New games, results, cancellations, chat'),
        findsOneWidget,
      );
    });

    testWidgets('quiet hours toggle is visible after scroll', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump();
      await tester.pump();

      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      expect(find.text('Enable Quiet Hours'), findsOneWidget);
    });
  });

  group('NotificationSettingsPage - Error Handling', () {
    testWidgets('displays error icon and retry button when loading fails',
        (tester) async {
      when(() => mockRepository.getPreferences())
          .thenThrow(Exception('Failed to load'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('retry button reloads preferences', (tester) async {
      when(() => mockRepository.getPreferences())
          .thenThrow(Exception('Failed'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump();
      await tester.pump();

      when(() => mockRepository.getPreferences())
          .thenAnswer((_) async => const NotificationPreferencesEntity());

      await tester.tap(find.text('Retry'));
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(find.text('Social'), findsOneWidget);
    });
  });

  group('NotificationSettingsPage - Quiet Hours', () {
    testWidgets('shows subtitle when quiet hours disabled', (tester) async {
      when(() => mockRepository.getPreferences()).thenAnswer(
        (_) async =>
            const NotificationPreferencesEntity(quietHoursEnabled: false),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump();
      await tester.pump();

      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      expect(
        find.text('Pause notifications during specific times'),
        findsOneWidget,
      );
      expect(find.text('Adjust Quiet Hours'), findsNothing);
    });

    testWidgets('shows time range when quiet hours enabled', (tester) async {
      when(() => mockRepository.getPreferences()).thenAnswer(
        (_) async => const NotificationPreferencesEntity(
          quietHoursEnabled: true,
          quietHoursStart: '22:00',
          quietHoursEnd: '08:00',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump();
      await tester.pump();

      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      expect(
        find.text('No notifications from 22:00 to 08:00'),
        findsOneWidget,
      );
      expect(find.text('Adjust Quiet Hours'), findsOneWidget);
    });
  });

  group('NotificationSettingsPage - Category Switch Values', () {
    testWidgets('social toggle reflects preference value', (tester) async {
      when(() => mockRepository.getPreferences()).thenAnswer(
        (_) async => const NotificationPreferencesEntity(social: false),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump();
      await tester.pump();

      final socialSwitch = tester.widget<SwitchListTile>(
        find.ancestor(
          of: find.text('Social'),
          matching: find.byType(SwitchListTile),
        ),
      );
      expect(socialSwitch.value, false);
    });
  });

  group('NotificationSettingsPage - Update Operations', () {
    testWidgets('updates repository when Social switch is toggled',
        (tester) async {
      when(() => mockRepository.getPreferences()).thenAnswer(
        (_) async => const NotificationPreferencesEntity(social: false),
      );
      when(() => mockRepository.updatePreferences(any()))
          .thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump();
      await tester.pump();

      await tester.tap(
        find.ancestor(
          of: find.text('Social'),
          matching: find.byType(SwitchListTile),
        ),
      );
      await tester.pump();

      verify(() => mockRepository.updatePreferences(any())).called(1);
    });
  });
}
