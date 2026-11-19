#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p evidence
: "${DB_PASSWORD:?Set DB_PASSWORD or export it from your environment}"
export VCS_REF BUILD_DATE
VCS_REF=$(git rev-parse HEAD)
BUILD_DATE=$(date -u +%Y-%m-%dT%H:%M:%SZ)
project="${COMPOSE_PROJECT_NAME:-panchyshkin-ci-$$}"
dc=(docker compose -p "$project" -f compose.yaml -f compose.ci.yaml --profile ci)
cleanup() {
  rc=$?
  trap - EXIT
  "${dc[@]}" logs --no-color > evidence/compose.log 2>&1 || true
  "${dc[@]}" ps -a > evidence/compose-ps.txt 2>&1 || true
  "${dc[@]}" down --volumes --remove-orphans || true
  exit "$rc"
}
trap cleanup EXIT
"${dc[@]}" config --quiet
"${dc[@]}" build
"${dc[@]}" up -d --wait app
"${dc[@]}" run --rm --no-deps tests
