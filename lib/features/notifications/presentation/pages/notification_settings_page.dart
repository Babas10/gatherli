import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/theme/play_with_me_app_bar.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repositories/notification_repository.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';

/// Screen for managing notification preferences — 4 category toggles (Story N.3).
class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationBloc(repository: GetIt.instance<NotificationRepository>())
            ..add(const NotificationEvent.loadPreferences()),
      child: const _NotificationSettingsView(),
    );
  }
}

class _NotificationSettingsView extends StatelessWidget {
  const _NotificationSettingsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: PlayWithMeAppBar.build(
        context: context,
        title: l10n.notificationSettingsTitle,
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (prefs) => _buildList(context, l10n, prefs, enabled: true),
            updating: (prefs) =>
                _buildList(context, l10n, prefs, enabled: false),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: AppColors.danger),
                  const SizedBox(height: AppSpacing.lg),
                  Text(message),
                  const SizedBox(height: AppSpacing.lg),
                  FilledButton(
                    onPressed: () => context
                        .read<NotificationBloc>()
                        .add(const NotificationEvent.loadPreferences()),
                    child: Text(l10n.retryButton),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    AppLocalizations l10n,
    dynamic prefs, {
    required bool enabled,
  }) {
    final bloc = context.read<NotificationBloc>();
    return ListView(
      children: [
        if (!enabled) const LinearProgressIndicator(),
        // ── Category toggles ──────────────────────────────────────────────
        _SectionHeader(title: l10n.notificationSettingsCategories),
        _CategoryTile(
          icon: Icons.people_outline,
          title: l10n.notifCategorySocial,
          subtitle: l10n.notifCategorySocialSubtitle,
          value: prefs.social,
          enabled: enabled,
          onChanged: (v) =>
              bloc.add(NotificationEvent.toggleSocial(v)),
        ),
        _CategoryTile(
          icon: Icons.sports_volleyball_outlined,
          title: l10n.notifCategoryGames,
          subtitle: l10n.notifCategoryGamesSubtitle,
          value: prefs.games,
          enabled: enabled,
          onChanged: (v) =>
              bloc.add(NotificationEvent.toggleGames(v)),
        ),
        _CategoryTile(
          icon: Icons.fitness_center_outlined,
          title: l10n.notifCategoryTraining,
          subtitle: l10n.notifCategoryTrainingSubtitle,
          value: prefs.training,
          enabled: enabled,
          onChanged: (v) =>
              bloc.add(NotificationEvent.toggleTraining(v)),
        ),
        _CategoryTile(
          icon: Icons.emoji_events_outlined,
          title: l10n.notifCategoryChampionships,
          subtitle: l10n.notifCategoryChampionshipsSubtitle,
          value: prefs.championship,
          enabled: enabled,
          onChanged: (v) =>
              bloc.add(NotificationEvent.toggleChampionship(v)),
        ),

        const Divider(height: 32),

        // ── Quiet Hours ───────────────────────────────────────────────────
        _SectionHeader(title: l10n.notifQuietHoursTitle),
        SwitchListTile(
          title: Text(l10n.notifQuietHoursEnable),
          subtitle: prefs.quietHoursEnabled
              ? Text(l10n.notifQuietHoursRange(
                  prefs.quietHoursStart ?? '22:00',
                  prefs.quietHoursEnd ?? '08:00',
                ))
              : Text(l10n.notifQuietHoursSubtitle),
          value: prefs.quietHoursEnabled,
          onChanged: enabled
              ? (value) {
                  if (value) {
                    _showQuietHoursDialog(
                      context,
                      prefs.quietHoursStart ?? '22:00',
                      prefs.quietHoursEnd ?? '08:00',
                    );
                  } else {
                    bloc.add(NotificationEvent.toggleQuietHours(
                      enabled: false,
                      start: prefs.quietHoursStart,
                      end: prefs.quietHoursEnd,
                    ));
                  }
                }
              : null,
        ),
        if (prefs.quietHoursEnabled)
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text(l10n.notifQuietHoursAdjust),
            trailing: Text(
              '${prefs.quietHoursStart} – ${prefs.quietHoursEnd}',
              style: const TextStyle(color: AppColors.textMuted),
            ),
            onTap: enabled
                ? () => _showQuietHoursDialog(
                      context,
                      prefs.quietHoursStart ?? '22:00',
                      prefs.quietHoursEnd ?? '08:00',
                    )
                : null,
          ),

        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }

  void _showQuietHoursDialog(
    BuildContext context,
    String currentStart,
    String currentEnd,
  ) {
    TimeOfDay startTime = _parseTime(currentStart);
    TimeOfDay endTime = _parseTime(currentEnd);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Set Quiet Hours'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.bedtime),
                title: const Text('Start Time'),
                trailing: Text(startTime.format(context)),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: startTime,
                  );
                  if (picked != null) {
                    setState(() => startTime = picked);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.wb_sunny),
                title: const Text('End Time'),
                trailing: Text(endTime.format(context)),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: endTime,
                  );
                  if (picked != null) {
                    setState(() => endTime = picked);
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<NotificationBloc>().add(
                NotificationEvent.toggleQuietHours(
                  enabled: true,
                  start: _formatTime(startTime),
                  end: _formatTime(endTime),
                ),
              );
              Navigator.pop(dialogContext);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const _CategoryTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(icon,
          color: value ? AppColors.secondary : AppColors.textMuted),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: enabled ? onChanged : null,
    );
  }
}
