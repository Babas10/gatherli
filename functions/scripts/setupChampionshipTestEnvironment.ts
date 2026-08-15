/**
 * Championship Test Environment Setup Script (Story 30.14)
 *
 * Clears all auth users, the users collection, friendships, and championships,
 * then creates 50 fresh test users and 2 championships from scratch.
 *
 * Users (password: test1010):
 *   test1@mysta.com   — platform admin + male player
 *   test1–20          — male   (gender: male)
 *   test21–41         — female (gender: female)   21 users → 10 teams + 1 extra
 *   test42–50         — no gender set              9 users
 *
 * Championships:
 *   1. Women's Beach Volleyball Open 2026
 *        status: active  |  10/10 teams (test21–40)  |  5/9 rounds completed
 *        standings written, rounds 6–9 pending
 *   2. Men's Beach Volleyball Open 2026
 *        status: registration  |  9/10 teams (test1–18)  |  deadline Jun 10 2026
 *      → test19 + test20 are free (already friends) — log in as test19 to register last team
 *
 * Usage:
 *   cd functions
 *   npx ts-node scripts/setupChampionshipTestEnvironment.ts
 */

import * as admin from "firebase-admin";
import * as fs from "fs";
import * as path from "path";

// ─── Init ────────────────────────────────────────────────────────────────────

admin.initializeApp({ projectId: "gatherli-dev" });

const db   = admin.firestore();
const auth = admin.auth();

const DEFAULT_PASSWORD = "test1010";

// ─── User definitions ─────────────────────────────────────────────────────────

const LAST_NAMES = [
  "One",      "Two",       "Three",     "Four",      "Five",
  "Six",      "Seven",     "Eight",     "Nine",      "Ten",
  "Eleven",   "Twelve",    "Thirteen",  "Fourteen",  "Fifteen",
  "Sixteen",  "Seventeen", "Eighteen",  "Nineteen",  "Twenty",
  "TwentyOne","TwentyTwo", "TwentyThree","TwentyFour","TwentyFive",
  "TwentySix","TwentySeven","TwentyEight","TwentyNine","Thirty",
  "ThirtyOne","ThirtyTwo", "ThirtyThree","ThirtyFour","ThirtyFive",
  "ThirtySix","ThirtySeven","ThirtyEight","ThirtyNine","Forty",
  "FortyOne", "FortyTwo",  "FortyThree","FortyFour", "FortyFive",
  "FortySix", "FortySeven","FortyEight","FortyNine", "Fifty",
];

// index 0 = test1 … index 49 = test50
// test1–20  (0–19)  → male
// test21–41 (20–40) → female
// test42–50 (41–49) → no gender
const TEST_USERS = LAST_NAMES.map((lastName, i) => ({
  n: i + 1,
  email: `test${i + 1}@mysta.com`,
  displayName: `Test${i + 1}`,
  firstName: "Test",
  lastName,
  gender: i < 20 ? "male" : i < 41 ? "female" : undefined as "male" | "female" | undefined,
}));

// ─── Types ────────────────────────────────────────────────────────────────────

interface TestUser {
  uid: string;
  email: string;
  displayName: string;
  n: number;
  gender?: "male" | "female";
}

interface TeamDef {
  teamId: string;
  name: string;
  memberIds: [string, string];
}

interface StandingAcc {
  played: number;
  points: number;
  wins20: number;
  wins21: number;
  losses12: number;
  losses02: number;
  setsWon: number;
  setsLost: number;
}

type ResultKind = "2-0" | "2-1";

interface MatchOutcome {
  round: number;  // 0-indexed
  pair: number;   // 0-indexed within round
  winner: "A" | "B";
  kind: ResultKind;
}

// ─── Cleanup helpers ──────────────────────────────────────────────────────────

async function deleteCollection(collectionPath: string): Promise<number> {
  const ref = db.collection(collectionPath);
  let deleted = 0;
  let snap = await ref.limit(500).get();
  while (!snap.empty) {
    const batch = db.batch();
    snap.docs.forEach((d) => batch.delete(d.ref));
    await batch.commit();
    deleted += snap.size;
    snap = await ref.limit(500).get();
  }
  return deleted;
}

