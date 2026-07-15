---
name: design-module
description: Design or extend a module while preserving domain boundaries, contracts, testability and backwards compatibility.
allowed-tools: Read Grep Glob Bash
---

# Design Module

Follow `AGENTS.md` and relevant ADRs.

## Process
1. Identify the business capability, outcomes, rules, security needs and acceptance criteria.
2. Inspect the repository, architecture documents, existing modules, contracts and tests.
3. Determine the owning module and data owner. Create a new module only for a distinct business responsibility.
4. Define responsibilities, non-responsibilities, commands, queries, events, dependencies, failure modes and observability.
5. Select direct interface, API, event, scheduled process or adapter for each interaction and explain why.
6. Assess compatibility, migration, security, deployment and rollback impacts.
7. Define unit, contract, integration and critical end-to-end tests.
8. Present: summary, owner, boundary, contracts, data, dependencies, flow, security, migration, tests, implementation sequence and unresolved risks.

Do not implement until the boundary is coherent and material conflicts are reported.
