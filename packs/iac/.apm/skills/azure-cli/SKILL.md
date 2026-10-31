# Azure CLI skill

Use this skill for Azure CLI and Az PowerShell operational work.

## Standards

- Verify subscription and tenant context before changes
- Query or list before modifying or deleting
- Use `-WhatIf` or equivalent for destructive operations
- Keep secrets out of commands and scripts

## Common expectations

- JMESPath and Resource Graph for inventory
- scripts that are re-runnable and scoped
- stated permissions and verification steps
