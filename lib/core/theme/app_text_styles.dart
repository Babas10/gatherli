// Centralized text styles for the app.
// Change a style here to update every widget that uses it.
// Use these instead of raw TextStyle(...) in widgets.
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ── Section labels ────────────────────────────────────────────────────────
  // The uppercase tracking label used above every section:
  // "PERFORMANCE OVERVIEW", "NEXT GAME", "ADAPTABILITY STATS", etc.
  static const sectionLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
    letterSpacing: 0.8,
  );

  // ── Stat display ──────────────────────────────────────────────────────────
  // Large number in a stat card (ELO, win rate, games played)
  static const statValue = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );

  // Small label above or below a stat value
  static const statCaption = TextStyle(
    fontSize: 12,
    color: AppColors.textMuted,
  );

  // ── Card / list typography ─────────────────────────────────────────────────
  // Primary title on a card or list item
  static const cardTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  // Secondary / subtitle text on a card
  static const cardSubtitle = TextStyle(
    fontSize: 13,
    color: AppColors.textMuted,
  );

  // ── Inline badge / chip ────────────────────────────────────────────────────
  // Text inside a status badge pill
  static const badgeLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  // ── Additional common styles ──────────────────────────────────────────────
  // Small caption / metadata (date, count, secondary info)
  static const caption = TextStyle(fontSize: 12, color: AppColors.textMuted);

  // Tiny label (e.g., below a stat value)
  static const tinyCaption = TextStyle(fontSize: 11, color: AppColors.textMuted);

  // Danger / error inline text
  static const danger = TextStyle(fontSize: 13, color: AppColors.danger);
}
