// Centralized elevation constants for widgets that intentionally deviate
// from the Card theme default (see AppTheme.cardTheme). Use these instead of
// a raw `elevation: N` literal so the same visual tier stays consistent
// across every card in the app.
class AppElevation {
  AppElevation._();

  /// No shadow — used on cards drawn against a tinted/colored background
  /// (empty states, secondary/inline summary cards) where a shadow would
  /// look out of place.
  static const double flat = 0;

  /// Standard card elevation — matches AppTheme.cardTheme's default. Only
  /// needed when a widget must restate the default explicitly (e.g. next to
  /// a sibling that overrides it).
  static const double raised = 1;

  /// Slightly lifted — used for highlight/stat cards that should read as
  /// more prominent than a standard list card.
  static const double prominent = 2;
}
