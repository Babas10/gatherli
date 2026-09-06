// Visual regression flow (tag: championship) — full 4-team round-robin
// championship ("League" in the UI) lifecycle against the real gatherli-dev
// Firebase project: creates a championship, registers 4 teams of 2 players
// each (championships are group-independent — no group needed at all),
// starts it, plays through the entire round-robin (4 teams = 3 rounds x 2
// matches/round = 6 total matches, each submitted then verified by the
// opposing team), and confirms final standings and the champion banner.
//
// Unlike games/training, championship creation has no admin gate (any
// authenticated user may create one — the creator becomes the sole
// "admin" for that championship via adminIds). Team creation requires the
// captain and partner to already be friends (checkFriendship), seeded
// directly via Firestore (two-phase: initiator creates pending, recipient
// accepts — Firestore rules require the recipient's own session to
// transition it), same rationale as community_friends_and_group_test.dart.
//
// Match scheduling (propose/accept) is optional, not required before score
// submission, so this flow skips it entirely and submits scores as soon as
// the championship starts.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/features/auth/presentation/widgets/auth_button.dart';
import 'package:play_with_me/features/championships/presentation/pages/match_detail_page.dart';
import 'package:play_with_me/features/championships/presentation/widgets/create_team_bottom_sheet.dart';
import 'package:play_with_me/features/championships/presentation/widgets/match_result_entry_widget.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../test/visual/tooling/checkpoint.dart';
import '../../test/visual/tooling/dev_firebase.dart';

const _password = 'VisualTest123';
const _championshipTitle = 'Visual Test League';

class _SeedUser {
  const _SeedUser(this.email, this.displayName);
  final String email;
  final String displayName;
}

// Captains: indices 0, 2, 4, 6. Partners: 1, 3, 5, 7. Pair i creates
// _teamNames[i / 2].
const _users = [
  _SeedUser('visual-champ-1@gatherli.test', 'CH One'),
  _SeedUser('visual-champ-2@gatherli.test', 'CH Two'),
  _SeedUser('visual-champ-3@gatherli.test', 'CH Three'),
  _SeedUser('visual-champ-4@gatherli.test', 'CH Four'),
  _SeedUser('visual-champ-5@gatherli.test', 'CH Five'),
  _SeedUser('visual-champ-6@gatherli.test', 'CH Six'),
  _SeedUser('visual-champ-7@gatherli.test', 'CH Seven'),
  _SeedUser('visual-champ-8@gatherli.test', 'CH Eight'),
];

const _teamNames = ['Team Alpha', 'Team Beta', 'Team Gamma', 'Team Delta'];

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