async function deleteUserSubcollections(): Promise<void> {
  const snap = await db.collection("users").get();
  for (const doc of snap.docs) {
    await deleteCollection(`users/${doc.id}/headToHead`);
    await deleteCollection(`users/${doc.id}/ratingHistory`);
  }
}

async function deleteChampionshipSubcollections(): Promise<void> {
  const snap = await db.collection("championships").get();
  for (const doc of snap.docs) {
    for (const sub of ["teams", "matches", "standings"]) {
      await deleteCollection(`championships/${doc.id}/${sub}`);
    }
  }
}

async function clearDatabase(): Promise<void> {
  console.log("\n  Clearing Firestore...");
  await deleteUserSubcollections();
  await deleteChampionshipSubcollections();
  for (const col of ["users", "friendships", "championships", "platform_admins"]) {
    const n = await deleteCollection(col);
    console.log(`    ${col}: ${n} docs deleted`);
  }
}

async function clearAuthUsers(): Promise<void> {
  console.log("\n  Clearing Firebase Auth users...");
  let deleted = 0;
  const deleteAll = async (pageToken?: string): Promise<void> => {
    const result = await auth.listUsers(1000, pageToken);
    for (const u of result.users) {
      await auth.deleteUser(u.uid);
      deleted++;
    }
    if (result.pageToken) await deleteAll(result.pageToken);
  };
  await deleteAll();
  console.log(`    ${deleted} auth users deleted`);
}

// ─── Firestore helpers ────────────────────────────────────────────────────────

function ts(date: Date): admin.firestore.Timestamp {
  return admin.firestore.Timestamp.fromDate(date);
}

function addDays(base: Date, days: number): Date {
  return new Date(base.getTime() + days * 86_400_000);
}

// ─── User creation ────────────────────────────────────────────────────────────

async function createTestUser(
  u: typeof TEST_USERS[number]
): Promise<TestUser> {
  const userRecord = await auth.createUser({
    email: u.email,
    password: DEFAULT_PASSWORD,
    displayName: u.displayName,
    emailVerified: true,
  });

  const now = admin.firestore.Timestamp.now();
  const data: Record<string, unknown> = {
    email: u.email,
    displayName: u.displayName,
    firstName: u.firstName,
    lastName: u.lastName,
    photoUrl: null,
    isEmailVerified: true,
    createdAt: now,
    lastSignInAt: now,
    updatedAt: now,
    isAnonymous: false,
    groupIds: [],
    gameIds: [],
    friendIds: [],
    friendCount: 0,
    notificationsEnabled: true,
    emailNotifications: true,
    pushNotifications: true,
    privacyLevel: "public",
    showEmail: true,
    showPhoneNumber: true,
    gamesPlayed: 0,
    gamesWon: 0,
    gamesLost: 0,
    totalScore: 0,
    currentStreak: 0,
    recentGameIds: [],
    teammateStats: {},
    eloRating: 1600.0,
    eloGamesPlayed: 0,
  };
  if (u.gender) data.gender = u.gender;

  await db.collection("users").doc(userRecord.uid).set(data);

  return { uid: userRecord.uid, email: u.email, displayName: u.displayName, n: u.n, gender: u.gender };
}

// ─── Round-robin fixture (circle method, 10 teams) ───────────────────────────
//
// Round 1: [0,9] [1,8] [2,7] [3,6] [4,5]
// Round 2: [0,8] [9,7] [1,6] [2,5] [3,4]
// Round 3: [0,7] [8,6] [9,5] [1,4] [2,3]
// Round 4: [0,6] [7,5] [8,4] [9,3] [1,2]
// Round 5: [0,5] [6,4] [7,3] [8,2] [9,1]
// Round 6: [0,4] [5,3] [6,2] [7,1] [8,9]
// Round 7: [0,3] [4,2] [5,1] [6,9] [7,8]
// Round 8: [0,2] [3,1] [4,9] [5,8] [6,7]
// Round 9: [0,1] [2,9] [3,8] [4,7] [5,6]

