// Shared styled date picker that matches the app's brand theme.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_colors.dart';

/// Shows a date picker styled consistently with the app's brand theme.
///
/// Uses [AppColors.secondary] (dark teal) for selection indicators and text
/// buttons, with a white background — matching the game and championship
/// creation forms.
Future<DateTime?> showAppStyledDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  String? helpText,
}) {
  const blue = AppColors.secondary;
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    helpText: helpText,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            headerBackgroundColor: Colors.white,
            headerForegroundColor: blue,
            dayForegroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return blue;
              return null;
            }),
            dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return Colors.white;
              return null;
            }),
            dayShape: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: blue, width: 2),
                );
              }
              return null;
            }),
            todayForegroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return blue;
              return null;
            }),
            todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return Colors.white;
              return null;
            }),
            todayBorder: const BorderSide(color: Colors.transparent),
            yearForegroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return blue;
              return null;
            }),
            yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return Colors.white;
              return null;
            }),
            yearShape: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: blue, width: 2),
                );
              }
              return null;
            }),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: blue),
          ),
        ),
        child: child!,
      );
    },
  );
}