// Unlike GroupDetailsPage (games/training flows), ChampionshipDetailPage and
// MatchDetailPage use a plain back+title app bar with no logout icon — pop
// back through the navigation stack (however deep — List -> Detail -> Match
// Detail) until a tab-root page with the full PlayWithMeAppBar is reached.
Future<void> _logout(WidgetTester tester) async {
  for (var guard = 0; guard < 5; guard++) {
    if (find.byIcon(Icons.logout).evaluate().isNotEmpty) break;
    await tester.pageBack();
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
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

Future<void> _navigateToChampionship(
  WidgetTester tester,
  AppLocalizations l10n,
) async {
  await tester.tap(find.text(l10n.championshipsTitle));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.tap(find.text(_championshipTitle).first);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'championship: create, register 4 teams, play full round-robin, champion',
    (tester) async {
      await bootstrapFirebaseAgainstDev();

      for (final user in _users) {
        await deleteTestUserIfExists(email: user.email, password: _password);
      }

      final uids = <String>[];
      final emailByUid = <String, String>{};
      final displayNameByUid = <String, String>{};
      for (final user in _users) {
        final uid = await createTestUser(
          email: user.email,
          password: _password,
          displayName: user.displayName,
        );
        uids.add(uid);
        emailByUid[uid] = user.email;
        displayNameByUid[uid] = user.displayName;
      }

      // Seed accepted friendships for the 4 captain/partner pairs — required
      // by createChampionshipTeam.ts's checkFriendship guard. Firestore
      // rules require the initiator to create as 'pending' and only the
      // recipient to transition it to 'accepted' (same two-phase pattern as
      // community_friends_and_group_test.dart's bulk friendship seeding).
      final friendshipIds = <String>[];
      for (var i = 0; i < _users.length; i += 2) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _users[i].email,
          password: _password,
        );
        final ref = await FirebaseFirestore.instance.collection('friendships').add({
          'initiatorId': uids[i],
          'recipientId': uids[i + 1],
          'status': 'pending',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'initiatorName': _users[i].displayName,
          'recipientName': _users[i + 1].displayName,
        });
        friendshipIds.add(ref.id);
        await FirebaseAuth.instance.signOut();
      }
      for (var i = 0; i < _users.length; i += 2) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _users[i + 1].email,
          password: _password,
        );
        await FirebaseFirestore.instance
            .collection('friendships')
            .doc(friendshipIds[i ~/ 2])
            .update({'status': 'accepted', 'updatedAt': FieldValue.serverTimestamp()});
        await FirebaseAuth.instance.signOut();
      }

      await initializeDependencies();

      await tester.pumpWidget(const PlayWithMeApp());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      // ── Captain 0 (u0): create the championship ─────────────────────────
      await _login(tester, l10n, _users[0].email);

      await tester.tap(find.text(l10n.championshipsTitle));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(
        find.widgetWithText(TextFormField, l10n.championshipCreateTitleLabel),
        _championshipTitle,
      );

      // Max teams: tap the "4" segment of the _SegmentedField<int>.
      await tester.tap(find.text('4'));
      await tester.pumpAndSettle();

      // Registration deadline: accept the pre-filled default (now + 30 days).
      await tester.tap(
        find.widgetWithText(InkWell, l10n.championshipCreateDeadlineLabel),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.ok));
      await tester.pumpAndSettle();

      await tester.ensureVisible(
        find.widgetWithText(FilledButton, l10n.championshipCreateSubmit),
      );
      await tester.tap(
        find.widgetWithText(FilledButton, l10n.championshipCreateSubmit),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await visualCheckpoint('championship_created');

      // Creation doesn't auto-navigate into the detail page — back on the
      // Leagues list, tap into it.
      await tester.tap(find.text(_championshipTitle).first);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.ensureVisible(find.text(l10n.registerTeam));
      await tester.tap(find.text(l10n.registerTeam));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.enterText(
        find.widgetWithText(TextFormField, l10n.teamNameLabel),
        _teamNames[0],
      );
      await tester.tap(find.text(_users[1].displayName));
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(CreateTeamBottomSheet),
          matching: find.text(l10n.registerTeam),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await _logout(tester);

      // ── Captains 2, 4, 6: register the remaining 3 teams ────────────────
      for (var i = 2; i < _users.length; i += 2) {
        await _login(tester, l10n, _users[i].email);
        await _navigateToChampionship(tester, l10n);

        await tester.ensureVisible(find.text(l10n.registerTeam));
        await tester.tap(find.text(l10n.registerTeam));
        await tester.pumpAndSettle(const Duration(seconds: 2));
        await tester.enterText(
          find.widgetWithText(TextFormField, l10n.teamNameLabel),
          _teamNames[i ~/ 2],
        );
        await tester.tap(find.text(_users[i + 1].displayName));
        await tester.pumpAndSettle();
        await tester.tap(
          find.descendant(
            of: find.byType(CreateTeamBottomSheet),
            matching: find.text(l10n.registerTeam),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 2));

        await _logout(tester);
      }

      // ── Captain 0: start the championship (registering the 4th team
      // above auto-closed registration) ───────────────────────────────────
      await _login(tester, l10n, _users[0].email);
      await _navigateToChampionship(tester, l10n);

      await tester.tap(find.text(l10n.adminPanelTabLabel));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, l10n.startChampionshipButton),
      );
      await tester.tap(
        find.widgetWithText(FilledButton, l10n.startChampionshipButton),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.widgetWithText(FilledButton, l10n.startChampionshipButton),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await visualCheckpoint('championship_started');

      // Discover the championship/team/match structure directly — Firestore
      // subcollection ordering is not creation-order, so pairings can't be
      // assumed (same rationale as querying gameId after creation in the
      // game-workflow flows).
      //
      // Filter by createdBy (uids[0]), not title: there's no
      // deleteChampionship Cloud Function anywhere in the codebase
      // (championship writes are Cloud-Functions-only, so this test can't
      // clean up its own championship doc the way it cleans up
      // users/groups via deleteUserAccount), so failed prior runs leave
      // orphaned "Visual Test League"-titled championships behind — a
      // title-only query could match the wrong one. uids[0] is a brand new
      // Firebase Auth account every run, so filtering by it is unambiguous
      // without needing a composite index (title+createdBy+orderBy would).
      final champQuery = await FirebaseFirestore.instance
          .collection('championships')
          .where('createdBy', isEqualTo: uids[0])
          .limit(1)
          .get();
      final championshipId = champQuery.docs.single.id;

      final teamsSnap = await FirebaseFirestore.instance
          .collection('championships')
          .doc(championshipId)
          .collection('teams')
          .get();
      final teamNameById = <String, String>{};
      final teamMembersById = <String, List<String>>{};
      for (final doc in teamsSnap.docs) {
        teamNameById[doc.id] = doc.data()['name'] as String;
        teamMembersById[doc.id] = List<String>.from(doc.data()['memberIds'] as List);
      }

      final matchesSnap = await FirebaseFirestore.instance
          .collection('championships')
          .doc(championshipId)
          .collection('matches')
          .orderBy('round')
          .get();
      expect(matchesSnap.docs.length, 6);

      await _logout(tester);

      // ── Play every match: submit (team A always wins 2-0), then verify
      // by a member of the opposing team.
      //
      // Real bug found and worked around here (filed, not fixed in this
      // PR — see PR description): the "Matches" tab's per-round query
      // (getMatchesForRound, where('round', isEqualTo: ...)) and even the
      // "My Matches" tab's unfiltered query (getAllMatches, orderBy
      // 'round')) both reliably got stuck showing zero results for 60+
      // seconds after the championship started, despite the exact same
      // filters run directly against Firestore returning the right docs
      // immediately — a Firestore client-side listener-caching issue
      // (this collection was watched while empty, before
      // startChampionship's batch write populated it), not a timing issue
      // fixable by waiting longer. getMatch (a single-document watch by
      // ID, used by MatchDetailPage) does not share this problem, so this
      // flow navigates there directly via the app's global navigatorKey
      // instead of tapping through either match-list tab. ────────────────
      var isFirstMatch = true;
      for (final matchDoc in matchesSnap.docs) {
        final data = matchDoc.data();
        final teamAId = data['teamAId'] as String;
        final teamBId = data['teamBId'] as String;
        final submitterUid = teamMembersById[teamAId]!.first;
        final verifierUid = teamMembersById[teamBId]!.first;
        final submitterEmail = emailByUid[submitterUid]!;
        final verifierEmail = emailByUid[verifierUid]!;

        await _login(tester, l10n, submitterEmail);
        PlayWithMeApp.navigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => MatchDetailPage(
              championshipId: championshipId,
              matchId: matchDoc.id,
              currentUserId: submitterUid,
              currentUserDisplayName: displayNameByUid[submitterUid]!,
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 3));

        if (isFirstMatch) {
          await visualCheckpoint('championship_first_match_detail');
        }

        final scoreFields = find.descendant(
          of: find.byType(MatchResultEntryWidget),
          matching: find.byType(TextField),
        );
        await tester.enterText(scoreFields.at(0), '21'); // set 1, team A
        await tester.enterText(scoreFields.at(1), '15'); // set 1, team B
        await tester.enterText(scoreFields.at(2), '21'); // set 2, team A
        await tester.enterText(scoreFields.at(3), '15'); // set 2, team B
        await tester.pumpAndSettle();

        await tester.ensureVisible(
          find.widgetWithText(FilledButton, l10n.submitResultSubmitButton),
        );
        await tester.tap(
          find.widgetWithText(FilledButton, l10n.submitResultSubmitButton),
        );
        await tester.pumpAndSettle(const Duration(seconds: 3));

        if (isFirstMatch) {
          await visualCheckpoint('championship_first_match_submitted');
        }

        await _logout(tester);

        await _login(tester, l10n, verifierEmail);
        PlayWithMeApp.navigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => MatchDetailPage(
              championshipId: championshipId,
              matchId: matchDoc.id,
              currentUserId: verifierUid,
              currentUserDisplayName: displayNameByUid[verifierUid]!,
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 3));

        await tester.ensureVisible(
          find.widgetWithText(FilledButton, l10n.verifyResultConfirmButton),
        );
        await tester.tap(
          find.widgetWithText(FilledButton, l10n.verifyResultConfirmButton),
        );
        await tester.pumpAndSettle(const Duration(seconds: 3));

        if (isFirstMatch) {
          await visualCheckpoint('championship_first_match_verified');
        }
        isFirstMatch = false;

        await _logout(tester);
      }

      // ── Final standings: team A of every match won, so whichever team
      // was teamAId in all 3 of its matches is undefeated (3-0, 9 points)
      // and every other team is 1-2 (3 points) ────────────────────────────
      await _login(tester, l10n, _users[0].email);
      await _navigateToChampionship(tester, l10n);
      await tester.tap(find.text(l10n.championshipDetailStandingsTab));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await visualCheckpoint('championship_final_standings');

      // ── Mark the championship complete (not automatic — an explicit
      // admin action) and confirm the champion banner ─────────────────────
      await tester.tap(find.text(l10n.adminPanelTabLabel));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      // Unlike the "Start League" FilledButton, "Mark as Complete" is an
      // OutlinedButton.icon (_AdminActions, championship_detail_page.dart)
      // — only the dialog's own confirm button is a FilledButton.
      await tester.ensureVisible(
        find.widgetWithText(OutlinedButton, l10n.completeChampionshipButton),
      );
      await tester.tap(
        find.widgetWithText(OutlinedButton, l10n.completeChampionshipButton),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.widgetWithText(FilledButton, l10n.completeChampionshipButton),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.text(l10n.championshipDetailStandingsTab));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await visualCheckpoint('championship_completed_with_champion');
      expect(find.text(l10n.championshipChampionLabel), findsOneWidget);

      // ── Functional assertions: exactly one undefeated team, matching the
      // scripted "team A always wins" outcome ─────────────────────────────
      final standingsSnap = await FirebaseFirestore.instance
          .collection('championships')
          .doc(championshipId)
          .collection('standings')
          .get();
      final standingsByPosition = standingsSnap.docs.map((d) => d.data()).toList()
        ..sort((a, b) => (a['position'] as int).compareTo(b['position'] as int));
      expect(standingsByPosition.first['points'], 9);
      expect(standingsByPosition.first['wins20'], 3);
      for (final entry in standingsByPosition.skip(1)) {
        expect(entry['points'], 3);
      }

      final finalChampDoc = await FirebaseFirestore.instance
          .collection('championships')
          .doc(championshipId)
          .get();
      expect(finalChampDoc.data()!['status'], 'completed');
      expect(finalChampDoc.data()!['championTeamId'], isNotNull);

      await _logout(tester);

      // ── Cleanup ──────────────────────────────────────────────────────────
      for (final user in _users) {
        await deleteTestUserIfExists(email: user.email, password: _password);
      }
    },
  );
}
