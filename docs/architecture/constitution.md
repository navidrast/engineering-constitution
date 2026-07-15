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
- failure modes;
- tests and observability.

## Service Extraction
A module may become a separate service only when there is a demonstrated need for independent deployment, scaling, isolation, ownership or technology. Extraction requires an ADR, contract tests, migration and rollback plans, and operational ownership.

## Simplicity
Choose the simplest design satisfying current requirements while preserving explicit boundaries. Do not create speculative services or abstractions.
