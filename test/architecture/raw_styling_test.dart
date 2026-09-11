// Validates that lib/ does not accumulate new raw-styling violations
// (raw Colors.*, raw hex Color(0x...) literals, or Theme.of(context).colorScheme.*)
// beyond a known, grandfathered baseline (Story 37.6).
//
// This is a RATCHET, not a full ban: CLAUDE.md's design-system audit (Epic 37)
// found hundreds of pre-existing violations across the app. Fixing them all in
// one pass was judged too risky/large, so instead this test freezes the current
// offenders in a baseline list and fails only on NEW files introducing the same
// mistake. When you fix a grandfathered file, remove it from the list below —
// shrinking these lists over time is the intended way this debt gets paid down.
//
// Do not add a file to a baseline list to make this test pass — that defeats
// its purpose. Fix the raw styling instead (see CLAUDE.md section 9b).

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// Files allowed to use raw `Colors.*` instead of `AppColors.*` (baseline as of Story 37.6).
const _rawColorsBaseline = {
  'lib/app/play_with_me_app.dart',
  'lib/core/presentation/widgets/email_verification_banner.dart',
  'lib/core/presentation/widgets/error_snackbar.dart',
  'lib/core/presentation/widgets/global_bottom_nav_bar.dart',
  'lib/core/presentation/widgets/offline_banner.dart',
  'lib/core/presentation/widgets/restricted_action_guard.dart',
  'lib/core/presentation/widgets/restricted_mode_banner.dart',
  'lib/core/theme/app_colors.dart',
  'lib/core/theme/app_theme.dart',
  'lib/core/theme/play_with_me_app_bar.dart',
  'lib/core/utils/date_picker_helper.dart',
  'lib/core/widgets/environment_indicator.dart',
  'lib/features/auth/presentation/pages/password_reset_page.dart',
  'lib/features/auth/presentation/pages/registration_page.dart',
  'lib/features/auth/presentation/widgets/auth_form_field.dart',
  'lib/features/championships/presentation/pages/championship_detail_page.dart',
  'lib/features/championships/presentation/pages/championship_list_page.dart',
  'lib/features/championships/presentation/pages/create_championship_page.dart',
  'lib/features/championships/presentation/pages/match_detail_page.dart',
  'lib/features/championships/presentation/widgets/match_chat_section.dart',
  'lib/features/championships/presentation/widgets/match_result_entry_widget.dart',
  'lib/features/championships/presentation/widgets/match_verification_widget.dart',
  'lib/features/friends/presentation/pages/add_friend_page.dart',
  'lib/features/friends/presentation/pages/my_community_page.dart',
  'lib/features/friends/presentation/widgets/friend_search_bar.dart',
  'lib/features/games/presentation/pages/game_creation_page.dart',
  'lib/features/games/presentation/pages/game_details_page.dart',
  'lib/features/games/presentation/pages/game_result_view_page.dart',
  'lib/features/games/presentation/pages/games_list_page.dart',
  'lib/features/games/presentation/pages/pickup_game_creation_page.dart',
  'lib/features/games/presentation/pages/record_results_page.dart',
  'lib/features/games/presentation/pages/score_entry_page.dart',
  'lib/features/games/presentation/widgets/game_chat_section.dart',
  'lib/features/games/presentation/widgets/game_list_item.dart',
  'lib/features/games/presentation/widgets/game_team_picker_widget.dart',
  'lib/features/games/presentation/widgets/invite_guest_players_sheet.dart',
  'lib/features/games/presentation/widgets/my_game_tile.dart',
  'lib/features/games/presentation/widgets/training_session_list_item.dart',
  'lib/features/groups/presentation/pages/group_creation_page.dart',
  'lib/features/groups/presentation/pages/invite_member_page.dart',
  'lib/features/groups/presentation/widgets/friend_selector_widget.dart',
  'lib/features/groups/presentation/widgets/group_bottom_nav_bar.dart',
  'lib/features/groups/presentation/widgets/invite_link_section.dart',
  'lib/features/groups/presentation/widgets/member_action_dialogs.dart',
  'lib/features/groups/presentation/widgets/member_action_menu.dart',
  'lib/features/invitations/presentation/pages/invite_registration_page.dart',
  'lib/features/invitations/presentation/widgets/invitation_tile.dart',
  'lib/features/profile/presentation/pages/profile_edit_page.dart',
  'lib/features/profile/presentation/pages/profile_page.dart',
  'lib/features/profile/presentation/widgets/avatar_upload_widget.dart',
  'lib/features/profile/presentation/widgets/elo_history_chart.dart',
  'lib/features/profile/presentation/widgets/home_stats_section.dart',
  'lib/features/profile/presentation/widgets/monthly_improvement_chart.dart',
  'lib/features/profile/presentation/widgets/next_game_card.dart',
  'lib/features/profile/presentation/widgets/next_training_session_card.dart',
  'lib/features/profile/presentation/widgets/player_stats_section.dart',
  'lib/features/profile/presentation/widgets/profile_header.dart',
  'lib/features/profile/presentation/widgets/ranking_stats_cards.dart',
  'lib/features/profile/presentation/widgets/rivals_card.dart',
  'lib/features/profile/presentation/widgets/stat_card.dart',
  'lib/features/training/presentation/pages/training_session_creation_page.dart',
  'lib/features/training/presentation/pages/training_session_details_page.dart',
  'lib/features/training/presentation/pages/training_session_feedback_page.dart',
  'lib/features/training/presentation/widgets/exercise_list_widget.dart',
  'lib/features/training/presentation/widgets/feedback_display_widget.dart',
  'lib/features/training/presentation/widgets/feedback_summary_card.dart',
  'lib/main_common.dart',
};