function generateRoundRobin(): Array<Array<[number, number]>> {
  const n = 10;
  const rounds: Array<Array<[number, number]>> = [];
  const rot = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  for (let r = 0; r < n - 1; r++) {
    const pairs: Array<[number, number]> = [];
    pairs.push([0, rot[n - 2]]);
    for (let i = 0; i < (n - 2) / 2; i++) {
      pairs.push([rot[i], rot[n - 3 - i]]);
    }
    rounds.push(pairs);
    rot.unshift(rot.pop()!);
  }
  return rounds;
}

// ─── Match result builder ─────────────────────────────────────────────────────

const SCORES_2_0: Array<Array<{ a: number; b: number }>> = [
  [{ a: 21, b: 15 }, { a: 21, b: 12 }],
  [{ a: 21, b: 13 }, { a: 21, b: 17 }],
  [{ a: 21, b: 18 }, { a: 21, b: 16 }],
  [{ a: 21, b: 11 }, { a: 21, b:  9 }],
  [{ a: 21, b: 14 }, { a: 21, b: 15 }],
];
const SCORES_2_1: Array<Array<{ a: number; b: number }>> = [
  [{ a: 21, b: 16 }, { a: 14, b: 21 }, { a: 15, b: 11 }],
  [{ a: 21, b: 18 }, { a: 17, b: 21 }, { a: 15, b: 13 }],
  [{ a: 21, b: 15 }, { a: 16, b: 21 }, { a: 15, b: 12 }],
];

let scoreVariant = 0;

function makeResult(kind: ResultKind, winner: "teamA" | "teamB"): {
  sets: { teamAPoints: number; teamBPoints: number; setNumber: number }[];
  winner: string;
  teamAPoints: number;
  teamBPoints: number;
} {
  const aWins = winner === "teamA";
  const [champA, champB] = aWins
    ? kind === "2-0" ? [3, 0] : [2, 1]
    : kind === "2-0" ? [0, 3] : [1, 2];

  const raw = kind === "2-0"
    ? SCORES_2_0[scoreVariant % SCORES_2_0.length]
    : SCORES_2_1[scoreVariant % SCORES_2_1.length];
  scoreVariant++;

  const sets = raw.map((s, i) => ({
    setNumber: i + 1,
    teamAPoints: aWins ? s.a : s.b,
    teamBPoints: aWins ? s.b : s.a,
  }));

  return { sets, winner, teamAPoints: champA, teamBPoints: champB };
}

function accumulate(
  acc: StandingAcc,
  kind: ResultKind,
  won: boolean,
  sw: number,
  sl: number
): void {
  acc.played++;
  acc.setsWon  += sw;
  acc.setsLost += sl;
  if (won) {
    acc.points += kind === "2-0" ? 3 : 2;
    if (kind === "2-0") acc.wins20++; else acc.wins21++;
  } else {
    acc.points += kind === "2-1" ? 1 : 0;
    if (kind === "2-1") acc.losses12++; else acc.losses02++;
  }
}

// ─── Pre-defined outcomes for Women's championship rounds 1–5 ────────────────
//
// Verified standings after 5 rounds (pts | set-ratio):
//   1. T0  14 pts  +9   (test21 + test22) — Les Perles
//   2. T1  12 pts  +6   (test23 + test24) — Vagues d'Or
//   3. T2   9 pts  +2   (test25 + test26) — Les Sirènes
//   4. T8   9 pts  +2   (test37 + test38) — Les Dauphines
//   5. T7   8 pts   0   (test35 + test36) — Plage Royale
//   6. T4   7 pts   0   (test29 + test30) — Les Gazelles
//   7. T9   6 pts  -2   (test39 + test40) — Tempête Rose
//   8. T5   4 pts  -5   (test31 + test32) — Étoiles du Sud
//   9. T3   3 pts  -6   (test27 + test28) — Soleil Levant
//  10. T6   3 pts  -6   (test33 + test34) — Filles du Vent

