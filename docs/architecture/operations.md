# Operations, Data and Delivery Companion

This document expands `AGENTS.md`. The root constitution remains the mandatory entry point.

## Migration Discipline
- The module that owns the data owns its migrations.
- Prefer expand/contract:
  1. expand schema in a backwards-compatible way
  2. deploy code that works with old and new shapes
  3. migrate or dual-write data as needed
  4. contract only after old readers/writers are gone
- Migrations must be ordered, repeatable and safe under rolling deploys unless an ADR documents a controlled downtime window.
- Never drop columns, tables or data required by a still-running consumer.
- Irreversible deletions, mass rewrites and production backfills require explicit human approval, a rollback or recovery plan, and a stated blast radius.

## Boundary Resilience
For every public command, query, event consumer or external adapter, define:
- timeout budget
- idempotency key or deduplication strategy where retries are possible
- retry policy (what is safe to retry; what is not)
- partial-failure behaviour
- poison-message / dead-letter handling for async flows

Security, authentication and authorisation failures fail closed unless an approved ADR explicitly chooses fail-open with compensating controls.

## Observability Ownership
Instrumentation without ownership is incomplete. For production-facing modules document:
- structured logs with correlation identifiers
- metrics for golden signals relevant to the module (traffic, errors, latency, saturation as applicable)
- health or readiness signals used by deploy and runtime
- who is paged or responsible when the module fails
- which dashboards, alerts or runbooks apply

Background jobs and async consumers must not be silent: emit success/failure metrics and enough logs to diagnose stuck work.

## Non-Functional Defaults
Unless requirements say otherwise:
- list endpoints and queries are paginated or hard-capped
- avoid N+1 datastore access in hot paths
- do not introduce always-on infrastructure without cost awareness
- prefer bounded queues and explicit back-pressure over unbounded buffering
- user-facing surfaces include loading, empty and error states; accessibility baselines apply when the project ships interactive UI

## Local Verify Path
Every application repository should document:
- how to install dependencies
- required environment variables (never real secrets in git)
- how to run unit, contract and integration tests
- how to start the app locally

Agents must not leave the primary local verify path broken. If a change requires new setup steps, update the docs in the same change.

## Dependency and Supply Chain
- Reuse approved libraries already in the repository when they fit.
- Pin or lock dependencies per project convention.
- New major dependencies need a short justification: problem solved, alternatives considered, security/maintenance posture, and blast radius.
- Platform-level dependency choices (auth SDK, ORM, message bus client, AI provider SDK) require an ADR.

## Contract Evolution
- Additive fields and new optional endpoints are preferred.
- Mark removals as deprecated with a migration window before deletion.
- Publish consumer impact in the PR/ADR: who breaks, how they migrate, and when the old path is removed.
- Event contracts need compatibility rules for both producers and consumers.

## Spikes and Prototypes
Allowed when learning or de-risking. Rules:
- time-box the spike
- keep it out of production contracts and shared module internals when possible
- do not treat spike code as the final architecture by default
- before mainline adoption: rewrite or hard-review against module boundaries, tests and security rules

## Concurrent Agent Sessions
When multiple agents or providers work on the same repository:
- use one canonical working directory for OpenDray context
- prefer one active implementation owner per module or task
- read the current branch diff, plan and session journal before large edits
- append session notes for meaningful progress, blockers and decisions so the next session does not thrash in-progress work

## Escalation Checklist
Stop and ask a human when the work involves production mutation, auth model changes, irreversible data changes, new vendors/AI providers in a trust path, breaking contracts, or material ongoing infrastructure cost. When in doubt, escalate early with options and blast radius rather than inventing policy.
