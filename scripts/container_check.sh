#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
suffix="$$"
network="panchyshkin-net-$suffix"
volume="panchyshkin-results-$suffix"
container="panchyshkin-app-$suffix"
cleanup() {
  rc=$?
  trap - EXIT
  docker rm -f "$container" >/dev/null 2>&1 || true
  docker network rm "$network" >/dev/null 2>&1 || true
  docker volume rm "$volume" >/dev/null 2>&1 || true
  exit "$rc"
}
trap cleanup EXIT
docker build --target tester -t panchyshkin-cicd:tests .
docker build --target production -t panchyshkin-cicd:lab10 .
docker network create "$network"
docker volume create "$volume"
docker run --rm -v "$volume:/results" python:3.12-slim \
  python -c "from pathlib import Path; Path('/results/owner.txt').write_text('Panchyshkin Bohdan 3PRs/3')"
docker run -d --name "$container" --network "$network" --network-alias app \
  -e APP_PORT=3000 -v "$volume:/results:ro" panchyshkin-cicd:lab10
ready=0
for ((attempt=1; attempt<=40; attempt++)); do
  state=$(docker inspect --format '{{.State.Health.Status}}' "$container")
  if [[ "$state" == healthy ]]; then ready=1; break; fi
  sleep 2
done
((ready == 1)) || { docker logs "$container"; exit 1; }
docker run --rm --network "$network" python:3.12-slim python -c \
  "import urllib.request; print(urllib.request.urlopen('http://app:3000/health').read().decode())"
docker exec "$container" cat /results/owner.txt
docker inspect --format 'state={{.State.Status}} health={{.State.Health.Status}}' "$container"