const FEMALE_OUTCOMES: MatchOutcome[] = [
  // Round 1: [0,9] [1,8] [2,7] [3,6] [4,5]
  { round: 0, pair: 0, winner: "A", kind: "2-0" }, // T0 beats T9
  { round: 0, pair: 1, winner: "A", kind: "2-1" }, // T1 beats T8
  { round: 0, pair: 2, winner: "A", kind: "2-0" }, // T2 beats T7
  { round: 0, pair: 3, winner: "B", kind: "2-0" }, // T6 beats T3
  { round: 0, pair: 4, winner: "A", kind: "2-1" }, // T4 beats T5
  // Round 2: [0,8] [9,7] [1,6] [2,5] [3,4]
  { round: 1, pair: 0, winner: "A", kind: "2-0" }, // T0 beats T8
  { round: 1, pair: 1, winner: "B", kind: "2-0" }, // T7 beats T9
  { round: 1, pair: 2, winner: "A", kind: "2-0" }, // T1 beats T6
  { round: 1, pair: 3, winner: "A", kind: "2-1" }, // T2 beats T5
  { round: 1, pair: 4, winner: "A", kind: "2-0" }, // T3 beats T4
  // Round 3: [0,7] [8,6] [9,5] [1,4] [2,3]
  { round: 2, pair: 0, winner: "A", kind: "2-1" }, // T0 beats T7
  { round: 2, pair: 1, winner: "A", kind: "2-0" }, // T8 beats T6
  { round: 2, pair: 2, winner: "A", kind: "2-0" }, // T9 beats T5
  { round: 2, pair: 3, winner: "B", kind: "2-1" }, // T4 beats T1
  { round: 2, pair: 4, winner: "A", kind: "2-0" }, // T2 beats T3
  // Round 4: [0,6] [7,5] [8,4] [9,3] [1,2]
  { round: 3, pair: 0, winner: "A", kind: "2-0" }, // T0 beats T6
  { round: 3, pair: 1, winner: "B", kind: "2-1" }, // T5 beats T7
  { round: 3, pair: 2, winner: "A", kind: "2-0" }, // T8 beats T4
  { round: 3, pair: 3, winner: "A", kind: "2-0" }, // T9 beats T3
  { round: 3, pair: 4, winner: "A", kind: "2-0" }, // T1 beats T2
  // Round 5: [0,5] [6,4] [7,3] [8,2] [9,1]
  { round: 4, pair: 0, winner: "A", kind: "2-0" }, // T0 beats T5
  { round: 4, pair: 1, winner: "B", kind: "2-0" }, // T4 beats T6
  { round: 4, pair: 2, winner: "A", kind: "2-0" }, // T7 beats T3
  { round: 4, pair: 3, winner: "A", kind: "2-1" }, // T8 beats T2
  { round: 4, pair: 4, winner: "B", kind: "2-0" }, // T1 beats T9
];

// ─── Championship 1: Women's Open (ACTIVE, 5/9 rounds done) ──────────────────

