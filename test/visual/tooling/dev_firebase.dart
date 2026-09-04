import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/// Ensures Firebase is initialized against the real **gatherli-dev** project
/// — no emulator redirects. Flows must be run with `flutter test --flavor
/// dev` (see run_visual_tests.dart) so the bundled GoogleService-Info.plist
/// actually points at gatherli-dev rather than the prod-by-default fallback.
///
/// Handles iOS auto-initializing the default Firebase app natively (from the
/// bundled GoogleService-Info.plist) before the test body runs, so a bare
/// `Firebase.initializeApp()` would throw `duplicate-app` — caught and
/// ignored, reusing the native app instead.
Future<void> bootstrapFirebaseAgainstDev() async {
  try {
    await Firebase.initializeApp();
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') rethrow;
    Firebase.app();
  }
  await FirebaseAuth.instance.signOut();
}

/// Deletes a test account if it currently exists, via the real
/// `deleteUserAccount` Cloud Function (self-delete only — reuses production
/// cascade logic: removes the user from groups (deleting them if left
/// empty, promoting another admin otherwise), deletes their friendships,
/// game invitations, avatar, and finally the account itself).
///
/// Call this both defensively before seeding (in case a previous run
/// crashed before cleaning up) and always after a flow completes. Silently
/// does nothing if the account doesn't exist or the password doesn't match
/// (nothing to clean up).
Future<void> deleteTestUserIfExists({
  required String email,
  required String password,
}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException {
    return;
  }

  try {
    await FirebaseFunctions.instanceFor(
      region: 'europe-west6',
    ).httpsCallable('deleteUserAccount').call();
  } finally {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {
      // Already deleted/signed out — nothing to do.
    }
  }
}

/// Deletes the currently signed-in account via the real `deleteUserAccount`
/// Cloud Function. Use when the flow already ends authenticated as the
/// account to clean up (e.g. right after a signup flow) — for the
/// sign-in-then-delete case, use [deleteTestUserIfExists] instead.
Future<void> deleteUserAccount() async {
  await FirebaseFunctions.instanceFor(
    region: 'europe-west6',
  ).httpsCallable('deleteUserAccount').call();
  await FirebaseAuth.instance.signOut();
}

/// Creates a fixed test user directly via the Auth SDK (not through the
/// signup UI — use this for flows where the seeded user isn't what's being
/// tested). Sets the Auth profile displayName before the `createUserDocument`
/// trigger fires so it lands in the auto-created Firestore doc correctly
/// (the trigger reads `user.displayName` and uses `merge: true`, so this
/// doesn't race with our own follow-up write below).
Future<String> createTestUser({
  required String email,
  required String password,
  required String displayName,
  String? gender,
}) async {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  final user = credential.user!;
  await user.updateDisplayName(displayName);
  await user.reload();

  await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
    {
      'displayName': displayName,
      if (gender != null) 'gender': gender,
    },
    SetOptions(merge: true),
  );

  return user.uid;
}
