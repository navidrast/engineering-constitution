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
  if [[ -e "$TARGET_DIR/$item" ]]; then
    echo "SKIP existing: $item"
  else
    mkdir -p "$(dirname "$TARGET_DIR/$item")"
    cp -R "$SOURCE_DIR/$item" "$TARGET_DIR/$item"
    echo "ADD: $item"
  fi
}

for item in AGENTS.md CLAUDE.md docs/architecture .claude scripts/validate-repository.sh .github/workflows/validate.yml; do
  copy_item "$item"
done

echo "Installed. Review and customise project-specific goal, plan, modules and ADRs before committing."
