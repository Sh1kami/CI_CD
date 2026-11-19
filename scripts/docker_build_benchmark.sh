#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p evidence
revision=$(git rev-parse HEAD)
built=$(date -u +%Y-%m-%dT%H:%M:%SZ)
printf 'variant,cache,seconds,bytes\n' > evidence/benchmark.csv
for variant in single multi; do
  file=Dockerfile
  [[ "$variant" != single ]] || file=Dockerfile.single
  for cache in cold warm; do
    options=()
    [[ "$cache" != cold ]] || options+=(--no-cache)
    start=$(date +%s)
    docker build "${options[@]}" -f "$file" --build-arg "VCS_REF=$revision" \
      --build-arg "BUILD_DATE=$built" -t "panchyshkin-cicd:$variant" .
    elapsed=$(( $(date +%s) - start ))
    size=$(docker image inspect "panchyshkin-cicd:$variant" --format '{{.Size}}')
    printf '%s,%s,%s,%s\n' "$variant" "$cache" "$elapsed" "$size" >> evidence/benchmark.csv
  done
done
cat evidence/benchmark.csv
