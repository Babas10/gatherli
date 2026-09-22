// Shared app tab bar — icon + text tabs with animated gold selected icon.
// ALL tab styling (indicator color, label style, divider) comes from
// AppTheme.tabBarTheme — change it there to update every tab in the app.
// Only the per-tab icon animation is handled here (must be runtime).
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_colors.dart';

/// Describes a single tab: an icon and a label.
class AppTabItem {
  final IconData icon;
  final String label;

  /// Optional notification count shown as a badge on the icon. 0 or null hides it.
  final int? badgeCount;

  const AppTabItem({required this.icon, required this.label, this.badgeCount});
}

/// Drop-in replacement for TabBar across the app.
/// Styling comes from AppTheme.tabBarTheme — no overrides here.
/// Pass [controller] when using a manual TabController; omit when inside
/// DefaultTabController (resolved automatically from the widget tree).
class SectionTabBar extends StatelessWidget {
  final List<AppTabItem> tabs;
  final TabController? controller;

  const SectionTabBar({super.key, required this.tabs, this.controller});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller ?? DefaultTabController.of(context);
    return TabBar(
      controller: ctrl,
      // No overrides — all colours/styles come from AppTheme.tabBarTheme.
      tabs: tabs
          .asMap()
          .entries
          .map(
            (e) => _AppTab(
              icon: e.value.icon,
              label: e.value.label,
              badgeCount: e.value.badgeCount,
              index: e.key,
              controller: ctrl,
            ),
          )
          .toList(),
    );
  }
}

/// Single animated tab: icon turns AppColors.primary when selected.
/// Icon colours reference AppColors so changing them propagates here too.
class _AppTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final int? badgeCount;
  final int index;
  final TabController controller;

  const _AppTab({
    required this.icon,
    required this.label,
    this.badgeCount,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation!,
      builder: (context, _) {
        final isSelected = controller.index == index;
        final iconColor = isSelected
            ? AppColors.primary
            : AppColors.navLabelColor;
        final count = badgeCount ?? 0;
        return Tab(
          icon: Badge(
            isLabelVisible: count > 0,
            label: Text(count > 9 ? '9+' : '$count'),
            backgroundColor: AppColors.danger,
            // Selected icon colour = AppColors.primary (gold).
            // Change AppColors.primary to change ALL selected tab icons.
            child: Icon(icon, color: iconColor),
          ),
          text: label,
        );
      },
    );
  }
}
