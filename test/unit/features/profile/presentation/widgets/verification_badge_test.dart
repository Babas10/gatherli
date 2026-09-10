// Verifies that VerificationBadge displays correct email verification status indicators

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/profile/presentation/widgets/verification_badge.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('en')],
    home: Scaffold(body: child),
  );
}

void main() {
  group('VerificationBadge', () {
    testWidgets('displays verified badge when email is verified', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(const VerificationBadge(isVerified: true)));

      expect(find.text('Verified'), findsOneWidget);
    });

    testWidgets('displays not verified badge when email is not verified', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(const VerificationBadge(isVerified: false)),
      );

      expect(find.text('Not Verified'), findsOneWidget);
    });

    testWidgets('uses success color for verified status', (tester) async {
      await tester.pumpWidget(_wrap(const VerificationBadge(isVerified: true)));

      final text = tester.widget<Text>(find.text('Verified'));
      expect(text.style?.color, AppColors.success);
    });

    testWidgets('uses danger color for unverified status', (tester) async {
      await tester.pumpWidget(
        _wrap(const VerificationBadge(isVerified: false)),
      );

      final text = tester.widget<Text>(find.text('Not Verified'));
      expect(text.style?.color, AppColors.danger);
    });
  });
}