/// Files allowed to use raw hex `Color(0x...)` literals instead of `AppColors.*`
/// (baseline as of Story 37.6). `app_colors.dart` is here legitimately — it's
/// the one file where hex literals belong, since it defines the constants.
const _rawHexBaseline = {
  'lib/core/presentation/widgets/mix_game_badge.dart',
  'lib/core/services/image_picker_service.dart',
  'lib/core/theme/app_colors.dart',
  'lib/features/championships/presentation/pages/championship_detail_page.dart',
  'lib/features/profile/presentation/widgets/home_stats_section.dart',
  'lib/features/profile/presentation/widgets/next_game_card.dart',
  'lib/features/profile/presentation/widgets/next_training_session_card.dart',
};

/// Files allowed to use `Theme.of(context).colorScheme.*` (M3 auto-generated
/// tints) instead of `AppColors.*` (baseline as of Story 37.6).
const _colorSchemeBaseline = {
  'lib/features/auth/presentation/pages/registration_page.dart',
  'lib/features/championships/presentation/pages/championship_detail_page.dart',
  'lib/features/championships/presentation/widgets/partner_picker_list.dart',
  'lib/features/friends/presentation/widgets/friend_requests_list.dart',
  'lib/features/friends/presentation/widgets/search_result_tile.dart',
  'lib/features/games/presentation/pages/game_details_page.dart',
  'lib/features/games/presentation/pages/game_history_screen.dart',
  'lib/features/games/presentation/pages/games_list_page.dart',
  'lib/features/games/presentation/pages/pending_game_invitations_page.dart',
  'lib/features/games/presentation/widgets/game_list_item.dart',
  'lib/features/games/presentation/widgets/invite_guest_players_sheet.dart',
  'lib/features/games/presentation/widgets/set_scores_display.dart',
  'lib/features/games/presentation/widgets/training_session_list_item.dart',
  'lib/features/groups/presentation/pages/group_details_page.dart',
  'lib/features/groups/presentation/pages/group_list_page.dart',
  'lib/features/groups/presentation/widgets/group_bottom_nav_bar.dart',
  'lib/features/groups/presentation/widgets/group_list_item.dart',
  'lib/features/groups/presentation/widgets/member_action_menu.dart',
  'lib/features/groups/presentation/widgets/member_list_item_with_friendship.dart',
  'lib/features/groups/presentation/widgets/user_search_result_tile.dart',
  'lib/features/invitations/presentation/pages/invite_registration_page.dart',
  'lib/features/invitations/presentation/widgets/invitation_tile.dart',
  'lib/features/profile/presentation/pages/profile_edit_page.dart',
  'lib/features/profile/presentation/pages/profile_page.dart',
  'lib/features/profile/presentation/pages/stats_page.dart',
  'lib/features/profile/presentation/widgets/avatar_upload_widget.dart',
  'lib/features/profile/presentation/widgets/profile_actions.dart',
  'lib/features/training/presentation/pages/training_session_feedback_page.dart',
  'lib/features/training/presentation/widgets/feedback_display_widget.dart',
};

