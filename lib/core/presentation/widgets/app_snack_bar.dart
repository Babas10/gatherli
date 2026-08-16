// Shared SnackBar helpers — consistent styling for all feedback messages.
// Use these instead of constructing SnackBar inline in BLoC listeners.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_colors.dart';

class AppSnackBar {
  AppSnackBar._();

  static void error(BuildContext context, String message) {
    _show(context, message, AppColors.danger);
  }

  static void success(BuildContext context, String message) {
    _show(context, message, AppColors.success);
  }

  static void info(BuildContext context, String message) {
    _show(context, message, AppColors.secondary);
  }

  static void _show(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
