// Unit tests for CheckInviteEligibilityUseCase.
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/features/groups/domain/use_cases/check_invite_eligibility_use_case.dart';

void main() {
  const useCase = CheckInviteEligibilityUseCase();

  InviteEligibilityInput baseInput({
    String? targetUserId = 'target1',
    List<String> members = const [],
    int maxMembers = 20,
    bool isFriend = true,
    bool isAdmin = true,
  }) =>
      InviteEligibilityInput(
        groupId: 'g1',
        currentMemberIds: members,
        maxMembers: maxMembers,
        targetUserId: targetUserId,
        targetUserIsFriend: isFriend,
        inviterIsAdmin: isAdmin,
      );

  test('allows invite when all conditions met', () async {
    final result = await useCase(baseInput());
    expect(result.canInvite, isTrue);
  });

  test('blocks when target is already a member', () async {
    final result = await useCase(baseInput(
      targetUserId: 'user1',
      members: ['user1', 'user2'],
    ));
    expect(result.canInvite, isFalse);
    expect(result.reason, contains('already a member'));
  });

  test('blocks when group is at max capacity', () async {
    final result = await useCase(baseInput(
      members: List.generate(5, (i) => 'user$i'),
      maxMembers: 5,
    ));
    expect(result.canInvite, isFalse);
    expect(result.reason, contains('maximum capacity'));
  });

  test('blocks when target is not a friend', () async {
    final result = await useCase(baseInput(isFriend: false));
    expect(result.canInvite, isFalse);
    expect(result.reason, contains('friends'));
  });

  test('blocks when no target user selected', () async {
    final result = await useCase(baseInput(targetUserId: null));
    expect(result.canInvite, isFalse);
  });
}
