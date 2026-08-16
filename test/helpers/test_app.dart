// Shared widget test wrapper — eliminates localization delegate boilerplate.
//
// Usage:
//   await tester.pumpWidget(testApp(child: MyWidget()));
//   await tester.pumpWidget(testApp(
//     child: BlocProvider.value(value: bloc, child: MyWidget()),
//   ));

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

/// Wraps [child] in a fully localised [MaterialApp] suitable for widget tests.
///
/// Pass [navigatorObserver] to capture navigation events.
/// Pass [onGenerateRoute] when the widget under test triggers named navigation.
Widget testApp({
  required Widget child,
  NavigatorObserver? navigatorObserver,
  Route<dynamic>? Function(RouteSettings)? onGenerateRoute,
  ThemeData? theme,
  String? title,
}) {
  return MaterialApp(
    title: title ?? 'Test',
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('en')],
    navigatorObservers: navigatorObserver != null ? [navigatorObserver] : [],
    onGenerateRoute: onGenerateRoute,
    theme: theme,
    home: child,
  );
}
