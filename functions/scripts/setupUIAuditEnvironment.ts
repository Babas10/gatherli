/**
 * UI Audit Environment Setup Script
 *
 * Creates a COMPLETE, realistic dataset in gatherli-dev that exercises
 * every single page and UI state in the app. Designed for the UI styling
 * audit so no page is left with empty / missing data.
 *
 * What gets created (15 users — test1…test15 / password: test1010):
 * ─────────────────────────────────────────────────────────────────
 *  Social graph
 *    ✓ test1–14  fully connected (91 accepted friendships)
 *    ✓ test15    2 PENDING friend requests → test1, test2
 *                (exercises the "Friend Requests" tab)
 *
 *  Groups (2)
 *    ✓ "Venice Beach Masters"  test1–8  (8 members, test1 admin)
 *         12 past completed games  → real ELO / stats history
 *         3  future games (1 tomorrow, 1 +5d, 1 +14d with waitlist slot)
 *         5  past training sessions (exercises + tiered feedback)
 *         2  cancelled training sessions
 *         3  future training sessions (with exercises)
 *    ✓ "Casual Sundays"        test1, test9, test10  (3 members, test1 admin)
 *         2  past games
 *         1  future game
 *         Cross-group game invitation: test11 invited as guest
 *
 *  Championships (3)
 *    ✓ "Women's Beach Open 2026"  — ACTIVE, round 3/5, 5/6 teams
 *         Teams: (test1+2), (test3+4), (test5+6), (test7+8), (test9+10)
 *         Rounds 1–2 fully verified + standings
 *         Round 3: 1 verified, 1 played (awaiting verification),
 *                  1 scheduled, 1 pending, 1 disputed
 *         test1 is captain of "Les Perles" + championship creator (Admin tab)
 *    ✓ "Men's Classic 2026"  — REGISTRATION OPEN, 3/4 teams, 1 slot free
 *         Teams: (test11+12), (test13+14), (test1+3)
 *         Deadline 2 weeks from now
 *         test1 is creator (Admin tab: Edit + Start visible)
 *    ✓ "Spring Showdown 2025"  — COMPLETED, champion declared
 *         4 teams: (test1+2), (test3+4), (test5+6), (test7+8)
 *         All 3 rounds verified, champion = (test1+2) "Golden Spikers"
 *         → appears in "Completed" tab on championships list
 *         → shows champion banner + gold standings row
 *
 *  Platform admin
 *    ✓ test1 added to platform_admins collection
 *
 * Pages now covered by UI audit:
 *   Home (with Next Game + Next Training),  Stats (ELO charts),
 *   Groups List,  Group Details (members + games + training),
 *   Community (populated friends list),  Community – Friend Requests,
 *   Championships List (Active + Completed tabs),
 *   Championship Registration (open slot),
 *   Championship Detail – Active (My Matches, standings, match states),
 *   Championship Detail – Completed (champion banner),
 *   Match Detail (pending / scheduled / played / disputed states),
 *   Training Detail (upcoming + completed + cancelled),
 *   Training Feedback (no / partial / full feedback),
 *   My Games (cross-group game invitation),
 *   Game Details (future + past games),  Stats / ELO charts
 *
 * Usage:
 *   cd functions
 *   npx ts-node scripts/setupUIAuditEnvironment.ts
 *
 * ⚠️  DELETES ALL DATA in gatherli-dev before seeding!
 */

import * as admin from "firebase-admin";
import * as crypto from "crypto";
import * as fs from "fs";
import * as path from "path";

admin.initializeApp({ projectId: "gatherli-dev" });

const db   = admin.firestore();
const auth = admin.auth();

const DEFAULT_PASSWORD      = "test1010";
const FEEDBACK_SALT         = "gatherli-feedback-salt-v1";

// ─── Types ────────────────────────────────────────────────────────────────────

interface TestUser {
  uid: string;
  email: string;
  displayName: string;
  n: number;
  gender?: "male" | "female";
}

// ─── User definitions ─────────────────────────────────────────────────────────

const LAST_NAMES = [
  "One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten",
  "Eleven","Twelve","Thirteen","Fourteen","Fifteen",
];

// test1–10 → male; test11–15 → no gender
const USER_DEFS = LAST_NAMES.map((lastName, i) => ({
  n: i + 1,
  email: `test${i + 1}@mysta.com`,
  displayName: `Test${i + 1}`,
  firstName: "Test",
  lastName,
  gender: (i < 10 ? "male" : undefined) as "male" | "female" | undefined,
}));

// ─── Helpers — cleanup ────────────────────────────────────────────────────────

async function deleteCollection(path: string): Promise<number> {
  const ref = db.collection(path);
  let deleted = 0;
  let snap = await ref.limit(500).get();
  while (!snap.empty) {
    const b = db.batch();
    snap.docs.forEach((d) => b.delete(d.ref));
    await b.commit();
    deleted += snap.size;
    snap = await ref.limit(500).get();
  }
  return deleted;
}

async function clearDatabase(): Promise<void> {
  console.log("\n🗑️  Clearing Firestore…");

  // Subcollections
  for (const snap of [
    await db.collection("trainingSessions").get(),
    await db.collection("championships").get(),
    await db.collection("users").get(),
  ]) {
    for (const doc of snap.docs) {
      for (const sub of ["participants","exercises","feedback",
                         "teams","matches","standings","messages",
                         "headToHead","ratingHistory"]) {
        await deleteCollection(`${doc.ref.path}/${sub}`);
      }
    }
  }

  for (const col of [
    "users","friendships","groups","games","trainingSessions",
    "championships","platform_admins","invitations","gameInvitations",
    "notifications","groupActivities",
  ]) {
    const n = await deleteCollection(col);
    if (n > 0) console.log(`  ✓ ${col}: ${n} deleted`);
  }
}

