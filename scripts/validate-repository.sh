#!/usr/bin/env bash
set -euo pipefail

required=(
  AGENTS.md
  CLAUDE.md
  docs/architecture/constitution.md
  docs/opendray/setup-guide.md
)

for path in "${required[@]}"; do
  [[ -f "$path" ]] || { echo "Missing required file: $path" >&2; exit 1; }
done

# High-confidence committed-secret sanity check. This is a lightweight gate,
# not a replacement for a dedicated scanner (gitleaks/trufflehog) — it exists
# so an obvious leak fails CI early. Test fixtures, examples and templates
# legitimately contain placeholder keys (e.g. a test asserting the app's own
# secret detector fires on "AKIA…"), so those paths are excluded to avoid
# false positives. Tag any deliberate in-scope match with the marker
# `constitution:allow-secret` on the same line to allowlist it.
secret_hits="$(grep -RInE '(AKIA[0-9A-Z]{16}|-----BEGIN (RSA|OPENSSH|EC) PRIVATE KEY-----)' . \
  --exclude-dir=.git \
  --exclude-dir=node_modules \
  --exclude-dir=vendor \
  --exclude-dir=tests --exclude-dir=test --exclude-dir=__tests__ \
  --exclude-dir=spec --exclude-dir=fixtures --exclude-dir=testdata \
  --exclude='validate-repository.sh' \
  --exclude='*.example' --exclude='*.template' --exclude='*.sample' \
  | grep -v 'constitution:allow-secret' || true)"
if [[ -n "$secret_hits" ]]; then
  echo "Possible committed secret detected:" >&2
  echo "$secret_hits" >&2
  exit 1
fi

echo "Engineering constitution structure validated."