async function createWomensChampionship(
  adminUid: string,
  teams: TeamDef[]
): Promise<string> {
  console.log("\n  Building Championship 1 — Women's Open (ACTIVE, 5/9 rounds)...");

  const regDeadline = new Date("2026-01-15T23:59:59Z");
  const startDate   = new Date("2026-02-01T00:00:00Z");

  const champRef = db.collection("championships").doc();
  const champId  = champRef.id;

  await champRef.set({
    title: "Women's Beach Volleyball Open 2026",
    status: "active",
    maxTeams: 10,
    teamSize: 2,
    adminIds: [adminUid],
    createdBy: adminUid,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    registrationDeadline: ts(regDeadline),
    startDate: ts(startDate),
    endDate: null,
    country: "FR",
    region: "Côte d'Azur",
    genderCategory: "female",
    currentRound: 5,
    totalRounds: 9,
    teamsCount: 10,
  });

  // Teams
  const teamsRef = champRef.collection("teams");
  for (const t of teams) {
    await teamsRef.doc(t.teamId).set({
      name: t.name,
      captainId: t.memberIds[0],
      memberIds: t.memberIds,
      createdAt: ts(regDeadline),
    });
  }

  // Matches + standings accumulators
  const fixture = generateRoundRobin();
  const acc: Record<number, StandingAcc> = {};
  for (let i = 0; i < 10; i++) {
    acc[i] = { played:0, points:0, wins20:0, wins21:0, losses12:0, losses02:0, setsWon:0, setsLost:0 };
  }

  const matchesRef = champRef.collection("matches");

  for (let rIdx = 0; rIdx < 9; rIdx++) {
    const roundNum    = rIdx + 1;
    const roundDl     = addDays(startDate, roundNum * 21); // 3-week rounds
    const isCompleted = rIdx < 5;

    for (let pIdx = 0; pIdx < 5; pIdx++) {
      const [a, b] = fixture[rIdx][pIdx];
      const teamAId = teams[a].teamId;
      const teamBId = teams[b].teamId;

      if (isCompleted) {
        const o      = FEMALE_OUTCOMES.find((x) => x.round === rIdx && x.pair === pIdx)!;
        const winner = o.winner === "A" ? "teamA" : "teamB";
        const result = makeResult(o.kind, winner as "teamA" | "teamB");

        const aWon = winner === "teamA";
        const aSW  = result.sets.filter((s) => s.teamAPoints > s.teamBPoints).length;
        const bSW  = result.sets.filter((s) => s.teamBPoints > s.teamAPoints).length;
        accumulate(acc[a], o.kind,  aWon, aSW, bSW);
        accumulate(acc[b], o.kind, !aWon, bSW, aSW);

        const playedAt = addDays(startDate, rIdx * 21 + 14);
        await matchesRef.add({
          round: roundNum,
          teamAId,
          teamBId,
          deadline: ts(roundDl),
          status: "verified",
          scheduledAt: ts(addDays(startDate, rIdx * 21 + 7)),
          location: "Beach Court — Promenade des Anglais",
          result,
          submittedByTeamId:  aWon ? teamAId : teamBId,
          submittedByUserId:  aWon ? teams[a].memberIds[0] : teams[b].memberIds[0],
          verifiedByTeamId:   aWon ? teamBId : teamAId,
          verifiedByUserId:   aWon ? teams[b].memberIds[0] : teams[a].memberIds[0],
          verifiedAt: ts(playedAt),
          adminDecision: null,
          standingsUpdated: true,
        });
      } else {
        await matchesRef.add({
          round: roundNum,
          teamAId,
          teamBId,
          deadline: ts(roundDl),
          status: "pending",
          scheduledAt: null,
          location: null,
          result: null,
          submittedByTeamId: null,
          submittedByUserId: null,
          verifiedByTeamId: null,
          verifiedByUserId: null,
          verifiedAt: null,
          adminDecision: null,
          standingsUpdated: false,
        });
      }
    }
  }

  // Write standings (sorted pts desc → set-ratio desc → team-index asc)
  const ranked = Array.from({ length: 10 }, (_, i) => i).sort((x, y) => {
    if (acc[y].points !== acc[x].points) return acc[y].points - acc[x].points;
    const rx = acc[x].setsWon - acc[x].setsLost;
    const ry = acc[y].setsWon - acc[y].setsLost;
    if (ry !== rx) return ry - rx;
    return x - y;
  });

  const standingsRef = champRef.collection("standings");
  for (let pos = 0; pos < ranked.length; pos++) {
    const idx = ranked[pos];
    const s   = acc[idx];
    await standingsRef.doc(teams[idx].teamId).set({
      teamName: teams[idx].name,
      played:   s.played,
      points:   s.points,
      wins20:   s.wins20,
      wins21:   s.wins21,
      losses12: s.losses12,
      losses02: s.losses02,
      setsWon:  s.setsWon,
      setsLost: s.setsLost,
      position: pos + 1,
    });
  }

  console.log(`  Done: ${champId}  (25 verified + 20 pending matches, standings written)`);
  return champId;
}

// ─── Championship 2: Men's Open (REGISTRATION, 9/10 teams) ───────────────────

