// Shared page route transitions — consistent animation across all navigation.
// Use instead of MaterialPageRoute to standardize the feel of the app.
//
// Usage:
//   // Detail page — slides in from the right
//   Navigator.push(context, AppPageRoute.detail(builder: (_) => GameDetailsPage()));
//
//   // Modal page — slides up from the bottom
//   Navigator.push(context, AppPageRoute.modal(builder: (_) => CreateChampionshipPage()));
import 'package:flutter/material.dart';

class AppPageRoute<T> extends PageRouteBuilder<T> {
  AppPageRoute._detail({required WidgetBuilder builder, super.settings})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide in from right — standard detail page transition
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: Curves.easeOutCubic));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 280),
        );

  AppPageRoute._modal({required WidgetBuilder builder, super.settings})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide up — for modal/creation pages
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: Curves.easeOutCubic));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 320),
        );

  /// Detail page: slides in from the right (standard push navigation).
  static AppPageRoute<T> detail<T>({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) =>
      AppPageRoute<T>._detail(builder: builder, settings: settings);

  /// Modal page: slides up from the bottom (creation, settings, forms).
  static AppPageRoute<T> modal<T>({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) =>
      AppPageRoute<T>._modal(builder: builder, settings: settings);
}
