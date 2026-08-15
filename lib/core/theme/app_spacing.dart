// Centralized spacing and radius constants.
// Change a value here to update every widget that uses it.
// Use these instead of raw numbers in EdgeInsets, SizedBox, BorderRadius, etc.
class AppSpacing {
  AppSpacing._();

  // ── Base scale ────────────────────────────────────────────────────────────
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 12;
  static const double lg  = 16;
  static const double xl  = 24;
  static const double xxl = 32;

  // ── Semantic spacing ──────────────────────────────────────────────────────
  /// Horizontal padding on pages (left/right margin of page content)
  static const double pagePadding = lg;

  /// Internal padding inside a card
  static const double cardPadding = lg;

  /// Vertical gap between major sections on a page
  static const double sectionGap = lg;

  /// Vertical gap between list items
  static const double itemGap = sm;

  /// Gap between two sibling widgets in a row/column
  static const double widgetGap = md;

  // ── Border radii ──────────────────────────────────────────────────────────
  /// Card and dialog corners (matches AppTheme.cardTheme)
  static const double cardRadius = 16;

  /// Input field corners (matches AppTheme.inputDecorationTheme)
  static const double inputRadius = 12;

  /// Small chip / button corners
  static const double chipRadius = 20;

  /// Status badge / pill corners
  static const double badgeRadius = 8;

  /// Circular elements (avatars, FABs) — just use CircleAvatar/CircleBorder
  static const double circleRadius = 22;
}