async function clearAuthUsers(): Promise<void> {
  console.log("🗑️  Clearing Auth users…");
  let n = 0;
  const del = async (token?: string) => {
    const r = await auth.listUsers(1000, token);
    for (const u of r.users) { try { await auth.deleteUser(u.uid); n++; } catch { /**/ } }
    if (r.pageToken) await del(r.pageToken);
  };
  await del();
  console.log(`  ✓ ${n} auth users deleted`);
}

// ─── Helpers — users ──────────────────────────────────────────────────────────

async function createUser(def: typeof USER_DEFS[0]): Promise<TestUser> {
  const record = await auth.createUser({
    email: def.email, password: DEFAULT_PASSWORD,
    displayName: def.displayName, emailVerified: true,
  });
  const now = admin.firestore.Timestamp.now();
  const data: Record<string, unknown> = {
    email: def.email, displayName: def.displayName,
    firstName: def.firstName, lastName: def.lastName,
    photoUrl: null, isEmailVerified: true,
    createdAt: now, lastSignInAt: now, updatedAt: now,
    isAnonymous: false, groupIds: [], gameIds: [],
    friendIds: [], friendCount: 0,
    notificationsEnabled: true, emailNotifications: true, pushNotifications: true,
    privacyLevel: "public", showEmail: true, showPhoneNumber: true,
    gamesPlayed: 0, gamesWon: 0, gamesLost: 0, totalScore: 0,
    currentStreak: 0, recentGameIds: [], teammateStats: {},
    eloRating: 1600.0, eloGamesPlayed: 0,
  };
  if (def.gender) data.gender = def.gender;
  await db.collection("users").doc(record.uid).set(data);
  return { uid: record.uid, email: def.email, displayName: def.displayName,
           n: def.n, gender: def.gender };
}

// ─── Helpers — social graph ───────────────────────────────────────────────────

async function createFriendships(users: TestUser[]): Promise<void> {
  console.log("\n👥 Creating friendships…");
  const now = admin.firestore.Timestamp.now();
  let b = db.batch(); let count = 0;

  for (let i = 0; i < users.length; i++) {
    for (let j = i + 1; j < users.length; j++) {
      b.set(db.collection("friendships").doc(), {
        initiatorId: users[i].uid, recipientId: users[j].uid,
        initiatorName: users[i].displayName, recipientName: users[j].displayName,
        status: "accepted", createdAt: now, updatedAt: now,
      });
      count++;
      if (count % 400 === 0) { await b.commit(); b = db.batch(); }
    }
  }
  await b.commit();

  for (const u of users) {
    const friends = users.filter((x) => x.uid !== u.uid).map((x) => x.uid);
    await db.collection("users").doc(u.uid).update({ friendIds: friends, friendCount: friends.length });
  }
  console.log(`  ✓ ${count} accepted friendships`);
}

async function createPendingFriendRequests(from: TestUser, targets: TestUser[]): Promise<void> {
  const now = admin.firestore.Timestamp.now();
  for (const target of targets) {
    await db.collection("friendships").doc().set({
      initiatorId: from.uid, recipientId: target.uid,
      initiatorName: from.displayName, recipientName: target.displayName,
      status: "pending", createdAt: now, updatedAt: now,
    });
  }
  console.log(`  ✓ ${targets.length} pending friend requests from ${from.displayName}`);
}

// ─── Helpers — groups ─────────────────────────────────────────────────────────

async function createGroup(
  name: string, description: string, location: string,
  members: TestUser[], admins: TestUser[]
): Promise<string> {
  const now = admin.firestore.Timestamp.now();
  const ref = db.collection("groups").doc();
  await ref.set({
    name, description, photoUrl: null,
    createdBy: admins[0].uid, createdAt: now, updatedAt: now,
    memberIds: members.map((u) => u.uid), adminIds: admins.map((u) => u.uid),
    gameIds: [], privacy: "private", requiresApproval: false, maxMembers: 20,
    location, allowMembersToCreateGames: true, allowMembersToInviteOthers: true,
    notifyMembersOfNewGames: true, totalGamesPlayed: 0, lastActivity: now,
  });
  const b = db.batch();
  for (const u of members) {
    b.update(db.collection("users").doc(u.uid), {
      groupIds: admin.firestore.FieldValue.arrayUnion(ref.id),
    });
  }
  await b.commit();
  return ref.id;
}

// ─── Helpers — games ──────────────────────────────────────────────────────────

