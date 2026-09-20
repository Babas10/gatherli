// Centralized animation-duration and curve constants.
// Use these instead of raw Duration(milliseconds: N) literals for
// implicit animations / small UI transitions (not network timeouts,
// cache TTLs, or debounces — those stay local to their own domain).
import 'package:flutter/animation.dart';

class AppDurations {
  AppDurations._();

  /// Fast tap/selection feedback (e.g. chip/tab highlight).
  static const Duration fast = Duration(milliseconds: 150);

  /// Standard implicit animation — scroll-to-item, small fades/expansions.
  static const Duration medium = Duration(milliseconds: 200);

  /// Larger transitions within a page (e.g. section expand/collapse).
  static const Duration slow = Duration(milliseconds: 300);
}

class AppCurves {
  AppCurves._();

  /// Default curve for the durations above.
  static const Curve standard = Curves.easeOut;
}
