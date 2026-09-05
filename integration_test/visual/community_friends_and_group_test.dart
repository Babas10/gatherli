// Visual regression flow (tag: community) — one continuous session against
// the real gatherli-dev Firebase project: seeds 8 users (4 male, 4 female),
// demonstrates the real friend-request send/accept UI for one pair,
// bulk-seeds the remaining required friendships (still via each user's own
// authenticated session and real security rules — not a bypass), then
// creates a group and invites all 7 friends. Group creation only sends
// invitations (functions-side membership is invite+accept, not direct add)
// — so each invitee must separately log in and accept via the Pending
// Invitations page before the group actually has all 8 members. Cleans up
// all 8 accounts via the real deleteUserAccount Cloud Function afterward,
// which cascades to delete the group and friendships once the last member
// is removed.
//
// Only the group *admin* needs to be friends with each invitee
// (functions/src/inviteToGroup.ts checkFriendship(inviterId, invitedUserId))
// — not a fully-connected mesh — so 7 friendships total, not 28.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/features/auth/presentation/widgets/auth_button.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../test/visual/tooling/checkpoint.dart';
import '../../test/visual/tooling/dev_firebase.dart';

const _password = 'VisualTest123';
const _groupName = 'Visual Community Squad';

class _SeedUser {
  const _SeedUser(this.email, this.displayName, this.gender);
  final String email;
  final String displayName;
  final String gender;
}

// Index 0 = organizer (sends the live-demo request, creates the group).
// Index 1 = the one friendship demonstrated via real UI send+accept.
// Indices 2-7 = bulk-seeded directly (same UI path already proven at index 1).
const _users = [
  _SeedUser('visual-comm-1@gatherli.test', 'Male One', 'male'),
  _SeedUser('visual-comm-2@gatherli.test', 'Male Two', 'male'),
  _SeedUser('visual-comm-3@gatherli.test', 'Male Three', 'male'),
  _SeedUser('visual-comm-4@gatherli.test', 'Male Four', 'male'),
  _SeedUser('visual-comm-5@gatherli.test', 'Female One', 'female'),
  _SeedUser('visual-comm-6@gatherli.test', 'Female Two', 'female'),
  _SeedUser('visual-comm-7@gatherli.test', 'Female Three', 'female'),
  _SeedUser('visual-comm-8@gatherli.test', 'Female Four', 'female'),
];

Future<void> _login(
  WidgetTester tester,
  AppLocalizations l10n,
  String email,
) async {
  await tester.enterText(
    find.widgetWithText(TextFormField, l10n.emailHint),
    email,
  );
  await tester.enterText(
    find.widgetWithText(TextFormField, l10n.passwordHint),
    _password,
  );
  await tester.tap(find.byType(AuthButton));
  await tester.pumpAndSettle(const Duration(seconds: 5));
}

