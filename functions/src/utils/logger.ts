// Structured logger for Cloud Functions.
// All functions should use this instead of console.log/error.
// Emits JSON that Cloud Monitoring parses for latency dashboards and alerts.

export interface FunctionContext {
  fn: string;
  uid?: string;
}

export function startTimer(): number {
  return Date.now();
}

export function logSuccess(ctx: FunctionContext, startMs: number, extra?: object): void {
  console.info(JSON.stringify({
    fn: ctx.fn,
    uid: ctx.uid ?? 'anonymous',
    status: 'success',
    durationMs: Date.now() - startMs,
    ...extra,
  }));
}

export function logError(ctx: FunctionContext, startMs: number, error: unknown): void {
  console.error(JSON.stringify({
    fn: ctx.fn,
    uid: ctx.uid ?? 'anonymous',
    status: 'error',
    durationMs: Date.now() - startMs,
    error: error instanceof Error ? error.message : String(error),
  }));
}

/**
 * Wraps any callable handler with automatic structured timing logs.
 * Usage: export const myFn = functions.https.onCall(withLogging('myFn', handler));
 */
export function withLogging<T>(
  fnName: string,
  handler: (data: unknown, context: unknown) => Promise<T>,
): (data: unknown, context: unknown) => Promise<T> {
  return async (data: unknown, context: unknown): Promise<T> => {
    const start = startTimer();
    const ctx: FunctionContext = {
      fn: fnName,
      uid: (context as { auth?: { uid?: string } }).auth?.uid,
    };
    try {
      const result = await handler(data, context);
      logSuccess(ctx, start);
      return result;
    } catch (error) {
      logError(ctx, start, error);
      throw error;
    }
  };
}
