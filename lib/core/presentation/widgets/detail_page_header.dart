// Shared container for entity-detail-page headers (game, training session,
// championship, etc.) — the info block sitting between the AppBar and any
// TabBar. Standardizes the floating-card-on-grey-background treatment so
// pages don't each reinvent their own wrapper. Content differs per page
// (title placement, status badges, key facts) — this widget only owns the
// container, not the layout of what's inside it.
import 'package:flutter/material.dart';

class DetailPageHeader extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;

  const DetailPageHeader({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.fromLTRB(16, 12, 16, 4),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
