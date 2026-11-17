---
name: git-workflow
description: "Manages Git history with focused commits, clear PR descriptions, and safe branch operations. Maintains readable history and prevents secrets from entering version control. Use for Git workflow planning, commit advice, and PR preparation."
---

# Git workflow skill

Use this skill for Git history, branches, and pull requests.

## Standards

- Small, focused commits with clear messages
- PR descriptions state what, why, and how it was tested
- Warn before destructive or history-rewriting operations
- Prefer `--force-with-lease` over `--force`

## Common expectations

- consistent branch naming
- no secrets in commits
- readable, reviewable history
