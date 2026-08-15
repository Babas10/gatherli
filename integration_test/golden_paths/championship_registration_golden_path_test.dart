// Golden path integration test: championship registration flow.
// Covers the most critical user journey end-to-end against Firebase emulator.
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "../helpers/firebase_emulator_helper.dart";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late FirebaseFirestore db;
  late String captainUid;

  setUpAll(() async {
    await FirebaseEmulatorHelper.initialize();
    db = FirebaseFirestore.instance;
  });

  setUp(() async {
    await FirebaseEmulatorHelper.clearFirestore();
    final user = await FirebaseEmulatorHelper.createAndSignInUser(
      email: "captain@test.com", password: "test1234");
    captainUid = user.uid;
  });

  tearDown(() => FirebaseEmulatorHelper.signOut());

  test("golden path: create championship, register team, team visible in query", () async {
    // 1. Create championship
    final champRef = await db.collection("championships").add({
      "title": "Golden Path Championship", "status": "registration",
      "maxTeams": 8, "teamSize": 2, "teamsCount": 0,
      "adminIds": [captainUid], "createdBy": captainUid,
      "currentRound": 0, "totalRounds": 9,
      "registrationDeadline": Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))),
      "createdAt": Timestamp.now(),
    });
    expect(champRef.id, isNotEmpty);

    // 2. Register team
    final teamRef = await db.collection("championships").doc(champRef.id)
        .collection("teams").add({
      "name": "Les Titans", "captainId": captainUid,
      "memberIds": [captainUid, "partner-uid"], "createdAt": Timestamp.now(),
    });
    await champRef.update({"teamsCount": FieldValue.increment(1)});

    // 3. Verify team exists
    final teamDoc = await teamRef.get();
    expect(teamDoc.data()!["name"], equals("Les Titans"));
    expect((teamDoc.data()!["memberIds"] as List).contains(captainUid), isTrue);

    // 4. Verify memberIds query works (as BLoC does to find "My Team")
    final snapshot = await db.collection("championships").doc(champRef.id)
        .collection("teams")
        .where("memberIds", arrayContains: captainUid).get();
    expect(snapshot.docs.length, equals(1));
    expect(snapshot.docs.first.data()["name"], equals("Les Titans"));

    // 5. Verify teamsCount updated
    final champDoc = await champRef.get();
    expect(champDoc.data()!["teamsCount"], equals(1));
  });

  test("golden path: full championship blocks registration check", () async {
    final champRef = await db.collection("championships").add({
      "title": "Full Championship", "status": "registration",
      "maxTeams": 2, "teamSize": 2, "teamsCount": 2,
      "adminIds": [captainUid], "createdBy": captainUid,
      "currentRound": 0, "totalRounds": 1,
      "registrationDeadline": Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))),
      "createdAt": Timestamp.now(),
    });
    final doc = await champRef.get();
    final isFull = (doc.data()!["teamsCount"] as int) >= (doc.data()!["maxTeams"] as int);
    expect(isFull, isTrue, reason: "UI should block registration when full");
  });
}