Future<void> _logout(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.logout));
  await tester.pumpAndSettle();
  await tester.tap(
    find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(FilledButton),
    ),
  );
  await tester.pumpAndSettle(const Duration(seconds: 3));
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('community: friend requests, friends list & group creation', (
    tester,
  ) async {
    await bootstrapFirebaseAgainstDev();

    // Defensive: clean up leftovers from a previous crashed run.
    for (final user in _users) {
      await deleteTestUserIfExists(email: user.email, password: _password);
    }

    // ── Seed all 8 users ──────────────────────────────────────────────────
    final uids = <String>[];
    for (final user in _users) {
      final uid = await createTestUser(
        email: user.email,
        password: _password,
        displayName: user.displayName,
        gender: user.gender,
      );
      uids.add(uid);
    }
    await FirebaseAuth.instance.signOut();

    // ── Bulk-seed the 6 friendships not demonstrated via live UI ───────────
    // firestore.rules requires the *initiator* to create as 'pending' and
    // only the *recipient* to transition it to 'accepted' — no shortcut to
    // create it pre-accepted. Done headless (direct FirebaseAuth sign-ins,
    // no UI) before pumping the widget tree, since none of this needs a
    // checkpoint — the one pair that does (users[0]<->users[1]) is driven
    // through the real UI further down.
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _users[0].email,
      password: _password,
    );
    final friendshipIds = <String>[];
    for (var i = 2; i < _users.length; i++) {
      final ref = await FirebaseFirestore.instance.collection('friendships').add({
        'initiatorId': uids[0],
        'recipientId': uids[i],
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'initiatorName': _users[0].displayName,
        'recipientName': _users[i].displayName,
      });
      friendshipIds.add(ref.id);
    }
    await FirebaseAuth.instance.signOut();

    for (var i = 2; i < _users.length; i++) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _users[i].email,
        password: _password,
      );
      await FirebaseFirestore.instance
          .collection('friendships')
          .doc(friendshipIds[i - 2])
          .update({
            'status': 'accepted',
            'updatedAt': FieldValue.serverTimestamp(),
          });
      await FirebaseAuth.instance.signOut();
    }

    await initializeDependencies();

    await tester.pumpWidget(const PlayWithMeApp());
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    // ── Organizer: see pre-seeded friends, send a live request ─────────────
    await _login(tester, l10n, _users[0].email);

    await tester.tap(find.text(l10n.community));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // Known flaky checkpoint: the getFriends Cloud Function has no explicit
    // sort order, and each run's bulk-seeded friendship docs get fresh
    // random Firestore IDs, so the returned (and displayed) order isn't
    // guaranteed stable run-to-run. A reorder here is expected occasionally
    // and isn't a regression.
    await visualCheckpoint('friends_list_seeded');

    await tester.tap(find.text(l10n.addFriend));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, l10n.searchFriendsByEmail),
      _users[1].email,
    );
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text(l10n.sendFriendRequest));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('friend_request_sent');

    await _logout(tester);

    // ── Second user: see the badge + incoming request, accept it ───────────
    await _login(tester, l10n, _users[1].email);
    await visualCheckpoint('community_badge_notification');

    await tester.tap(find.text(l10n.community));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text(l10n.requests));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('received_request');

    await tester.tap(find.text(l10n.accept));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text(l10n.friends));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('friends_list_after_accept');

    await _logout(tester);

    // ── Organizer again: create the group with all 7 friends ───────────────
    await _login(tester, l10n, _users[0].email);

    await tester.tap(find.text(l10n.groups));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text(l10n.createGroup));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Group Name *'),
      _groupName,
    );
    await tester.tap(find.text('Select All'));
    await tester.pumpAndSettle();
    await visualCheckpoint('group_creation_form_filled');

    await tester.ensureVisible(
      find.widgetWithText(FilledButton, 'Create Group'),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Create Group'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(find.text(_groupName));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('group_details_members_pending_invites');

    await _logout(tester);

    // ── Each invited friend logs in and accepts the group invitation via
    // the mail icon (Pending Invitations page) — group creation only sends
    // invitations, it doesn't add members directly. Only the first
    // acceptance is screenshotted; the rest repeat the identical UI.
    for (var i = 1; i < _users.length; i++) {
      await _login(tester, l10n, _users[i].email);

      await tester.tap(find.byIcon(Icons.mail_outline));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      if (i == 1) {
        await visualCheckpoint('group_invitation_received');
      }

      await tester.tap(find.text(l10n.accept));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      if (i == 1) {
        await visualCheckpoint('group_invitation_accepted');
      }

      await _logout(tester);
    }

    // ── Organizer: confirm the group now has all 8 members ─────────────────
    await _login(tester, l10n, _users[0].email);

    await tester.tap(find.text(l10n.groups));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text(_groupName));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('group_details_members');

    await tester.tap(find.text(l10n.activities));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('group_details_activities_empty');

    // ── Cleanup: delete all 8 accounts. deleteUserAccount cascades to
    // delete the group (once the last member is removed) and any remaining
    // friendships — no manual Firestore cleanup needed. Uses direct SDK
    // sign-ins regardless of whatever the UI currently shows.
    for (final user in _users) {
      await deleteTestUserIfExists(email: user.email, password: _password);
    }
  });
}
