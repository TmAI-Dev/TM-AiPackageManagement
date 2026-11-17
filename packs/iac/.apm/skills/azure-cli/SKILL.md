---
name: azure-cli
description: "Azure CLI and Az PowerShell operational work for resource management and querying. Uses JMESPath and Resource Graph for inventory operations. Use for Azure operations, resource querying, and cloud management scripting."
---

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
