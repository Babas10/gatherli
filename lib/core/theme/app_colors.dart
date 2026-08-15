// Centralized color constants for consistent theming across the app.
// ALL colors used anywhere in the app must be defined here.
// Never use hardcoded Color(0xFF...) or Colors.green/red/etc. directly in widgets.
import "package:flutter/material.dart";

class AppColors {
  AppColors._();

  // Component backgrounds
  static const appBarBackground    = Color(0xFFFAFAF8);
  static const scaffoldBackground  = Color(0xFFE8ECF1);
  static const bottomNavBackground = Color(0xFFFAFAF8);
  static const cardBackground      = Color(0xFFFAFAF8);

  // Brand colors
  static const primary   = Color(0xFFEACE6A); // gold
  static const secondary = Color(0xFF004E64); // teal
  static const danger    = Color(0xFFEF476F); // red

  // Semantic / status colors
  // Use these everywhere instead of Colors.green / Colors.orange / Colors.blue etc.
  static const success = Color(0xFF27AE60); // wins, verified, confirmed, accepted
  static const warning = Color(0xFFE67E22); // pending, scheduled, waitlist
  static const info    = Color(0xFF3498DB); // informational, in-progress

  // Avatar — all user and group circles use the same palette
  static const avatarBackground = Color(0x40EACE6A); // primary at 25% opacity
  static const avatarForeground = secondary;

  // Text colors
  static const onSurface     = Color(0xFF1A2C32);
  static const textMuted     = Color(0xFF64748B);
  static const navLabelColor = Color(0xFF94A3B8);

  // Borders and surfaces
  static const divider = Color(0xFFE2E8F0);
  static const shadow  = Color(0x14004E64);
}
