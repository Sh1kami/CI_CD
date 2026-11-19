#!/usr/bin/env bash
set -euo pipefail
files=("${@}")
if ((${#files[@]} == 0)); then
  files=("lab01/greeting.sh" "README.md" "missing.txt")
fi
printf 'file\texists\tread\twrite\tnonempty\texecutable\n'
for file in "${files[@]}"; do
  flags=()
  for property in e r w s x; do
    if test "-$property" "$file"; then flags+=(yes); else flags+=(no); fi
  done
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$file" "${flags[@]}"
done
