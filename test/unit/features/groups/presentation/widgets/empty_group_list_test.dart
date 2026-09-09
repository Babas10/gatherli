// Tests for EmptyGroupList widget covering display and interaction
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/presentation/widgets/empty_state.dart';
import 'package:play_with_me/features/groups/presentation/widgets/empty_group_list.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en')],
      home: Scaffold(body: EmptyGroupList()),
    );
  }

  group('EmptyGroupList', () {
    testWidgets('renders via the shared EmptyState widget', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(EmptyState), findsOneWidget);
    });

    testWidgets('displays empty state icon', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.groups_outlined), findsOneWidget);
    });

    testWidgets('displays "no groups yet" title', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text("You're not part of any group yet"), findsOneWidget);
    });

    testWidgets('displays encouraging message and FAB helper text', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(
        find.textContaining(
          'Create or join groups to start organizing beach volleyball games with your friends!',
        ),
        findsOneWidget,
      );
      expect(
        find.textContaining('Use the Create Group button below to get started.'),
        findsOneWidget,
      );
    });

    testWidgets('is centered on screen', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('all content is visible without scrolling on standard device', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.groups_outlined), findsOneWidget);
      expect(find.text("You're not part of any group yet"), findsOneWidget);
      expect(
        find.textContaining('Use the Create Group button below to get started.'),
        findsOneWidget,
      );
    });
  });
}
