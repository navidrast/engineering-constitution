# Claude Code Project Instructions

@AGENTS.md

Before changing code:
1. Read `AGENTS.md`.
2. Read relevant files under `docs/architecture/`.
3. Check applicable ADRs and module documentation.
4. Identify the owning module and affected public contracts.
5. Inspect existing implementation and tests.
6. Present a concise implementation approach before broad changes.

Before completing:
1. Run relevant tests.
2. Run linting, static analysis and architecture validation.
3. Review the final diff.
4. Update affected documentation.
5. Report files changed, tests actually executed, results and remaining risks.

Repository instructions override OpenDray memory when they conflict. Never report an unexecuted test as passing.