async function createMensChampionship(
  adminUid: string,
  teams: TeamDef[]
): Promise<string> {
  console.log("\n  Building Championship 2 — Men's Open (REGISTRATION, 9/10 teams)...");

  const regDeadline = new Date("2026-06-10T23:59:59Z");
  const startDate   = new Date("2026-06-10T00:00:00Z");

  const champRef = db.collection("championships").doc();
  const champId  = champRef.id;

  await champRef.set({
    title: "Men's Beach Volleyball Open 2026",
    status: "registration",
    maxTeams: 10,
    teamSize: 2,
    adminIds: [adminUid],
    createdBy: adminUid,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    registrationDeadline: ts(regDeadline),
    startDate: ts(startDate),
    endDate: null,
    country: "FR",
    region: "Côte d'Azur",
    genderCategory: "male",
    currentRound: 0,
    totalRounds: 9,
    teamsCount: 9,
  });

  const teamsRef = champRef.collection("teams");
  for (const t of teams) {
    await teamsRef.doc(t.teamId).set({
      name: t.name,
      captainId: t.memberIds[0],
      memberIds: t.memberIds,
      createdAt: ts(new Date("2026-05-15T00:00:00Z")),
    });
  }

  console.log(`  Done: ${champId}  (9 teams — 1 slot open for test19)`);
  return champId;
}

// ─── Main ─────────────────────────────────────────────────────────────────────

