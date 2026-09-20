// Single source of truth for the "Today/Tomorrow/<date>" + time formatting
// used across game, training, and activity list rows. Previously copy-pasted
// as a private method in 5 different widgets with a visible inconsistency
// (some joined day+time with " • ", others with a plain space).
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

/// Formats [dateTime] as "Today • 3:00 PM", "Tomorrow • 3:00 PM", or
/// "Fri, Jan 2 • 3:00 PM" depending on how far away it is from today.
String formatSmartDateTime(BuildContext context, DateTime dateTime) {
  final l10n = AppLocalizations.of(context)!;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));
  final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  final String dayString;
  if (targetDate == today) {
    dayString = l10n.today;
  } else if (targetDate == tomorrow) {
    dayString = l10n.tomorrow;
  } else {
    dayString = DateFormat('EEE, MMM d').format(dateTime);
  }

  final timeString = DateFormat('h:mm a').format(dateTime);
  return '$dayString • $timeString';
}
