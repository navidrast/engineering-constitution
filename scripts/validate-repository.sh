#!/usr/bin/env bash
set -euo pipefail

required=(
  AGENTS.md
  CLAUDE.md
  docs/architecture/constitution.md
  docs/architecture/operations.md
  docs/opendray/setup-guide.md
)

for path in "${required[@]}"; do
  [[ -f "$path" ]] || { echo "Missing required file: $path" >&2; exit 1; }
done

if grep -RInE '(AKIA[0-9A-Z]{16}|-----BEGIN (RSA|OPENSSH|EC) PRIVATE KEY-----)' . \
  --exclude-dir=.git --exclude='validate-repository.sh'; then
  echo "Possible committed secret detected" >&2
  exit 1
fi

echo "Engineering constitution structure validated."
