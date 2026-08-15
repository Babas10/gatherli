// Determines whether a user can be invited to a group.
// Centralizes rules that were previously duplicated across invite flows.
import 'package:play_with_me/core/domain/use_cases/base_use_case.dart';

class InviteEligibilityInput {
  final String groupId;
  final List<String> currentMemberIds;
  final int maxMembers;
  final String? targetUserId;
  final bool targetUserIsFriend;
  final bool inviterIsAdmin;

  const InviteEligibilityInput({
    required this.groupId,
    required this.currentMemberIds,
    required this.maxMembers,
    required this.targetUserId,
    required this.targetUserIsFriend,
    required this.inviterIsAdmin,
  });
}

class InviteEligibilityResult {
  final bool canInvite;
  final String? reason;

  const InviteEligibilityResult({required this.canInvite, this.reason});

  static const allowed = InviteEligibilityResult(canInvite: true);
}

class CheckInviteEligibilityUseCase
    extends UseCase<InviteEligibilityInput, InviteEligibilityResult> {

  const CheckInviteEligibilityUseCase();

  @override
  Future<InviteEligibilityResult> execute(InviteEligibilityInput input) async {
    if (input.targetUserId == null) {
      return const InviteEligibilityResult(
        canInvite: false,
        reason: 'No user selected.',
      );
    }

    if (input.currentMemberIds.contains(input.targetUserId)) {
      return const InviteEligibilityResult(
        canInvite: false,
        reason: 'User is already a member of this group.',
      );
    }

    if (input.currentMemberIds.length >= input.maxMembers) {
      return const InviteEligibilityResult(
        canInvite: false,
        reason: 'Group is at maximum capacity.',
      );
    }

    if (!input.targetUserIsFriend) {
      return const InviteEligibilityResult(
        canInvite: false,
        reason: 'You can only invite friends to a group.',
      );
    }

    return InviteEligibilityResult.allowed;
  }
}
