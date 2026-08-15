// Centralized theme configuration for Gatherli.
//
// All visual defaults are defined here so individual pages never need to
// override colors, backgrounds, or component styles manually.
// Reference in MaterialApp via: theme: AppTheme.light
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      // ── Color scheme ─────────────────────────────────────────────────────────
      // Override all M3 generated surface tints so they are neutral white/grey
      // instead of the seed-derived cream/blue tints.
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ).copyWith(
        primary: AppColors.primary,
        onPrimary: AppColors.secondary,
        primaryContainer: AppColors.scaffoldBackground,
        onPrimaryContainer: AppColors.onSurface,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        error: AppColors.danger,
        onError: Colors.white,
        // Dialogs and cards explicitly use Colors.white (set in their themes).
        // Surface stays white so M3 components don't show cream tints.
        surface: AppColors.cardBackground,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.textMuted,
        // Container variants use scaffold grey so inner sections retain depth.
        // dialogTheme.backgroundColor overrides to white for dialogs.
        surfaceContainerLowest: AppColors.scaffoldBackground,
        surfaceContainerLow: AppColors.scaffoldBackground,
        surfaceContainer: AppColors.scaffoldBackground,
        surfaceContainerHigh: AppColors.scaffoldBackground,
        surfaceContainerHighest: AppColors.scaffoldBackground,
        // Disable the M3 tint overlay applied on top of surfaces
        surfaceTint: Colors.transparent,
        outline: AppColors.divider,
        outlineVariant: AppColors.divider,
      ),

      // ── Scaffold ─────────────────────────────────────────────────────────────
      scaffoldBackgroundColor: AppColors.scaffoldBackground,

      // ── Text theme ────────────────────────────────────────────────────────────
      // Named styles used via Theme.of(context).textTheme.*
      // Change here to update the whole app's typography.
      textTheme: const TextTheme(
        // Large display numbers (e.g. ELO on stats page)
        displaySmall: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: AppColors.onSurface),
        // Page / section heading
        headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.onSurface),
        // Card / dialog title
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.onSurface),
        titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.onSurface),
        titleSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.onSurface),
        // Body content
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.onSurface),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.onSurface),
        bodySmall: TextStyle(fontSize: 12, color: AppColors.textMuted),
        // Labels (buttons, chips, tabs)
        labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.onSurface),
        labelMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.onSurface),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted),
      ),

      // ── AppBar ───────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.appBarBackground,
        foregroundColor: AppColors.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: AppColors.secondary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: AppColors.secondary),
        actionsIconTheme: const IconThemeData(color: AppColors.secondary),
      ),

      // ── Cards ─────────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        elevation: 1,
        color: AppColors.cardBackground,
        shadowColor: AppColors.shadow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
      ),

      // ── Dialogs ──────────────────────────────────────────────────────────────
      // This single entry fixes all AlertDialog / SimpleDialog / Dialog widgets
      // across the entire app — no per-dialog backgroundColor needed.
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.cardBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        titleTextStyle: const TextStyle(
          color: AppColors.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: TextStyle(
          color: AppColors.textMuted,
          fontSize: 14,
          height: 1.5,
        ),
      ),

      // ── Bottom sheets ─────────────────────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.cardBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.bottomNavBackground,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.shadow,
        elevation: 8,
        height: 64,
        indicatorColor: AppColors.primary.withValues(alpha: 0.15),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.secondary, size: 24);
          }
          return const IconThemeData(
            color: AppColors.navLabelColor,
            size: 24,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            );
          }
          return const TextStyle(
            color: AppColors.navLabelColor,
            fontSize: 11,
          );
        }),
      ),

      // ── Tab Bar ───────────────────────────────────────────────────────────────
      // Tab bar — change indicator/label colors here to update ALL tabs at once.
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.navLabelColor,
        unselectedLabelColor: AppColors.navLabelColor,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: AppColors.divider,
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),

      // ── Filled buttons (primary CTA) ──────────────────────────────────────────
      // TO CHANGE ALL PRIMARY BUTTONS: update backgroundColor here → propagates everywhere.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          disabledBackgroundColor: AppColors.divider,
          disabledForegroundColor: AppColors.textMuted,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),

      // ── Elevated buttons ──────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),

      // ── Outlined buttons ──────────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.secondary,
          side: const BorderSide(color: AppColors.secondary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),

      // ── Text buttons ──────────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // ── Floating Action Button ────────────────────────────────────────────────
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
        highlightElevation: 6,
      ),

      // ── Chips (ChoiceChip, FilterChip) ────────────────────────────────────────
      // Fixes Stats page time period pills and any other chip in the app.
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.scaffoldBackground,
        selectedColor: AppColors.primary,
        disabledColor: AppColors.divider,
        surfaceTintColor: Colors.transparent,
        checkmarkColor: AppColors.secondary,
        showCheckmark: false,
        labelStyle: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
        secondaryLabelStyle: const TextStyle(
          color: AppColors.secondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
          side: const BorderSide(color: AppColors.divider),
        ),
        elevation: 0,
        pressElevation: 0,
      ),

      // ── Input decoration (text fields) ────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(color: AppColors.secondary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(color: AppColors.danger, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.textMuted),
        hintStyle: const TextStyle(color: AppColors.textMuted),
        prefixIconColor: AppColors.secondary,
        suffixIconColor: AppColors.textMuted,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      // ── Switch (notification toggles) ─────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return AppColors.textMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.divider;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // ── List tiles ────────────────────────────────────────────────────────────
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: Colors.transparent,
        iconColor: AppColors.secondary,
        textColor: AppColors.onSurface,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      ),

      // ── Divider ───────────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ── Snack bars ────────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.onSurface,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.inputRadius)),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),

      // ── Progress indicator ────────────────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.secondary,
      ),

      // ── Icon theme ────────────────────────────────────────────────────────────
      iconTheme: const IconThemeData(color: AppColors.secondary, size: 24),
    );
  }
}
