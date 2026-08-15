# Gatherli — Service Level Objectives (SLOs)

Defines what "working correctly" means quantitatively.
Without these, we can't prioritize bugs or set performance budgets.

---

## User Journey SLOs

| Journey | Availability | p95 Latency | Error Budget |
|---|---|---|---|
| Championship list loads | 99.5% | < 1.0s | 0.5% failures/month |
| Register for championship | 99.0% | < 2.0s | 1% failures/month |
| Propose / accept match schedule | 99.0% | < 2.0s | 1% failures/month |
| Submit game result | 99.0% | < 3.0s | 1% failures/month |
| Championship standings update | 99.0% | < 5.0s | 1% failures/month |
| Send friend request | 99.5% | < 2.0s | 0.5% failures/month |
| Create game | 99.5% | < 2.0s | 0.5% failures/month |
| App cold start to home screen | 99.0% | < 3.0s | 1% failures/month |

---

## Cloud Function SLOs

| Function | p95 Latency | p99 Latency | Error Rate |
|---|---|---|---|
| `confirmMatchSchedule` | < 1.0s | < 2.0s | < 0.5% |
| `rejectMatchSchedule` | < 0.5s | < 1.0s | < 0.5% |
| `startChampionship` | < 5.0s | < 10.0s | < 1% |
| `onChampionshipMatchVerified` | < 3.0s | < 5.0s | < 1% |
| `sendFriendRequest` | < 1.0s | < 2.0s | < 0.5% |
| `acceptFriendRequest` | < 1.0s | < 2.0s | < 0.5% |

---

## How to measure

1. **Firebase Performance Monitoring** — add traces for each user journey:
```dart
final trace = FirebasePerformance.instance.newTrace('championship_list_load');
await trace.start();
// ... fetch data ...
await trace.stop();
```

2. **Cloud Function structured logs** — use `withLogging()` from `functions/src/utils/logger.ts`:
```typescript
export const myFn = functions.https.onCall(withLogging('myFn', handler));
```

3. **Cloud Monitoring alerts** — configure in GCP console:
- Alert when p99 Cloud Function latency > 2s for 5 consecutive minutes
- Alert when error rate > 2% over 10 minutes

---

## Error budget policy

If error budget for a journey is exhausted (e.g., > 1% championship registrations fail):
1. Stop shipping new features that touch that journey
2. Investigate root cause within 24 hours
3. Post-mortem required before resuming feature work
