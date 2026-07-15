# Engineering Constitution

## Purpose
Build software that remains modular, testable, secure, observable and easy to change.

## Authority
1. Security, legal and compliance requirements
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
- Business logic must not depend directly on frameworks, databases, cloud vendors, message brokers, UI or AI providers.
- Infrastructure connects through ports and adapters.
- Prefer a modular monolith until independent deployment is justified by measurable need.

## Change Process
Before substantial implementation:
1. Read this file and relevant architecture documents.
2. Identify the owning module and affected contracts.
3. Inspect existing code, tests and ADRs.
4. Propose the smallest coherent change.
5. Identify compatibility, migration, security and operational impacts.

Prefer, in order: configure existing capability; extend an existing module; add an adapter; add a new module; change a public contract compatibly; introduce a breaking change only with approval and migration plan.

## Contracts and Data
- Each data entity has one owning module.
- Only the owner modifies its data directly.
- Public contracts define purpose, inputs, outputs, errors, authentication, authorisation, versioning, compatibility and idempotency where relevant.
- Breaking changes require explicit approval and a migration plan.

## Testing
- Unit tests cover domain rules.
- Contract tests cover public interfaces.
- Integration tests cover adapters and infrastructure.
- End-to-end tests cover only critical journeys.
- Regression tests accompany defect fixes.
- Never weaken tests merely to make them pass.
- Never claim a test passed unless it was actually executed successfully.

## Security and Operations
- Validate inputs at trust boundaries.
- Apply least privilege.
- Never commit secrets.
- Separate authentication from authorisation.
- Protect sensitive data in logs.
- Production-facing modules need structured logs, metrics, health information and correlation identifiers.
- Destructive actions require explicit permission.

## Documentation
Update documentation whenever architecture, contracts, configuration, deployment, security assumptions or operational behaviour changes. Significant decisions require an ADR.

## Definition of Done
A change is complete only when acceptance criteria are met, module boundaries remain valid, tests and static checks pass, documentation is updated, the diff is reviewed, and remaining risks are stated.

## AI Agent Rules
AI agents must inspect before editing, preserve established architecture unless justified, make assumptions explicit, prefer small reviewable changes, report conflicts and risks, and treat repository files as authoritative over remembered context.
