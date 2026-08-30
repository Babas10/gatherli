// Shared helpers for sharing/copying links.
//
// iOS presents the share sheet as a popover anchored to a source rect
// (required for iPad, and enforced by some iOS versions even on iPhone).
// Without sharePositionOrigin, Share.share() can throw
// PlatformException(error, "sharePositionOrigin: argument must be set...").
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

/// Shares [text] using the on-screen bounds of [context]'s nearest RenderBox
/// as the iOS popover anchor.
Future<void> shareText(BuildContext context, String text) {
  final box = context.findRenderObject() as RenderBox?;
  final origin = box != null ? (box.localToGlobal(Offset.zero) & box.size) : null;
  return Share.share(text, sharePositionOrigin: origin);
}

/// Copies [url] to the clipboard and shows a confirmation snackbar.
Future<void> copyLinkToClipboard(
  BuildContext context,
  String url,
  AppLocalizations l10n,
) async {
  await Clipboard.setData(ClipboardData(text: url));
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(l10n.linkCopied),
      backgroundColor: AppColors.success,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}
