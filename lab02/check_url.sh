#!/usr/bin/env bash
set -euo pipefail
env_file=${1:-lab02/.env}
# source executes shell code: use only your own trusted configuration.
[[ -f "$env_file" ]] || { echo "Missing configuration: $env_file" >&2; exit 1; }
set -a
source "$env_file"
set +a
: "${URL:?URL is required}" "${APP_PORT:?APP_PORT is required}"
[[ "$APP_PORT" =~ ^[0-9]{1,5}$ ]] || exit 2
port=$((10#$APP_PORT))
((port >= 1 && port <= 65535)) || exit 2
[[ "$URL" =~ ^https?://[^/:]+$ ]] || { echo 'URL must contain scheme and host only' >&2; exit 2; }
curl --fail --show-error --silent --connect-timeout 3 --max-time 10 "${URL}:${port}/health"
printf '\n'
