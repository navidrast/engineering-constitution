# Claude Code Project Instructions

@AGENTS.md

Before changing code:
1. Read `AGENTS.md`.
2. Read relevant files under `docs/architecture/` (including `operations.md` when migrations, resilience, dependencies or delivery risk apply).
3. Check applicable ADRs and module documentation.
4. Identify the owning module and affected public contracts.
5. Inspect existing implementation and tests.
6. Present a concise implementation approach before broad changes.
7. Escalate stop-the-line items from `AGENTS.md` before implementing them.

Before completing:
1. Run relevant tests.
2. Run linting, static analysis and architecture validation.
3. Review the final diff.
4. Update affected documentation and ADRs when required.
5. Confirm the local verify path still works for standard or larger changes.
6. Report files changed, module/contract impact, tests actually executed, results, documentation updated and remaining risks.

Repository instructions override OpenDray memory when they conflict. Never report an unexecuted test as passing.
