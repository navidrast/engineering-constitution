# OpenDray Setup Guide

## Operating Model

Use OpenDray for project context and cross-model continuity. Keep permanent engineering policy in the repository and enforce critical rules through CI.

Authority model:
1. Security and legal requirements
2. Repository `AGENTS.md`
3. Approved ADRs
4. Module-specific instructions
5. OpenDray Project Goal and Project Plan
6. OpenDray project memories
7. Current task
8. Agent assumptions

OpenDray memory must never override repository policy.

## Canonical Project Path

OpenDray keys project context by working directory. Clone each repository to one stable absolute path and always start every provider session from that path.

Example:

```bash
mkdir -p /srv/projects
git clone <project-url> /srv/projects/customer-portal
cd /srv/projects/customer-portal
```

Do not open the same project through multiple paths or symlinks.

## Install This Constitution

```bash
git clone https://github.com/navidrast/engineering-constitution.git /tmp/engineering-constitution
/tmp/engineering-constitution/scripts/install-into-project.sh /srv/projects/customer-portal
```

Review and customise the copied module map, system context and project-specific placeholders before committing.

## Configure OpenDray Project Goal

In OpenDray Web or Mobile:

`Memory -> Project -> select the canonical cwd -> Goal`

Use the content in `docs/opendray/project-goal-template.md`. The goal should describe the stable product purpose and point agents to `AGENTS.md`. Do not paste the full constitution into the Goal field.

## Configure OpenDray Project Plan

Go to:

`Memory -> Project -> Plan`

Use `docs/opendray/project-plan-template.md`. The plan contains current phase, priorities, constraints, decisions pending and next steps. Update it as delivery progresses.

## Configure Memories

Project memory contains durable facts specific to the repository: module ownership, important commands, adapters, deployment facts and approved patterns.

Global memory contains only cross-project operator preferences. Use the supplied templates. Avoid temporary debugging state.

## Start Sessions

Every Claude Code, Codex, Antigravity or OpenCode session must use the same canonical cwd. At the beginning of substantial work, ask the agent to read `AGENTS.md`, relevant architecture docs and ADRs, identify the owning module and state the proposed approach.

## Verify Injection

Set a temporary distinctive Project Goal, start two different provider sessions in the same cwd, and ask each to quote the goal exactly and list the repository instruction files it can see.

For Claude Code, run `/memory` to inspect loaded instruction sources.

For Codex under OpenDray, inspect the injected environment where appropriate, but retain the repository's own `AGENTS.md` as the source of truth.

## Completion Contract

Every agent must report:
- files changed;
- module and contract impact;
- tests actually executed;
- validation results;
- documentation updated;
- remaining risks.
