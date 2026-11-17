---
name: dependency-management
description: "Manages third-party dependencies with vulnerability scanning, version pinning, and safe upgrade strategies. Ensures dependency health through lock files and batch testing. Use for dependency updates, vulnerability response, and dependency cleanup."
---

# Dependency management skill

Use this skill for managing and updating third-party dependencies.

## Standards

- Pin versions and use lock files or central package management
- Read release notes before upgrading
- Upgrade in small, tested batches
- Prefer maintained packages from trusted sources

## Common expectations

- vulnerability scanning in CI
- Dependabot or Renovate configured
- unused dependencies removed
