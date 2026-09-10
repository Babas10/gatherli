import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

/// A widget that displays an email verification status badge
class VerificationBadge extends StatelessWidget {
  const VerificationBadge({super.key, required this.isVerified});

  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return isVerified
        ? StatusBadge.success(l10n.verified)
        : StatusBadge.danger(l10n.notVerified);
  }
}
