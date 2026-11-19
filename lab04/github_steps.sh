#!/usr/bin/env bash
# Run from an authenticated gh session. Approval is performed by xvadim.
set -euo pipefail
: "${GITHUB_OWNER:?Set your GitHub login}"
repo="$GITHUB_OWNER/cicd-panchyshkin"
gh repo create "$repo" --private --clone
cd cicd-panchyshkin
git switch -c lab04
printf '# CI/CD лабораторні\nПанчишкін Богдан Олександрович, 3ПРс/3\n' > README.md
printf 'CI/CD example\n' > example.txt
git add README.md example.txt
git commit -m 'Add laboratory project files'
# A default branch must exist before opening a PR.
git push origin HEAD:main
git switch -c review/lab04
printf '\nReview branch for laboratory 4.\n' >> README.md
git add README.md
git commit -m 'Document review workflow'
git push -u origin review/lab04
gh api --method PUT "repos/$repo/collaborators/xvadim" -f permission=push
gh pr create --repo "$repo" --base main --head review/lab04 \
  --title 'Лабораторна 4 — робота з GitHub' --body-file ../lab04_pr_body.md
# Once xvadim accepts the invitation:
gh pr edit --repo "$repo" --add-reviewer xvadim
# After an actual APPROVED review, merge using GitHub UI or gh pr merge --merge.