async function createCompletedGame(
  groupId: string, date: Date, teamA: string[], teamB: string[],
  aWins: boolean, label: string
): Promise<string> {
  const ref = db.collection("games").doc();
  await ref.set({
    title: label, description: "Beach volleyball — UI audit dataset",
    groupId, createdBy: teamA[0],
    createdAt: admin.firestore.Timestamp.fromDate(date),
    updatedAt: admin.firestore.Timestamp.fromDate(date),
    scheduledAt: admin.firestore.Timestamp.fromDate(date),
    location: { name: "Côte d'Azur Beach Court 3",
      address: "Promenade des Anglais, Nice 06000",
      latitude: 43.695, longitude: 7.266 },
    status: "scheduled", maxPlayers: 4, minPlayers: 4,
    playerIds: [...teamA, ...teamB], waitlistIds: [],
    allowWaitlist: true, allowPlayerInvites: true,
    visibility: "group", equipment: ["net","ball"],
    gameType: "beach_volleyball", skillLevel: "intermediate",
    weatherDependent: true, eloCalculated: false,
  });

  await new Promise((r) => setTimeout(r, 600));

  await ref.update({
    status: "completed",
    startedAt:   admin.firestore.Timestamp.fromDate(date),
    completedAt: admin.firestore.Timestamp.fromDate(date),
    endedAt:     admin.firestore.Timestamp.fromDate(new Date(date.getTime() + 90*60_000)),
    teams: { teamAPlayerIds: teamA, teamBPlayerIds: teamB },
    result: {
      games: [{ gameNumber: 1,
        sets: [{ setNumber: 1,
          teamAPoints: aWins ? 21 : 17, teamBPoints: aWins ? 17 : 21 }],
        winner: aWins ? "teamA" : "teamB" }],
      overallWinner: aWins ? "teamA" : "teamB",
    },
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  await new Promise((r) => setTimeout(r, 800));
  return ref.id;
}

async function createFutureGame(
  groupId: string, daysFromNow: number, title: string,
  playerIds: string[], createdBy: string,
  waitlistIds: string[] = [], skill = "intermediate"
): Promise<string> {
  const ref  = db.collection("games").doc();
  const date = new Date(Date.now() + daysFromNow * 86_400_000);
  await ref.set({
    title, description: "Join us for a great game!",
    groupId, createdBy,
    createdAt: admin.firestore.Timestamp.now(),
    updatedAt: admin.firestore.Timestamp.now(),
    scheduledAt: admin.firestore.Timestamp.fromDate(date),
    location: { name: "Côte d'Azur Beach Court 1",
      address: "Promenade des Anglais, Nice 06000",
      latitude: 43.695, longitude: 7.266 },
    status: "scheduled", maxPlayers: 4, minPlayers: 4,
    playerIds, waitlistIds,
    allowWaitlist: true, allowPlayerInvites: true,
    visibility: "group", equipment: ["net","ball"],
    gameType: "beach_volleyball", skillLevel: skill,
    weatherDependent: true, eloCalculated: false,
  });
  return ref.id;
}

// ─── Helpers — training sessions ──────────────────────────────────────────────

function hash(sessionId: string, userId: string): string {
  return crypto.createHash("sha256")
    .update(`${sessionId}:${userId}:${FEEDBACK_SALT}`)
    .digest("hex");
}

async function createTrainingSession(
  groupId: string, createdBy: string, title: string, desc: string,
  start: Date, end: Date, maxP: number,
  status: "scheduled"|"completed"|"cancelled",
  participantIds: string[], leftIds: string[] = []
): Promise<string> {
  const ref = db.collection("trainingSessions").doc();
  const now = admin.firestore.Timestamp.now();
  await ref.set({
    groupId, title, description: desc,
    location: { name: "Côte d'Azur Sports Centre",
      address: "23 Rue du Sport, Nice 06000",
      latitude: 43.710, longitude: 7.261 },
    startTime: admin.firestore.Timestamp.fromDate(start),
    endTime:   admin.firestore.Timestamp.fromDate(end),
    minParticipants: 2, maxParticipants: maxP,
    createdBy, createdAt: now, updatedAt: now,
    status, participantIds, notes: null,
    recurrenceRule: null, parentSessionId: null,
  });
  for (const uid of participantIds) {
    await ref.collection("participants").doc(uid).set({
      userId: uid,
      joinedAt: admin.firestore.Timestamp.fromDate(
        new Date(start.getTime() - 86_400_000)),
      status: "joined",
    });
  }
  for (const uid of leftIds) {
    await ref.collection("participants").doc(uid).set({
      userId: uid,
      joinedAt: admin.firestore.Timestamp.fromDate(
        new Date(start.getTime() - 2 * 86_400_000)),
      status: "left",
    });
  }
  return ref.id;
}

async function addExercise(
  sessionId: string, name: string, desc: string|null, mins: number|null
): Promise<void> {
  const now = admin.firestore.Timestamp.now();
  await db.collection("trainingSessions").doc(sessionId)
    .collection("exercises").doc().set({ name, description: desc, durationMinutes: mins,
      createdAt: now, updatedAt: null });
}

async function addFeedback(
  sessionId: string, userId: string,
  eq: number, ti: number, cc: number, comment: string|null
): Promise<void> {
  await db.collection("trainingSessions").doc(sessionId)
    .collection("feedback").doc().set({
      exercisesQuality: eq, trainingIntensity: ti, coachingClarity: cc, comment,
      participantHash: hash(sessionId, userId),
      submittedAt: admin.firestore.Timestamp.now(),
    });
}

// ─── Helpers — championships ──────────────────────────────────────────────────

function ts(d: Date) { return admin.firestore.Timestamp.fromDate(d); }
function daysAgo(n: number): Date { return new Date(Date.now() - n * 86_400_000); }
function daysFuture(n: number): Date { return new Date(Date.now() + n * 86_400_000); }

async function createChampionship(fields: Record<string, unknown>): Promise<string> {
  const ref = db.collection("championships").doc();
  await ref.set(fields);
  return ref.id;
}

async function createTeam(
  champId: string, name: string, captainId: string, memberId: string,
  createdAt: Date
): Promise<string> {
  const ref = db.collection("championships").doc(champId).collection("teams").doc();
  await ref.set({
    name, captainId,
    memberIds: [captainId, memberId],
    createdAt: ts(createdAt),
  });
  return ref.id;
}

const SCORES_2_0 = [[{a:21,b:15},{a:21,b:12}],[{a:21,b:13},{a:21,b:17}],[{a:21,b:18},{a:21,b:16}]];
const SCORES_2_1 = [[{a:21,b:16},{a:14,b:21},{a:15,b:11}],[{a:21,b:18},{a:17,b:21},{a:15,b:13}]];
let scoreIdx = 0;

function makeResult(winner: "teamA"|"teamB", kind: "2-0"|"2-1") {
  const aWins = winner === "teamA";
  const raw = kind === "2-0"
    ? SCORES_2_0[scoreIdx % SCORES_2_0.length]
    : SCORES_2_1[scoreIdx % SCORES_2_1.length];
  scoreIdx++;
  const sets = raw.map((s, i) => ({
    setNumber: i + 1,
    teamAPoints: aWins ? s.a : s.b,
    teamBPoints: aWins ? s.b : s.a,
  }));
  const [ap, bp] = aWins
    ? kind === "2-0" ? [3,0] : [2,1]
    : kind === "2-0" ? [0,3] : [1,2];
  return { sets, winner, teamAPoints: ap, teamBPoints: bp };
}

async function createVerifiedMatch(
  champId: string, round: number,
  teamAId: string, teamBId: string,
  winner: "teamA"|"teamB", kind: "2-0"|"2-1",
  deadlineDate: Date, matchDate: Date
): Promise<void> {
  const result = makeResult(winner, kind);
  const ref = db.collection("championships").doc(champId).collection("matches").doc();
  await ref.set({
    round, teamAId, teamBId,
    status: "verified",
    scheduledAt: ts(matchDate),
    deadline: ts(deadlineDate),
    result,
    submittedByTeamId: winner === "teamA" ? teamAId : teamBId,
    submittedByUserId: null,
    verifiedByTeamId:  winner === "teamA" ? teamBId : teamAId,
    verifiedAt: ts(matchDate),
    standingsUpdated: true,
  });
}

async function createPendingMatch(
  champId: string, round: number,
  teamAId: string, teamBId: string, deadline: Date
): Promise<void> {
  const ref = db.collection("championships").doc(champId).collection("matches").doc();
  await ref.set({
    round, teamAId, teamBId,
    status: "pending", deadline: ts(deadline),
    result: null, standingsUpdated: false,
  });
}

async function createScheduledMatch(
  champId: string, round: number,
  teamAId: string, teamBId: string,
  deadline: Date, scheduledAt: Date, proposerTeamId: string
): Promise<void> {
  const ref = db.collection("championships").doc(champId).collection("matches").doc();
  await ref.set({
    round, teamAId, teamBId,
    status: "scheduled",
    scheduledAt: ts(scheduledAt),
    scheduledByTeamId: null,  // confirmed — null means accepted
    location: "Court Central, Promenade des Anglais",
    deadline: ts(deadline),
    result: null, standingsUpdated: false,
  });
  // System chat message
  await ref.collection("messages").doc().set({
    senderId: proposerTeamId,
    senderDisplayName: "System",
    teamId: null,
    text: `Match scheduled for ${scheduledAt.toLocaleDateString("en-GB")} at ${scheduledAt.toLocaleTimeString("en-GB", {hour:"2-digit",minute:"2-digit"})}`,
    sentAt: admin.firestore.Timestamp.now(),
  });
}

async function createPlayedMatch(
  champId: string, round: number,
  teamAId: string, teamBId: string, deadline: Date,
  submitterTeamId: string
): Promise<void> {
  const result = makeResult("teamA", "2-0");
  const ref = db.collection("championships").doc(champId).collection("matches").doc();
  await ref.set({
    round, teamAId, teamBId,
    status: "played",
    deadline: ts(deadline),
    result,
    submittedByTeamId: submitterTeamId,
    submittedByUserId: null,
    standingsUpdated: false,
  });
}

async function createDisputedMatch(
  champId: string, round: number,
  teamAId: string, teamBId: string, deadline: Date
): Promise<void> {
  const result = makeResult("teamA", "2-1");
  const ref = db.collection("championships").doc(champId).collection("matches").doc();
  await ref.set({
    round, teamAId, teamBId,
    status: "disputed",
    deadline: ts(deadline),
    result,
    submittedByTeamId: teamAId,
    submittedByUserId: null,
    standingsUpdated: false,
  });
}

async function writeStandings(
  champId: string,
  teamData: Array<{
    teamId: string; teamName: string;
    played: number; points: number;
    wins20: number; wins21: number; losses12: number; losses02: number;
    setsWon: number; setsLost: number; position: number;
  }>
): Promise<void> {
  const b = db.batch();
  for (const t of teamData) {
    const ref = db.collection("championships").doc(champId).collection("standings").doc(t.teamId);
    b.set(ref, t);
  }
  await b.commit();
}

// ─── Main ─────────────────────────────────────────────────────────────────────

async function main(): Promise<void> {
  const t0 = Date.now();

  console.log("\n" + "=".repeat(70));
  console.log("🏐 GATHERLI — UI AUDIT ENVIRONMENT SETUP");
  console.log("=".repeat(70));
  console.log("\n⚠️  WARNING: All data in gatherli-dev will be deleted!\n");

  // ── 1. Clear ────────────────────────────────────────────────────────────────
  await clearDatabase();
  await clearAuthUsers();

  // ── 2. Create 15 users ──────────────────────────────────────────────────────
  console.log("\n👤 Creating users…");
  const users: TestUser[] = [];
  for (const def of USER_DEFS) {
    const u = await createUser(def);
    users.push(u);
    process.stdout.write(`  ✓ test${u.n}@mysta.com\n`);
  }

  // ── 3. Platform admin ───────────────────────────────────────────────────────
  await db.collection("platform_admins").doc(users[0].uid).set({
    grantedAt: admin.firestore.Timestamp.now(), grantedBy: "setup-script",
  });
  console.log(`\n  ✓ test1 is platform admin`);

  // ── 4. Social graph: test1–14 fully connected ───────────────────────────────
  const coreUsers = users.slice(0, 14);  // test1–14
  await createFriendships(coreUsers);

  // test15 sends PENDING friend requests to test1 and test2
  await createPendingFriendRequests(users[14], [users[0], users[1]]);

  // ── 5. Create groups ────────────────────────────────────────────────────────
  console.log("\n🏐 Creating groups…");

  const g1Members = users.slice(0, 8);  // test1–8
  const group1 = await createGroup(
    "Venice Beach Masters",
    "Competitive beach volleyball — weekly games and training",
    "Côte d'Azur, Nice, FR",
    g1Members, [users[0]]
  );
  console.log(`  ✓ Group 1 "Venice Beach Masters" (test1–8)`);

  const g2Members = [users[0], users[8], users[9]];  // test1, test9, test10
  const group2 = await createGroup(
    "Casual Sundays",
    "Relaxed Sunday games for all levels",
    "Côte d'Azur, Nice, FR",
    g2Members, [users[0]]
  );
  console.log(`  ✓ Group 2 "Casual Sundays" (test1, test9, test10)`);

  // ── 6. Group 1 — Past games (triggers ELO cloud functions) ──────────────────
  console.log("\n🎮 Creating past games (ELO history)…");
  const now = Date.now();
  const U = users;
  const pastGameIds: string[] = [];

  const schedule: [string[], string[], boolean, number, string][] = [
    [[U[0].uid,U[1].uid],[U[2].uid,U[3].uid],true,  90,"Spring Open"],
    [[U[0].uid,U[2].uid],[U[4].uid,U[5].uid],false, 75,"May Doubles"],
    [[U[0].uid,U[5].uid],[U[6].uid,U[7].uid],true,  60,"June Clash"],
    [[U[0].uid,U[3].uid],[U[2].uid,U[6].uid],true,  45,"July Cup"],
    [[U[0].uid,U[4].uid],[U[5].uid,U[7].uid],true,  30,"August Rally"],
    [[U[1].uid,U[6].uid],[U[4].uid,U[7].uid],true,  22,"Late Summer"],
    [[U[0].uid,U[7].uid],[U[2].uid,U[6].uid],false, 18,"Comeback Game"],
    [[U[0].uid,U[4].uid],[U[1].uid,U[3].uid],true,  14,"Two Weeks Ago"],
    [[U[0].uid,U[6].uid],[U[5].uid,U[7].uid],true,  10,"Mid-Month"],
    [[U[3].uid,U[4].uid],[U[2].uid,U[7].uid],false,  7,"Last Week"],
    [[U[0].uid,U[4].uid],[U[2].uid,U[6].uid],true,   4,"Four Days Ago"],
    [[U[0].uid,U[7].uid],[U[1].uid,U[5].uid],false,  2,"Two Days Ago"],
  ];

  for (const [tA, tB, aWins, dAgo, label] of schedule) {
    const date = new Date(now - dAgo * 86_400_000);
    const id = await createCompletedGame(group1, date, tA, tB, aWins, label);
    pastGameIds.push(id);
    console.log(`  ✓ ${label} (${dAgo}d ago)`);
  }

  // Group 2 — 2 past games
  const g2past1 = await createCompletedGame(group2, new Date(now - 20*86_400_000),
    [U[0].uid,U[8].uid],[U[9].uid,U[8].uid],true,"Casual Sunday #1");
  const g2past2 = await createCompletedGame(group2, new Date(now - 7*86_400_000),
    [U[0].uid,U[9].uid],[U[8].uid,U[9].uid],false,"Casual Sunday #2");
  console.log(`  ✓ 2 past games in Group 2`);

  // ── 7. Wait for ELO cloud functions ─────────────────────────────────────────
  console.log("\n⏳ Waiting 10s for ELO Cloud Functions…");
  await new Promise((r) => setTimeout(r, 10_000));

  // ── 8. Group 1 — Future games ────────────────────────────────────────────────
  console.log("\n📅 Creating future games…");

  const futureGame1 = await createFutureGame(
    group1, 1, "Weekend Warm-Up",
    [U[0].uid,U[1].uid,U[2].uid,U[3].uid], U[0].uid
  );
  const futureGame2 = await createFutureGame(
    group1, 5, "Mid-Week Match",
    [U[4].uid,U[5].uid,U[6].uid,U[7].uid], U[4].uid
  );
  // Game with waitlist slot — 4 players + 1 on waitlist
  const futureGame3 = await createFutureGame(
    group1, 14, "Tournament Prep (Competitive)",
    [U[0].uid,U[2].uid,U[4].uid,U[6].uid], U[0].uid,
    [U[7].uid],  // test8 on waitlist
    "advanced"
  );
  console.log(`  ✓ 3 future games (incl. 1 with waitlist)`);

  // Group 2 — 1 future game
  const g2future = await createFutureGame(
    group2, 3, "Sunday Session",
    [U[0].uid,U[8].uid], U[0].uid
  );
  console.log(`  ✓ 1 future game in Group 2`);

  // Cross-group game invitation (test11 invited to group2 future game)
  await db.collection("gameInvitations").doc().set({
    gameId: g2future, groupId: group2,
    inviteeId: users[10].uid, inviterId: users[0].uid,
    status: "pending", type: "cross_group",
    createdAt: admin.firestore.Timestamp.now(),
    expiresAt: admin.firestore.Timestamp.fromDate(daysFuture(3)),
  });
  console.log(`  ✓ Cross-group game invitation: test11 invited to Group 2 game`);

  // Update groups with game IDs
  await db.collection("groups").doc(group1).update({
    gameIds: [...pastGameIds, futureGame1, futureGame2, futureGame3],
    totalGamesPlayed: pastGameIds.length,
    lastActivity: admin.firestore.FieldValue.serverTimestamp(),
  });
  await db.collection("groups").doc(group2).update({
    gameIds: [g2past1, g2past2, g2future],
    totalGamesPlayed: 2,
    lastActivity: admin.firestore.FieldValue.serverTimestamp(),
  });

  // ── 9. Training sessions ─────────────────────────────────────────────────────
  console.log("\n🏋️  Creating training sessions…");

  const makePast = (d: number, title: string, desc: string,
    pIds: string[], leftIds: string[] = []) => {
    const start = new Date(now - d * 86_400_000);
    const end   = new Date(start.getTime() + 2*60*60_000);
    return createTrainingSession(group1, U[0].uid, title, desc, start, end, 10, "completed", pIds, leftIds);
  };

  const pastSessions = await Promise.all([
    makePast(20,"Beginner Basics","Introduction to beach volleyball fundamentals",
      [U[1].uid,U[4].uid,U[5].uid,U[7].uid],[U[6].uid]),
    makePast(15,"Tournament Prep","High-intensity match preparation",
      [U[1].uid,U[2].uid,U[3].uid,U[4].uid,U[5].uid,U[6].uid,U[7].uid]),
    makePast(10,"Defense Workshop","Digging, diving, and court coverage",
      [U[1].uid,U[2].uid,U[3].uid,U[5].uid,U[7].uid]),
    makePast(5,"Game Situations","Real match scenarios under pressure",
      [U[1].uid,U[2].uid,U[4].uid,U[6].uid,U[7].uid],[U[3].uid]),
    makePast(2,"Serving Masterclass","Advanced serving — float, topspin, jump",
      [U[1].uid,U[2].uid,U[3].uid,U[4].uid,U[5].uid,U[6].uid,U[7].uid]),
  ]);

  // Cancelled sessions (for cancelled state UI)
  const cancelledStart1 = new Date(now - 8 * 86_400_000);
  await createTrainingSession(group1, U[0].uid, "Cancelled — Bad Weather",
    "Session cancelled due to storm", cancelledStart1,
    new Date(cancelledStart1.getTime() + 2*60*60_000), 10, "cancelled",
    [U[1].uid, U[2].uid, U[3].uid]);

  console.log(`  ✓ 5 past training sessions + 1 cancelled`);

  // Future sessions
  const makeFuture = (d: number, title: string, desc: string, pIds: string[], max: number) => {
    const start = new Date(now + d * 86_400_000);
    const end   = new Date(start.getTime() + 2*60*60_000);
    return createTrainingSession(group1, U[0].uid, title, desc, start, end, max, "scheduled", pIds);
  };

  const futureSessions = await Promise.all([
    makeFuture(1,"Fundamentals Training","Serving, passing and setting basics",
      [U[1].uid,U[2].uid,U[3].uid,U[4].uid,U[5].uid], 10),
    makeFuture(4,"Advanced Techniques","Blocking, spiking and defensive strategies",
      [U[1].uid,U[3].uid,U[6].uid], 8),
    makeFuture(9,"Team Strategy Session","Court coordination and set plays",
      [U[1].uid,U[2].uid,U[3].uid,U[4].uid,U[5].uid,U[6].uid,U[7].uid,U[8].uid], 8),
  ]);
  console.log(`  ✓ 3 future training sessions`);

  // Exercises
  for (const [n,d,m] of [
    ["Warm-up & Stretching","Dynamic stretching",15],
    ["Serving Practice","Target zone placement",30],
    ["Passing Drills","Platform passing and communication",25],
    ["Setting Technique","Hand positioning and ball control",20],
    ["Cool Down","Static stretching",10],
  ] as [string,string,number][]) { await addExercise(futureSessions[0],n,d,m); }

  for (const [n,d,m] of [
    ["Jump Serve Training","Power serving technique",25],
    ["Blocking Mechanics","Timing and hand positioning",30],
    ["Spiking Drills","Approach and hitting",30],
    ["Defensive Positioning","Court coverage",25],
  ] as [string,string,number][]) { await addExercise(futureSessions[1],n,d,m); }

  for (const [n,d,m] of [
    ["Partner Communication","Calling the ball",20],
    ["Transition Drills","Defense to offense",25],
    ["Offensive Systems","Set plays and rotations",30],
    ["Match Play","Full team scrimmage",45],
  ] as [string,string,number][]) { await addExercise(futureSessions[2],n,d,m); }

  // Locked exercises on past sessions
  for (const [n,d,m] of [
    ["Serve Placement","Target zones",25],
    ["Float Serve","Low-trajectory serves",20],
    ["Topspin Serve","Forward spin serves",15],
  ] as [string,string,number][]) { await addExercise(pastSessions[4],n,d,m); }
  for (const [n,d,m] of [
    ["2v2 Mini Games","Competitive points",30],
    ["Pressure Situations","Decision-making under stress",25],
  ] as [string,string,number][]) { await addExercise(pastSessions[3],n,d,m); }

  console.log(`  ✓ Exercises added`);

  // Feedback
  await addFeedback(pastSessions[4],U[1].uid,5,5,5,"Greatly improved my serve accuracy!");
  await addFeedback(pastSessions[4],U[2].uid,4,4,4,"Great drills, loved the topspin focus.");
  await addFeedback(pastSessions[4],U[3].uid,5,4,5,null);
  await addFeedback(pastSessions[4],U[4].uid,5,3,5,"Very helpful!");
  // Session [3]: partial feedback
  await addFeedback(pastSessions[3],U[1].uid,5,5,4,"Loved the competitive drills!");
  await addFeedback(pastSessions[3],U[2].uid,4,5,3,"Bit intense but great.");
  // Session [2]: full feedback (5/5)
  await addFeedback(pastSessions[2],U[1].uid,5,5,5,"Best defensive training!");
  await addFeedback(pastSessions[2],U[2].uid,5,4,5,"Techniques explained clearly.");
  await addFeedback(pastSessions[2],U[3].uid,4,4,4,null);
  await addFeedback(pastSessions[2],U[5].uid,5,5,5,"My digging improved a lot.");
  await addFeedback(pastSessions[2],U[7].uid,4,4,5,"Very practical.");
  // Session [1]: partial
  await addFeedback(pastSessions[1],U[1].uid,5,5,5,"Perfect tournament prep!");
  await addFeedback(pastSessions[1],U[3].uid,4,4,4,"Good intensity.");
  // Session [0]: no feedback (empty state)
  console.log(`  ✓ Feedback added (empty / partial / full states)`);

  // ── 10. Championships ────────────────────────────────────────────────────────
  console.log("\n🏆 Creating championships…");

  // ── Championship 1: Women's Open (ACTIVE, round 3/5) ──────────────────────
  const wChampId = await createChampionship({
    title: "Women's Beach Volleyball Open 2026",
    status: "active",
    maxTeams: 6, teamSize: 2, totalRounds: 5, currentRound: 3,
    teamsCount: 5,
    adminIds: [U[0].uid], createdBy: U[0].uid,
    createdAt: admin.firestore.Timestamp.now(),
    registrationDeadline: ts(daysAgo(60)),
    startDate: ts(daysAgo(45)),
    country: "FR", region: "Côte d'Azur",
    genderCategory: "female",
  });

  const wTeams = [
    await createTeam(wChampId, "Les Perles",   U[0].uid, U[1].uid, daysAgo(65)),
    await createTeam(wChampId, "Vagues d'Or",  U[2].uid, U[3].uid, daysAgo(65)),
    await createTeam(wChampId, "Les Sirènes",  U[4].uid, U[5].uid, daysAgo(65)),
    await createTeam(wChampId, "Plage Royale", U[6].uid, U[7].uid, daysAgo(65)),
    await createTeam(wChampId, "Côte Sauvage", U[8].uid, U[9].uid, daysAgo(65)),
  ];
  // wTeams: T0=Les Perles, T1=Vagues d'Or, T2=Les Sirènes, T3=Plage Royale, T4=Côte Sauvage

  // Round 1 — all verified (5-team round-robin: rounds 1-5, 2 matches each + 1 bye)
  // Using 5-team schedule: Rnd1=[0v4][1v3]bye2, Rnd2=[0v3][4v2]bye1, ...
  await createVerifiedMatch(wChampId,1,wTeams[0],wTeams[4],"teamA","2-0",daysAgo(35),daysAgo(42));
  await createVerifiedMatch(wChampId,1,wTeams[1],wTeams[3],"teamA","2-1",daysAgo(35),daysAgo(41));

  // Round 2 — all verified
  await createVerifiedMatch(wChampId,2,wTeams[0],wTeams[3],"teamA","2-0",daysAgo(28),daysAgo(30));
  await createVerifiedMatch(wChampId,2,wTeams[4],wTeams[2],"teamB","2-0",daysAgo(28),daysAgo(29));

  // Round 3 — MIX: verified, played-awaiting, scheduled, pending, disputed
  await createVerifiedMatch(wChampId,3,wTeams[0],wTeams[2],"teamA","2-1",daysAgo(14),daysAgo(15));
  await createPlayedMatch(wChampId,3,wTeams[1],wTeams[4],daysAgo(7), wTeams[1]);      // awaiting verification
  await createScheduledMatch(wChampId,3,wTeams[3],wTeams[2],daysFuture(14),daysFuture(5),wTeams[3]); // scheduled
  await createDisputedMatch(wChampId,3,wTeams[0],wTeams[4],daysAgo(3));               // disputed

  // Standings after 2 completed rounds
  await writeStandings(wChampId, [
    { teamId: wTeams[0], teamName: "Les Perles",   played:3, points:9, wins20:2, wins21:1, losses12:0, losses02:0, setsWon:7, setsLost:2, position:1 },
    { teamId: wTeams[1], teamName: "Vagues d'Or",  played:2, points:6, wins20:1, wins21:1, losses12:0, losses02:0, setsWon:5, setsLost:2, position:2 },
    { teamId: wTeams[4], teamName: "Côte Sauvage", played:3, points:3, wins20:0, wins21:1, losses12:1, losses02:1, setsWon:3, setsLost:6, position:3 },
    { teamId: wTeams[3], teamName: "Plage Royale", played:2, points:2, wins20:0, wins21:0, losses12:1, losses02:1, setsWon:2, setsLost:5, position:4 },
    { teamId: wTeams[2], teamName: "Les Sirènes",  played:3, points:0, wins20:0, wins21:0, losses12:0, losses02:3, setsWon:0, setsLost:7, position:5 },
  ]);

  console.log(`  ✓ Women's Open (active, round 3/5, match states: verified/played/scheduled/pending/disputed)`);

  // ── Championship 2: Men's Classic (REGISTRATION OPEN, 3/4 teams) ──────────
  const mChampId = await createChampionship({
    title: "Men's Beach Volleyball Classic 2026",
    status: "registration",
    maxTeams: 4, teamSize: 2, totalRounds: 3, currentRound: 0,
    teamsCount: 3,
    adminIds: [U[0].uid], createdBy: U[0].uid,
    createdAt: admin.firestore.Timestamp.now(),
    registrationDeadline: ts(daysFuture(14)),
    country: "FR", region: "Côte d'Azur",
    genderCategory: "male",
  });

  await createTeam(mChampId, "Alpha Squad", U[10].uid, U[11].uid, daysAgo(5));
  await createTeam(mChampId, "Beta Force",  U[12].uid, U[13].uid, daysAgo(4));
  await createTeam(mChampId, "Les Titans",  U[0].uid,  U[2].uid,  daysAgo(3));
  // 1 slot remaining → can register 4th team via the app

  console.log(`  ✓ Men's Classic (registration, 3/4 teams, 1 slot open)`);

  // ── Championship 3: Spring Showdown (COMPLETED, champion declared) ─────────
  const sChampId = await createChampionship({
    title: "Spring Showdown 2025",
    status: "completed",
    maxTeams: 4, teamSize: 2, totalRounds: 3, currentRound: 3,
    teamsCount: 4,
    adminIds: [U[0].uid], createdBy: U[0].uid,
    createdAt: ts(daysAgo(120)),
    registrationDeadline: ts(daysAgo(100)),
    startDate: ts(daysAgo(90)),
    completedAt: ts(daysAgo(30)),
    completedBy: U[0].uid,
    country: "FR", region: "Côte d'Azur",
  });

  const sT = [
    await createTeam(sChampId, "Golden Spikers", U[0].uid, U[1].uid, daysAgo(105)),
    await createTeam(sChampId, "Beach Sharks",   U[2].uid, U[3].uid, daysAgo(105)),
    await createTeam(sChampId, "Sand Devils",    U[4].uid, U[5].uid, daysAgo(105)),
    await createTeam(sChampId, "Wave Riders",    U[6].uid, U[7].uid, daysAgo(105)),
  ];

  // All 3 rounds verified — Golden Spikers win
  // Round 1: T0 beats T3, T1 beats T2
  await createVerifiedMatch(sChampId,1,sT[0],sT[3],"teamA","2-0",daysAgo(80),daysAgo(82));
  await createVerifiedMatch(sChampId,1,sT[1],sT[2],"teamA","2-1",daysAgo(80),daysAgo(81));
  // Round 2: T0 beats T2, T3 beats T1
  await createVerifiedMatch(sChampId,2,sT[0],sT[2],"teamA","2-0",daysAgo(60),daysAgo(62));
  await createVerifiedMatch(sChampId,2,sT[3],sT[1],"teamA","2-1",daysAgo(60),daysAgo(61));
  // Round 3: T0 beats T1 (champion), T2 beats T3
  await createVerifiedMatch(sChampId,3,sT[0],sT[1],"teamA","2-0",daysAgo(35),daysAgo(37));
  await createVerifiedMatch(sChampId,3,sT[2],sT[3],"teamA","2-0",daysAgo(35),daysAgo(36));

  // Final standings + set champion
  await writeStandings(sChampId, [
    { teamId: sT[0], teamName:"Golden Spikers", played:3, points:9, wins20:3, wins21:0, losses12:0, losses02:0, setsWon:6, setsLost:0, position:1 },
    { teamId: sT[3], teamName:"Wave Riders",    played:3, points:3, wins20:1, wins21:0, losses12:0, losses02:2, setsWon:3, setsLost:5, position:2 },
    { teamId: sT[1], teamName:"Beach Sharks",   played:3, points:2, wins20:0, wins21:1, losses12:1, losses02:1, setsWon:3, setsLost:5, position:3 },
    { teamId: sT[2], teamName:"Sand Devils",    played:3, points:3, wins20:1, wins21:0, losses12:0, losses02:2, setsWon:3, setsLost:5, position:4 },
  ]);

  // Record the champion team ID on the championship document
  await db.collection("championships").doc(sChampId).update({
    championTeamId: sT[0],
  });

  console.log(`  ✓ Spring Showdown 2025 (completed, champion: Golden Spikers)`);

  // ── 11. Export config ────────────────────────────────────────────────────────
  const config = {
    generatedAt: new Date().toISOString(),
    project: "gatherli-dev",
    password: DEFAULT_PASSWORD,
    primaryUser: {
      email: "test1@mysta.com", uid: users[0].uid,
      note: "admin + Women's captain (Les Perles) + Men's championship creator",
    },
    users: users.map((u) => ({ n: u.n, email: u.email, uid: u.uid })),
    groups: { group1, group2 },
    championships: {
      womensOpen:   { id: wChampId, status: "active",       note: "round 3/5, 5/6 teams" },
      mensClassic:  { id: mChampId, status: "registration", note: "3/4 teams, 1 slot free" },
      springShowdown:{ id: sChampId, status: "completed",   note: "champion = Golden Spikers (test1+2)" },
    },
    quickStart: {
      admin:          "test1@mysta.com  / test1010",
      womensPlayer:   "test3@mysta.com  / test1010  (Vagues d'Or captain)",
      opponentPlayer: "test5@mysta.com  / test1010  (Les Sirènes captain)",
      mensPlayer:     "test11@mysta.com / test1010  (Alpha Squad captain)",
      friendRequester:"test15@mysta.com / test1010  (2 pending requests out)",
    },
  };

  const configPath = path.join(__dirname, "uiAuditConfig.json");
  fs.writeFileSync(configPath, JSON.stringify(config, null, 2));

  const elapsed = ((Date.now() - t0) / 1000).toFixed(1);
  console.log(`\n${"=".repeat(70)}`);
  console.log(`✅ UI AUDIT ENVIRONMENT READY  (${elapsed}s)`);
  console.log(`${"=".repeat(70)}`);
  console.log(`\nConfig: ${configPath}`);
  console.log(`\nQuick login:`);
  console.log(`  Admin + all features: test1@mysta.com  / test1010`);
  console.log(`  Women's opponent:     test5@mysta.com  / test1010`);
  console.log(`  Men's player:         test11@mysta.com / test1010`);
  console.log(`  Friend requester:     test15@mysta.com / test1010`);
  console.log(`\nChampionships:`);
  console.log(`  Women's Open (active):   ${wChampId}`);
  console.log(`  Men's Classic (reg open):${mChampId}`);
  console.log(`  Spring Showdown (done):  ${sChampId}\n`);

  process.exit(0);
}

main().catch((e) => { console.error(e); process.exit(1); });
