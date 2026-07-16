#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 /absolute/path/to/project" >&2
  exit 1
fi

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="$(cd "$1" && pwd)"

copy_item() {
  local item="$1"
  if [[ ! -e "$SOURCE_DIR/$item" ]]; then
    # Optional item not present in this constitution version (e.g.
    # docs/development). Skip rather than abort under `set -e` — a missing
    # source used to kill the whole install partway through, leaving the
    # project without validate-repository.sh and the CI workflow.
    echo "SKIP missing source: $item"
  elif [[ -e "$TARGET_DIR/$item" ]]; then
    echo "SKIP existing: $item"
  else
    mkdir -p "$(dirname "$TARGET_DIR/$item")"
    cp -R "$SOURCE_DIR/$item" "$TARGET_DIR/$item"
    echo "ADD: $item"
  fi
}

# docs/opendray is included because validate-repository.sh requires
# docs/opendray/setup-guide.md — omitting it made a fresh install fail its
# own validate.yml CI on the first run.
for item in AGENTS.md CLAUDE.md docs/architecture docs/development docs/opendray .claude scripts/validate-repository.sh .github/workflows/validate.yml; do
  copy_item "$item"
done

echo "Installed. Review and customise project-specific goal, plan, modules and ADRs before committing."