List<String> _findViolatingFiles(RegExp pattern) {
  final libDir = Directory('lib');
  return libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where((file) => pattern.hasMatch(file.readAsStringSync()))
      .map((file) => file.path.replaceAll(r'\', '/'))
      .toList();
}

void main() {
  group('Raw Styling Ratchet (Story 37.6)', () {
    test('no new files use raw Colors.* instead of AppColors.*', () {
      final violators = _findViolatingFiles(RegExp(r'Colors\.\w'))
          .where((path) {
            final content = File(path).readAsStringSync();
            return content
                .split('\n')
                .any((line) => line.contains('Colors.') && !line.contains('AppColors.'));
          })
          .toList();

      final newViolations = violators
          .where((path) => !_rawColorsBaseline.contains(path))
          .toList();

      expect(
        newViolations,
        isEmpty,
        reason:
            'New file(s) use raw Colors.* instead of AppColors.*:\n${newViolations.join('\n')}\n\n'
            'ARCHITECTURE RULE (Story 37.6 / CLAUDE.md section 9b): never use raw '
            'Colors.* or Color(0xFF...) in widgets — use the AppColors.* constants.\n'
            'If this is pre-existing debt being moved/renamed rather than new, add '
            'the file to _rawColorsBaseline in this test with a comment explaining why.',
      );
    });

    test('no new files use raw hex Color(0x...) instead of AppColors.*', () {
      final violators = _findViolatingFiles(RegExp(r'Color\(0x'));

      final newViolations = violators
          .where((path) => !_rawHexBaseline.contains(path))
          .toList();

      expect(
        newViolations,
        isEmpty,
        reason:
            'New file(s) use a raw hex Color(0x...) literal instead of AppColors.*:\n'
            '${newViolations.join('\n')}\n\n'
            'ARCHITECTURE RULE (Story 37.6 / CLAUDE.md section 9b): add the color to '
            'AppColors instead of hardcoding a hex literal in a widget.',
      );
    });

    test('no new files use Theme.of(context).colorScheme.* instead of AppColors.*', () {
      final violators =
          _findViolatingFiles(RegExp(r'Theme\.of\(context\)\.colorScheme\.'));

      final newViolations = violators
          .where((path) => !_colorSchemeBaseline.contains(path))
          .toList();

      expect(
        newViolations,
        isEmpty,
        reason:
            'New file(s) use Theme.of(context).colorScheme.* (M3 auto-generated '
            'tints) instead of AppColors.*:\n${newViolations.join('\n')}\n\n'
            'ARCHITECTURE RULE (Story 37.6 / CLAUDE.md section 9b): M3 colorScheme '
            'produces generated tints (cream, warm grey) that clash with the '
            "app's design system — use AppColors.* exclusively.",
      );
    });

    test('baseline lists only reference files that still exist', () {
      final stale = <String>[];
      for (final path in {
        ..._rawColorsBaseline,
        ..._rawHexBaseline,
        ..._colorSchemeBaseline,
      }) {
        if (!File(path).existsSync()) {
          stale.add(path);
        }
      }

      expect(
        stale,
        isEmpty,
        reason:
            'These grandfathered files no longer exist — remove them from the '
            'baseline lists in this test:\n${stale.join('\n')}',
      );
    });
  });
}
