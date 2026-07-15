# Engineering Constitution

A reusable, model-agnostic software engineering policy for Claude Code, Codex, OpenCode, Antigravity and OpenDray-managed development sessions.

## What this repository provides

- `AGENTS.md`: universal engineering constitution and authority order
- `CLAUDE.md`: Claude Code adapter
- `docs/architecture/`: modular architecture guidance
- `docs/opendray/`: OpenDray goal, plan and memory templates
- `.claude/skills/`: reusable Claude workflows
- `scripts/install-into-project.sh`: non-destructive installer
- `scripts/validate-repository.sh`: structural and basic secret validation
- `.github/workflows/validate.yml`: CI enforcement

## Install into an application

```bash
git clone https://github.com/navidrast/engineering-constitution.git
cd engineering-constitution
bash scripts/install-into-project.sh /absolute/path/to/your-project
```

The installer skips files that already exist. Review and customise the copied project goal, plan, module documentation and ADRs before committing.

## OpenDray model

Use repository files for permanent rules, OpenDray Project Goal for stable purpose, Project Plan for current delivery work, project memory for reusable facts, global memory for cross-project preferences, and CI for hard enforcement.

Read [`docs/opendray/setup-guide.md`](docs/opendray/setup-guide.md) for the configuration process.

## Core principle

OpenDray memory provides context. The repository remains authoritative.
