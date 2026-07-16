# Architecture Constitution

This document expands `AGENTS.md`. The root constitution remains the mandatory entry point.

## Default Architectural Style
Use a modular monolith with clean or hexagonal boundaries unless an approved ADR states otherwise.

Each module contains:
- domain: entities, value objects and business rules;
- application: use cases, commands, queries and ports;
- adapters: database, messaging, APIs and external integrations;
- contracts: public interfaces and events;
- tests: unit, contract and integration coverage.

## Dependency Direction
Dependencies point towards domain and application logic. Domain code must not import infrastructure or delivery frameworks.

## Module Boundary Template
Every module document must define:
- purpose and owner;
- responsibilities and non-responsibilities;
- owned data;
- commands and queries;
- published and consumed events;
- external dependencies;
- security boundary;
- privacy/data classification where relevant;
- failure modes and resilience behaviour;
- tests and observability ownership.

## Cross-Module Access Exceptions
Direct access to another module's internal code, tables or mutable state is forbidden by default.

Allowed only with an ADR:
- shared read models or reporting projections with a single writer and documented consumers;
- carefully versioned integration databases that are themselves an explicit published contract.

These exceptions must name the owner, compatibility rules and migration path. They are not a shortcut for convenience coupling.

## Brownfield and Incremental Modularisation
Existing layered or tightly coupled systems may adopt this constitution gradually:
- identify business capabilities and provisional module boundaries;
- stop adding new cross-boundary table access;
- extract contracts around the highest-churn seams first;
- move business rules behind module APIs before relocating storage if needed.

Do not demand a big-bang rewrite. Preserve behaviour with tests while boundaries harden.

## Shared Kernel Caution
Share only stable, low-churn primitives (for example identifiers or clock abstractions) when duplication would be worse. Do not grow a shared kernel into a hidden domain layer used by every module.

## Service Extraction
A module may become a separate service only when there is a demonstrated need for independent deployment, scaling, isolation, ownership or technology. Extraction requires an ADR, contract tests, migration and rollback plans, and operational ownership.

## Simplicity
Choose the simplest design satisfying current requirements while preserving explicit boundaries. Do not create speculative services or abstractions.

## Related Documents
- `docs/architecture/operations.md` — migrations, resilience, observability ownership, dependencies and delivery hygiene.
