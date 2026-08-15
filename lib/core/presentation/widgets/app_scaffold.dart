// Shared scaffold wrapper — centralizes loading, error and content rendering.
// Use this in every page instead of manually checking BLoC states.
//
// Usage:
//   AppScaffold(
//     title: 'My Page',
//     isLoading: state is MyStateLoading,
//     errorMessage: state is MyStateError ? state.message : null,
//     body: _buildContent(state),
//   )
import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/global_bottom_nav_bar.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final int? bottomNavIndex;
  final ValueChanged<int>? onBottomNavTap;
  final bool showBottomNav;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.actions,
    this.floatingActionButton,
    this.bottomNavIndex,
    this.onBottomNavTap,
    this.showBottomNav = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: showBottomNav && bottomNavIndex != null
          ? GlobalBottomNavBar(
              selectedIndex: bottomNavIndex!,
              onTabSelected: onBottomNavTap ?? (_) {},
            )
          : null,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.secondary),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48, color: AppColors.danger),
              const SizedBox(height: 16),
              Text(
                errorMessage!,
                style: AppTextStyles.caption.copyWith(color: AppColors.danger),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return body;
  }
}
