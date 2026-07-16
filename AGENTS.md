# Engineering Constitution

## Purpose
Build software that remains modular, testable, secure, observable and easy to change.

## Reading order
1. **Always** start here (`AGENTS.md`) — authority, boundaries, change process, DoD.
2. **Module design** → `docs/architecture/constitution.md` — module shape, exceptions, brownfield.
3. **Ship / migrate / ops risk** → `docs/architecture/operations.md` — migrations, resilience, deps, observability.

Root rules are mandatory. Companion docs explain how to apply them; they do not override this file.

## Authority
1. Security, legal and compliance requirements (including privacy and data-protection duties)
2. This constitution
3. Approved Architecture Decision Records
4. Module-specific rules
5. OpenDray project goal and plan
6. OpenDray project memory
7. Current task instructions
8. Agent assumptions

Conflicts must be reported, not silently resolved by weakening a higher rule.

## Architecture
- Organise software around business capabilities, not technical layers.
- Each capability is a bounded module with one primary responsibility.
- Every module owns its business rules and data.
- Modules communicate only through documented contracts, APIs, commands, queries or events.
- Never access another module's internal code, tables or mutable state directly.
- Shared read models, projections or reporting stores are allowed only with an approved ADR and an explicit owning contract.
- Business logic must not depend directly on frameworks, databases, cloud vendors, message brokers, UI or AI providers.
- Infrastructure connects through ports and adapters.
- Prefer a modular monolith until independent deployment is justified by measurable need.
- Prefer the simplest design that meets current requirements while preserving explicit boundaries.
- Brownfield work may modularise incrementally (strangler pattern); do not require a full rewrite to follow this constitution.

## Change Process
Before substantial implementation:
1. Read this file and relevant architecture documents.
2. Identify the owning module and affected contracts.
3. Inspect existing code, tests and ADRs.
4. Propose the smallest coherent change.
5. Identify compatibility, migration, security and operational impacts.

Prefer, in order: configure existing capability; extend an existing module; add an adapter; add a new module; change a public contract compatibly; introduce a breaking change only with approval and migration plan.

Prefer small reviewable changes where possible; keep every change coherent (do not split an atomic migration and its code across unrelated half-states).

### Work modes
- **Standard delivery** follows this constitution fully.
- **Spikes and prototypes** are time-boxed, isolated from production contracts, and either deleted or rewritten before merge to the mainline.
- **Trivial fixes** (typos, comments, pure formatting) need proportional process: still do no harm, still run relevant checks when risk is non-zero.

### Stop and obtain explicit human approval before
- mutating production data or production configuration
- changing authentication, authorisation or tenancy models
- irreversible or destructive data migrations
- introducing a new external vendor, cloud product or AI provider into a trust boundary
- breaking a public contract
- creating always-on infrastructure or material recurring cost
- any other destructive or hard-to-reverse action

## Contracts and Data
- Each data entity has one owning module.
- Only the owner modifies its data directly.
- Public contracts define purpose, inputs, outputs, errors, authentication, authorisation, versioning, compatibility and idempotency where relevant.
- Prefer additive, backwards-compatible contract changes.
- Deprecate before removal; breaking changes require explicit approval, consumer impact assessment and a migration plan.
- Schema and data changes use expand/contract (or equivalent safe sequencing), stay owned by the data module, preserve deploy-order safety, and never cause irreversible data loss without approval.
- Cross-module consistency at boundaries must define timeouts, idempotency and partial-failure behaviour; security paths fail closed unless an ADR states otherwise.

## Dependencies
- Prefer existing modules and already-approved libraries over new packages.
- Lock or pin dependencies according to project practice.
- Treat new major dependencies, especially on security-sensitive paths, as architectural decisions requiring justification (and an ADR when the dependency becomes a platform choice).

## Testing
- Unit tests cover domain rules.
- Contract tests cover public interfaces.
- Integration tests cover adapters and infrastructure.
- End-to-end tests cover only critical journeys.
- Regression tests accompany defect fixes.
- Never weaken tests merely to make them pass.
- Never skip, quarantine or mark tests flaky without a tracked issue and explicit reason.
- Never use "retry until green" as a fix.
- Never claim a test passed unless it was actually executed successfully.

## Security, Privacy and Operations
- Validate inputs at trust boundaries.
- Apply least privilege.
- Never commit secrets.
- Separate authentication from authorisation.
- Protect sensitive data in logs and telemetry.
- Classify and minimise PII; honour retention, deletion and audit requirements that apply to the system.
- Production-facing modules need structured logs, metrics, health information and correlation identifiers.
- Production paths should have clear operational ownership for alerts and failure response.
- Avoid unbounded queries, lists or fan-out without pagination or hard limits.
- Destructive actions require explicit permission.

## Documentation
Update documentation whenever architecture, contracts, configuration, deployment, security assumptions or operational behaviour changes.

Require an ADR when the change does any of: adds a module; changes data ownership; breaks or version-bumps a public contract incompatibly; introduces a new external system or major dependency; extracts a service; changes authn/authz/tenancy; or adopts a shared datastore or read model across modules.

## Definition of Done
Scale ceremony to risk.

**All changes:** acceptance criteria met (or stated N/A), no unjustified boundary violations, relevant checks run, remaining risks stated.

**Standard and larger changes also:** tests and static checks for the affected surface pass; documentation and ADRs updated when required; local verify path still works; module and contract impact reported; diff reviewed.

A change is not complete if required tests were not executed or results were assumed.

## AI Agent Rules
AI agents must:
- inspect before editing
- preserve established architecture unless a justified change is approved by the authority order
- make assumptions explicit
- prefer small, coherent, reviewable changes
- report conflicts, risks and stop-the-line items early
- treat repository files as authoritative over remembered context, including OpenDray memory
- avoid rewriting another concurrent session's in-progress work without reading the current diff, plan and session context
- report on completion: files changed; module and contract impact; tests actually executed; validation results; documentation updated; remaining risks