async function main(): Promise<void> {
  const t0 = Date.now();

  console.log("\n" + "=".repeat(70));
  console.log("CHAMPIONSHIP TEST ENVIRONMENT SETUP");
  console.log("=".repeat(70));
  console.log("\n⚠️  WARNING: This will DELETE all auth users and Firestore user data!\n");

  // 1. Clear everything
  await clearAuthUsers();
  await clearDatabase();

  // 2. Create 50 test users
  console.log("\n  Creating test1–50@mysta.com...");
  const users: TestUser[] = [];
  for (const u of TEST_USERS) {
    const created = await createTestUser(u);
    users.push(created);
    process.stdout.write(`  ${u.n}/50\r`);
  }
  console.log("  50 users created                 ");

  const male     = users.slice(0, 20);  // test1–20
  const female   = users.slice(20, 41); // test21–41
  // noGender   = users.slice(41);      // test42–50

  // 3. test1 becomes platform admin
  console.log("\n  Setting test1 as platform admin...");
  await db.collection("platform_admins").doc(male[0].uid).set({
    createdAt: admin.firestore.Timestamp.now(),
  });
  console.log(`  test1 (${male[0].uid}) is a platform admin`);

  // 4. Friendship: test19 <-> test20 (so they can register as the 10th team)
  console.log("\n  Creating friendship: test19 <-> test20...");
  const test19 = male[18]; // 0-indexed → test19
  const test20 = male[19]; // 0-indexed → test20
  const now = admin.firestore.Timestamp.now();
  await db.collection("friendships").add({
    initiatorId: test19.uid,
    recipientId: test20.uid,
    initiatorName: test19.displayName,
    recipientName: test20.displayName,
    status: "accepted",
    createdAt: now,
    updatedAt: now,
  });
  await db.collection("users").doc(test19.uid).update({
    friendIds: admin.firestore.FieldValue.arrayUnion(test20.uid),
    friendCount: admin.firestore.FieldValue.increment(1),
  });
  await db.collection("users").doc(test20.uid).update({
    friendIds: admin.firestore.FieldValue.arrayUnion(test19.uid),
    friendCount: admin.firestore.FieldValue.increment(1),
  });
  console.log(`  ${test19.displayName} <-> ${test20.displayName}`);

  // 5. Team definitions
  //    Women's: test21–40 (female[0..19]) → 10 teams of 2   (test41 is extra, no team)
  //    Men's:   test1–18  (male[0..17])   →  9 teams of 2   (test19+test20 free)
  const femaleTeamNames = [
    "Les Perles",    "Vagues d'Or",    "Les Sirènes",    "Soleil Levant",
    "Les Gazelles",  "Étoiles du Sud", "Filles du Vent", "Plage Royale",
    "Les Dauphines", "Tempête Rose",
  ];
  const femaleTeams: TeamDef[] = femaleTeamNames.map((name, i) => ({
    teamId: db.collection("_").doc().id,
    name,
    memberIds: [female[i * 2].uid, female[i * 2 + 1].uid],
  }));

  const maleTeamNames = [
    "Les Titans",  "Vague Bleue",  "Sable d'Or",   "Tempête Noire",
    "Les Requins", "Horizon FC",   "Les Guerriers", "Vent du Large",
    "Côte Sauvage",
  ];
  const maleTeams: TeamDef[] = maleTeamNames.map((name, i) => ({
    teamId: db.collection("_").doc().id,
    name,
    memberIds: [male[i * 2].uid, male[i * 2 + 1].uid],
  }));

  // 6. Create championships
  const champ1Id = await createWomensChampionship(male[0].uid, femaleTeams);
  const champ2Id = await createMensChampionship(male[0].uid, maleTeams);

  // 7. Export config
  const config = {
    generatedAt: new Date().toISOString(),
    password: DEFAULT_PASSWORD,
    genderMapping: {
      male:     "test1–test20@mysta.com",
      female:   "test21–test41@mysta.com  (test41 has no team)",
      noGender: "test42–test50@mysta.com",
    },
    admin: {
      email: "test1@mysta.com",
      uid: male[0].uid,
      note: "Platform admin — can use the Create Championship form in-app. Also captain of 'Les Titans' in Men's.",
    },
    championships: {
      womensOpen: {
        id: champ1Id,
        title: "Women's Beach Volleyball Open 2026",
        status: "active",
        currentRound: 5,
        totalRounds: 9,
        teams: femaleTeams.map((t, i) => ({
          teamId: t.teamId,
          name: t.name,
          captain: female[i * 2].email,
          partner: female[i * 2 + 1].email,
        })),
      },
      mensOpen: {
        id: champ2Id,
        title: "Men's Beach Volleyball Open 2026",
        status: "registration",
        teamsCount: 9,
        registrationDeadline: "2026-06-10",
        freeSlot: {
          note: "Log in as test19, pick test20 as partner to register the 10th team",
          captain: { email: test19.email, uid: test19.uid },
          partner: { email: test20.email, uid: test20.uid },
        },
        teams: maleTeams.map((t, i) => ({
          teamId: t.teamId,
          name: t.name,
          captain: male[i * 2].email,
          partner: male[i * 2 + 1].email,
        })),
      },
    },
    quickStart: [
      `Admin / create championship  →  test1@mysta.com   / ${DEFAULT_PASSWORD}`,
      `Women's team captain         →  test21@mysta.com  / ${DEFAULT_PASSWORD}`,
      `Register 10th team (Men's)   →  test19@mysta.com  / ${DEFAULT_PASSWORD}  (partner: test20@mysta.com)`,
      `Gender gate test             →  test42@mysta.com  / ${DEFAULT_PASSWORD}  (no gender set)`,
    ],
  };

  const cfgPath = path.join(__dirname, "championshipTestConfig.json");
  fs.writeFileSync(cfgPath, JSON.stringify(config, null, 2));

  const elapsed = ((Date.now() - t0) / 1000).toFixed(1);
  console.log("\n" + "=".repeat(70));
  console.log("CHAMPIONSHIP TEST ENVIRONMENT READY");
  console.log("=".repeat(70));
  console.log(`\nTime: ${elapsed}s`);
  console.log(`Config exported to: scripts/championshipTestConfig.json\n`);
  console.log(`Quick start (password: ${DEFAULT_PASSWORD}):`);
  console.log(`  Admin / create championship  ->  test1@mysta.com`);
  console.log(`  Women's team captain         ->  test21@mysta.com`);
  console.log(`  Register 10th team (Men's)   ->  test19@mysta.com  (partner: test20)`);
  console.log(`  Gender gate test             ->  test42@mysta.com  (no gender)\n`);
}

// ─── Guard + entry point ──────────────────────────────────────────────────────

if (admin.app().options.projectId !== "gatherli-dev") {
  console.error("ERROR: This script can only run on gatherli-dev!");
  process.exit(1);
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error("\nERROR:", err);
    process.exit(1);
  });
